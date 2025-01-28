# SpaceX app
SpaceX is great app that lets you view launches for SpaceX rockets.

## How to build app

- `brew tap tuist/tuist`
- `brew install --formula tuist`
- `tuist generate`
- Open and run project as you normally would :) 

# Tips

> Never worked with `Tuist` instead of raw Xcode project file before? Look [here](https://docs.tuist.dev). Keep in mind that every change on the project level needs to be changed in the Tuist files, not in the `*.xcodeproj` since it's recreated with with every generation (it doesn't mean you can't add files within the Xcode UI, but if you change e.g. build settings signing or build phases, the change won't persist until you change it in the Tuist files also).