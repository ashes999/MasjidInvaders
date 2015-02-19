package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import neko.vm.Loader;
import neko.vm.Module;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		loadAndTracePluginClasses();

		var s:FlxSprite = new FlxSprite();
		s.loadGraphic('assets/images/dg-logo.png');
		add(s);
	}

	private function loadAndTracePluginClasses() {
		// http://haxe.1354130.n2.nabble.com/Passing-data-between-neko-modules-while-preserving-type-info-tp3264417p3283789.html
		var loader = Loader.local();
		var module = loader.loadModule("assets/plugins/plasma_cannon");
		var classes:Dynamic = module.exportsTable().__classes;

		// http://echelog.com/logs/browse/haxe/1341439200
		var classesTypes = Reflect.fields(classes);
		for (i in classesTypes)
		{
			var c:Dynamic = Reflect.field(classes, i);
			if (isDashoom(c))
			{
				trace("Dashoom Class: " + c.__name__);
				var instance = Type.createInstance(c, []);
				// works because instance is dynamic
				trace(instance.fire());
			}
		}
	}

	private function isDashoom(c:Dynamic) : Bool
	{
		var interfaces:Dynamic = c.__interfaces__;
		var interfaceTypes = Reflect.fields(interfaces);
		for (interfaceType in interfaceTypes)
		{
			var interfaceArray:Dynamic = Reflect.field(interfaces, interfaceType);
			for (i in 0 ... interfaces.length) {
				var inter = interfaces[i];
				// Looks deceptive, but interfaces only have one name. It's an array though.
				if (inter.__name__[0] == 'Dashoom') {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
}
