# Package management

- [What packages are and how they are organized](packages.md)



## Debugging: RVIZ
To debug a project we might want to use **RVIZ** to see what's happening:
```shell
rosrun rviz rviz
```

# Key concepts
## Topics
Are **handling** the **communication**. **Publishers** might publish information to a given topic and **subscribers** can read this new information and decide accordingly.

## Services
Are encoding a specific functionality that anyone can call from the outside (e.g. _tell the robot to travel 1m straight_).
A service must be completed before executing another one.

Executes with commands
```shell
rosservice call [topic] [args]
```

## Actions
Similar to services, but actions can be performed bu the ropot while still doing something else.