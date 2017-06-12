# Diamond Breaker

Diamond Breaker is a game based on the classic Bricks Breaker. This game is
built using [Godot](https://godotengine.org/), a free and open source engine
that help us develop a multi plataform games. 

The current implemented features are listed below:

- **Diffent Blocks**: 3 kind of blocks are implemented, the difference between
then is the number of hits needed to destroy them (1, 2 or 3 hits)
- **High Score**: the player can monitor his/her score and the high score
during the game. At the end of the game the player is notified if the high
score was exceeded.
- **Max Combo**: the player can monitor his/her maximum combo (hits
sequentially) and the highest maximum combo. Try to do your best and break new
records ;)
- **Dynamic Background**: During the game the background will rotate and change
the color, pay attention and enjoy it :)
- **Powers up/down**: Some powers up/down are present in the game to make it
more challenger!
  - The paddle can be expanded or reduced, watch out! The diamond that
  represents both is the same, so you will need some luck.
  - The number of balls in the screen can be incresed, each time that you got
  this power up more 2 balls will be launched! Do not worry, you will loose
  just if you leave the last ball goes down the paddle.
  - Telecontrol the balls can be enabled as one of the power ups! Depending the
  position of your finger is on the screen the direction of the balls may
  change. You can guide the balls to the direction that you prefer, but if you
  move your finger so fast, the balls will do the same.
- **Random Levels**: Besides the existent levels (easy, medium and hard) each
time that you play you will find a different thing. We try to move the blocks
and randomize the powers up/down positions to motivate you to play again and
again.

### Build

To build the game you need to install Godot. You should download the
[stable version]( https://godotengine.org/download ), then you will have a
bundle executable with all dependencies that you need. In Linux, just execute
the binary and everything should work fine.

Now you need the import this project into the editor and configure some
variables to be able to export it as an APK file to run in your Android. You
can find some guide
[here](http://docs.godotengine.org/en/stable/learning/workflow/export/exporting_for_android.html).

Finally you can compile the project for Android and save an APK file in your
filesystem. Documentation is available
[here](http://docs.godotengine.org/en/stable/development/compiling/compiling_for_android.html).

With this you are able to install the game on your device and have fun :)
