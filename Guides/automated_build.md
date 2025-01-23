# C++ Automated Build and Test on Save

Using the `inotifywait` command line tool, we can monitor a directory for changes (e.g., when a file gets saved) and automatically run some hooks.

In this case we will use it to automatically build the C++ code, run the tests (if build was successfull) and, if the tests pass, run the program.

To complement this, we will use `notify-send` to display a notification when the build fails or the tests fail.

## Preliminaries 

- Make sure you have `inotify-tools` installed. 
  You can install it using `sudo apt install inotify-tools` on Ubuntu;
- make sure you have `libnotify-bin` installed. 
  You can install it using `sudo apt install libnotify-bin` on Ubuntu;
- the script assumes that the C++ system is built using [CMake](https://cmake.org/); 
- the project's build directory is already configures (the script doesn't call `cmake` to configure the project);
- the script relies on the `ctest` command to run the tests. 
  You may refer to [this guide](https://cmake.org/cmake/help/book/mastering-cmake/chapter/Testing%20With%20CMake%20and%20CTest.html) to learn how to configure the tests in a `CMakeLists.txt` file.


## The script

``` bash
#!/bin/bash

# Update these parameters as needed
WATCH_DIRS="./src ./include"
BUILD_DIR=build
EXECUTABLE="$BUILD_DIR/<...>"


START_BUILD_ICON=applications-system-symbolic
SUCCESS_ICON=emblem-ok-symbolic
FAILED_ICOND=emblem-important-symbolic

echo "Watching directories $WATCH_DIRS"
echo "Build directory: $BUILD_DIR"
echo ""

while true; do
    inotifywait -e close_write,modify,moved_to,create -r $WATCH_DIRS
    clear
    
    notify-send "Starting build proces..." -i $START_BUILD_ICON
    cmake --build $BUILD_DIR --parallel
    if [ $? -eq 0 ]; then
        notify-send "Build successful!" -i $SUCCESS_ICON
    else
        notify-send "Build failed!" -i $FAILED_ICOND
        continue
    fi

    ctest --test-dir $BUILD_DIR
    if [ $? -eq 0 ]; then
        notify-send "Tests passed!" -i $SUCCESS_ICON
    else
        notify-send "Some tests failed!" -i $FAILED_ICOND
        cat $BUILD_DIR/Testing/Temporary/LastTest.log
        continue
    fi

    if [ -z "$EXECUTABLE" ]; then
        echo "No executable provided"
    elif [ ! -x "$EXECUTABLE" ]; then
        echo "Executable $EXECUTABLE not found"
    else
        echo "Running $EXECUTABLE"
        $EXECUTABLE
    fi
done
```

In this script make sure to update the variables to match your project's structure: 
- `WATCH_DIRS` is a space-separated list of directories to watch for changes; 
- `BUILD_DIR` is the directory where the project is built; 
- `EXECUTABLE` is the path to the executable file that will be run after the tests pass; 
  if left empty, no code will be run.
