This project is a simple maze generator in Ada.
The way it works is by creating a random Tree representing all of the path in said maze.
Each parts (the number of embranchments & the directions are sampled using the [Inverse Transform Sampling](<https://en.wikipedia.org/wiki/Inverse_transform_sampling>) method w/ respect to its own distribution (more in [Probabilites.adb](<.src/model/probabilites.adb>)).

At the time of writing, the generation works, and the display is also implemented. However, for some reason, the path are not well defined.
