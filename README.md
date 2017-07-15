# HaxeFlixel_Tools

This is a small toolset for HaxeFlixel that simplifies many of the common tasks I found myself doing over and over again between game jams.  

##How to use
Get a copy of the project and place the folders you want to use in the source directory of a HaxeFlixel project.

You have to copy logs to use anything else because the other code uses it.

#logs

This is a simple log writer that lets you easily control what is written to the console.  

##Usage
Just import logs.Logger

To add a log, call Logger.addLog();  It takes a tag:String, message:String, and level:Int.  

Every log by default has a level of 3.  The basic thinking is that log level 1 is for erors, 2 for warnings, and 3 for infomational messages.  

If you call Logger.setLogDisplayLevel(Int) you stop all logs with a level higher than the integer from displaying.  


#InputHelper
InputHelper is an abstraction layer between keyboard keys and game input.  It uses the idea of virtual buttons with names like "UP", "JUMP", or "EAT CAKE".  Then it maps keys on the keyboard to your virtual buttons which can be queried in game.
Keys can be remapped easily without changing your game code.

##Usage
Call InputHelper.init() somewhere before your game starts.  I call it in Main.hx before the super() call.  You automatically get 4 virtual buttons called "UP","DOWN","LEFT", and "RIGHT"
There are three helper functions called InputHelper.allowWASD(), .allowArrowKeys(), and allowZQSD() (for AZERTY keyboard users) that automatically map the keys to the virtual buttons.

To create a new virtual button, run InputHelper.addButton(buttonName:String).  Then you can assign keys to that button with InputHelper.assignKeyToButton(key:String, button:String).  The key string is the HaxeFlixel key string and it has to be exact (See FlxKey).

Every update frame in your game, before the **before the super.update(elapsed) call**, call InputHelper.update(elapsed) and it will update the virtual buttons.  Then you can use InputHelper.isButtonPressed(button:String), .isButtonJustPressed(button:String), and .isButtonPressedTime(button:String) to get information on the virtual buttons.

InputHelper also comes with InputHelperMenuState which is an (ugly) FlxSubstate that lets the player remap the buttons.  Feel free to rewrite it because this code is super ugly and hacky.  It originated in a game jam (JUST MAKE IT WORK AND MOVE ON!) and I haven't gone back to fix it...
Call it from any state with this.openSubState(new InputHelperMenuState()).  When the player clicks finished it will bring them back to the place they left off.

#TmxTools
TmxTools is a helper function for reading in and using .tmx files as created by Tiled and other map making applications.  I wrote it because I found myself doing it every game jam and I don't particularly like the Flixel addons implementation.
Right now it parses TMX files, can point to a picture and data directory.  It creates a FlxTilemap from each layer and can parse out object layers.

**This works with Tiled version 2017.05.26.  It *should* work with earlier versions.**

##Usage
Create a new map with var map = new TmxTools(pathToTMXFile:String, pathToImages:String, pathToData:String);
**pathToXMLFile** is something like 'assets/data/maps' or wherever you keep your .tmx files.
**pathToImages** is something like 'assets/images'.  This is the location you will put all your tileset images and image layer images (Support for image layer images coming soon-ish).  Tiled stores relative paths and that doesn't copy into projects well, so I strip out the directory from the path and use the one supplied here.
**pathToData** is something like 'assets/data' or wherever you keep your .tsx files.  One of the more recent updates to Tiled lets you create tilesets that you can use in multiple projects (the tsx file).  You can put them all in a location and the code will look for them where you specified instead of the relative path in the tmx file.  You can also choose to embed the tileset data in the tiled TMX file through Tiled directly.  Either way will work.  

To get a FlxTileMap from a layer, call var tileMap = map.getMap(layerName:String) and it will return it to you all ready to be added to the state.
To get the objects created in the Object Layers, use one of the functions provided.  

map.getTmxLines() reutrns an array of TmxLines which have all the points and properties (including custom ones).
map.getTmxRects() reutrns an array of TmxRects which has the FlxRect object (called r) and the properties (including custom ones).
The rest of the objects and layers wioll be added later, probably when I need them in a game jam.

##Problems:
	-Each layer can only have a single TileSet.  This is a complicated issue and might change in the future, but for now, sorry.
	-The Tile Layers have to have CSV encoding.  Base64 (compressed and uncompressed) and XML will come eventually, but I always use CSV now so that's what I built.
	-The object layer that the object came from isn't stored anywhere.  I should probably return it in the property map, but I haven't yet.
	-A bunch of objects (polygon adn ellipse) don't work yet.  Ellipse will be simple, but HaxeFlixel doesn't have a good way to handle Polygons without using Nape or Box2D or some other physics engine.  I'm thinking I'll just return an array of points (like I do with the lines) but I haven't done this yet.
	
	