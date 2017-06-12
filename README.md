# Diamond Breaker

Diamond Breaker is a game based on the classic Bricks Breaker. This game is
built using [Godot](https://godotengine.org/), a free and open source engine
that help us develop multi-platform games. 

The current implemented features are listed below:

- **Diffent Blocks**: 3 kind of blocks were implemented. The difference between
them is the number of hits needed to be destroyed: 1, 2 or 3 hits.
- **High Score**: the player can monitor his/her score and the high score
during the game. At the end of the game the player is notified if they beat 
the high score.
- **Max Combo**: the player can monitor his/her maximum combo (sequential hits
without touching the paddle) and the highest combo. Do your best and try to
break new records! ;)
- **Dynamic Background**: During the game the background will rotate and change
color, pay attention and enjoy it. If you achieve combos multiple of 5,
be ready for a spin! :)
- **Powers up/down**: Some power-ups/downs are present in the game to make it
more challenging. Destroy bricks marked with the golden diamond and catch
the falling diamond to get a power-up/down:
  - The paddle can be expanded (green diamond) or reduced (white), watch out!
  - The number of balls in the screen can be increased (purple). Each time you get
  this power-up 2 more balls will be launched! Do not worry, you will only lose
  if you let the last ball out.
  - You can enable a remote control for the balls (red)! Depending on the
  position of your finger on the screen the direction of the balls may
  change. You can guide the balls to the direction that you prefer, but if you
  move your finger too fast, the balls will do the same.
- **Random Levels**: Besides the existent difficulty levels (easy, medium and hard) each
time you play you will get a different level:
  - Different block layers: fringe, shell, body and core regions.
  - Different brick density probabilities for each layer and difficulty.
  - Brick strength probabilities for each layer and difficulty.
  - Randomized power-up placement
  - Randomized brick strength and density, depending on probabilities for each layer.

### Build

To build the game you need to install Godot. You should download the
[stable version](https://godotengine.org/download). Doing that you will have an
executable bundled with all dependencies. In Linux, just run
the binary and everything should work fine.

Now you need to import this project into the editor and configure some
variables to be able to export it as an APK file to run in your Android device. You
can find a guide
[here](http://docs.godotengine.org/en/stable/learning/workflow/export/exporting_for_android.html).

Finally, you can compile the project for Android and save the APK file in your
file system. Documentation is available
[here](http://docs.godotengine.org/en/stable/development/compiling/compiling_for_android.html).

With this you will be able to install the game on your device and have fun :)
