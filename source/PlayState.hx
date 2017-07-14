package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import logs.Logger;
import tmxtools.TmxTools;

class PlayState extends FlxState
{
	var loadedMap:FlxTilemap;
	var ds:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		var map = new TmxTools('assets/data/testmap.tmx', 'assets/images/', 'assets/data/');
		
		loadedMap = map.getMap('Tile Layer 1');
		//Logger.addLog('MapStats', loadedMap.heightInTiles + '');
		add(loadedMap);
		//add(map.getMap('Tile Layer 2'));
		
		ds = new FlxSprite();
		ds.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		
		for (l in map.getTmxLines()){
			drawLine(l.points);
		}
		
		add(ds);
		
	}
	
	

	private function drawLine(p:Array<FlxPoint>) {
		FlxSpriteUtil.beginDraw(FlxColor.BLUE);
		var currentPoint:FlxPoint = new FlxPoint();
		var previousPoint:FlxPoint = new FlxPoint();
		
		var firstloop = true;
		
		for (point in p) {
			currentPoint.copyTo(previousPoint);
			point.copyTo(currentPoint);
			if (firstloop) {
				firstloop = false;
				continue;
			}
			
			FlxSpriteUtil.drawLine(ds, previousPoint.x, previousPoint.y, currentPoint.x, currentPoint.y);
			
			
		}
		FlxSpriteUtil.endDraw(ds);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
