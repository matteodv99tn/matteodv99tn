# Launch files

`.launch` files must be stored inside the `launch` folder that's placed in the root of each ROS package.

Launch files are used to easily start new nodes that call scripts of the package.
If we would like to run the launch file `robot_controller.launch` of the package `my_robot_controller` we would simply run
```sh 
roslaunch my_robot_controller robot_controller.launch
```
More generally
```sh 
roslaunch [package_name] [launch_file]
```

## Structure of launch files
Launch files are essentially `.xml`. A simple example to start a node based on the python library is:
```xml
<launch>
    <node pkg = "my_robot_controller" type = "impedance_control.py" name = "impedance_controller" output = "screen">
    </node>
</launch>
```
In this case the launch files runs the script `impedance_control.py` of the package `my_robot_controller`; the node's name will be `impedance_controller`.

Details on all possible tags and explenation can be found [here](http://wiki.ros.org/roslaunch/XML).
Still here I post important aspects.


### The `node` tag 
```xml 
<node
    pkg  = "package_name"
    type = "executable_file"
    name = "node_name"
    args = "arg1 arg2 arg3"
    ns   = "namespace_name"
    output = "log|screen"
    >
</node
```
Used to start a given node; in particular
- `pkg` specifies the name of the package where the node's executable can be found;
- `type` specifies the executable that shall be run;
- `name` specifies the node's name (without namespace); it overrides the one specified in the executable;
- `args` specifies the arguments for the node;
- `ns` specifies the node's namespace.
