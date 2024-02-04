# Starting packages
To use ROS firstly we need to enable the **ROS core**:
```shell
roscore
```

# Packages
In order to **start** any other **package**:
```shell
roslaunch [package_name] [script.launch, optional]
```
Packages are used to organize programs, and inside them are containing the launch files used to actually launch the desired package.

A **package** is a folder containing:
- `launch`: a folder containing the _.launch_ files;
- `src`: a folder containing the source code of the package (python, cpp);
- `CMakeLists.txt`: cmake rules for compilation;
- `package.xml`: contains information and dependencies.

We can navigate easily access packages with the command
```
roscd [package_name]
```
## Catkin
All packages must lie inside a so called **catkin workspace**; we can go there by calling `roscd` without argument. 
Assumed that `~/catkin_ws` is the root of the ROS workspace, inside it we should found a folder `src` that will contain all custom packages.

We can look for all available packages with
```
rospack list
```
Furthermore we can filter using `grep`:
```
rospack list | grep [keyward]
```

## Launch files
The folder `launch` of each package contains tags and parameters for starting it. Example:
```
<launch>
  <!-- turtlebot_teleop_key already has its own built in velocity smoother -->
  <node pkg="turtlebot_teleop" type="turtlebot_teleop_key.py" name="turtlebot_teleop_keyboard"  output="screen">
    <param name="scale_linear" value="0.5" type="double"/>
    <param name="scale_angular" value="1.5" type="double"/>
    <remap from="turtlebot_teleop_keyboard/cmd_vel" to="/cmd_vel"/>   <!-- cmd_vel_mux/input/teleop"/-->
  </node>
</launch>
```

Inside each `<launch>` tag we see a `<node>` tag containig:
- `pkg=[package_name]`: the name of the package containing the code of the ROS program that we need to execute;
- `type=[file_name.py]`: name of the file that we want to execute. To avoid problems at runtime, remember to have script that are executable (`chmod +x [file_name.py]`);
- `name=[node_name]`: name of the ROS node that will launch the python file;
- `ouput=[output_source]`: through which channel output of the scripts will be printed.  

# Creating a package
In order to create a package:
```
catkin_create_pkg [package_name] [dependencies]
```
where the dependencies are other packages names that are required in order to properly run the new package. 
Dependencies can be set afterward, but be specifying them here the `.xml` file will be automatically generated.

If a yet generated package do not appear in the package list, manually refresh the packs:
```
rospack profile
```