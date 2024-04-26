# Vivobook Pro Ubuntu 24.04 installation notes

Since I struggled to had the keyboard working on the new Asus Vivobook Pro laptop, these are the steps (and some references) that I roughly followed.

Useful links:

- [Italian Forum](https://forum.ubuntu-it.org/viewtopic.php?f=9&t=652528&sid=165722e6ac2f21abf4ba85807d634ab6&start=20)
- [Patch discussion](https://bugzilla.kernel.org/show_bug.cgi?id=217323)
- [Arch guide](https://bbs.archlinux.org/viewtopic.php?id=z277260)

Essentially I had to modify the kernel, compile it and install it.

1. Install the Ubuntu source for the kernel:
```
sudo apt install linux-source
```
2. The source code should be located in `/usr/src/linux-source-<version>` (or maybe as a TarBall).
At this point I had to add my laptop to the file that configures the interrup requests.
In particular the source code is located in `driverse/acpi/resource.c`.
Search for the string `Vivobook`, there should be roughly 6 of them. Among them, insert
```
	{
		/* Asus Vivobook N6506MV */
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
		},
	},
```
3. In the `.config` file remove the key signatures (`CONFIG_SYSTEM_TRUSTED_KEYRING=n`) and then build the kernel as a debian package:
```
sudo make bindeb-pkg -j10  # Set here the number of cores available
```
4. Install debian packages, generated in the parent folder:
```
sudo dpkg -i ../linux-*.deb
```


After that, I also had issue with graphical drivers. I fixed by installing a newer version:
```
sudo apt install nvidia-driver-550
```
