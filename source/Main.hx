package;

import flixel.FlxGame;
import inputhelper.InputHelper;
import inputhelper.InputHelperMenuState;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		
		InputHelper.init();
		InputHelper.allowWASD();
		InputHelper.allowArrowKeys();
		InputHelper.addButton('other');
		InputHelper.assignKeyToButton("SPACE", 'other');
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
