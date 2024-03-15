# The Reaper Institute

Using Godot v3.5.3

-----

Self-Asset except for kenney's assets as my model for creating the assets

-----

What's ideas behind the mechanics

- The core concept is in the SceneManager.gd
  - It hold all change scene concept in this game
  - When changing scene, it try to use deferred call and queue free
    - So the game can run smoothly, without interupting another existing computations
- Another to pointed out is, when using moving horizontal area, deliberately changing the player global position, with respect to the game's width
  - It is not best practices, but it's the simplest things
- Another one is how to hide the platform
  - By using the godot's visibility function
  - And by deliberately using the SceneManager to manage carefully what scene to show and what scene to hide after long pressing the E button
- Everything else is around the same topic as these mentioned

-----

What's Next

-----

- Implement the Sam's platform help to choose one platform to save from dozen of unusable platform
- Implement the eagle/crow view to memorize more than one room
- Make multiple ending if possible, choosing to live as a reaper or fail as a human
