package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
    import net.flashpunk.utils.Key;

    [SWF(width = "480", height = "600", backgroundColor="#000000")]
	public class Main extends Engine 
	{
        private static const SCREEN_WIDTH:int = 480;
        private static const SCREEN_HEIGHT:int = 600;

		public function Main():void 
		{
			super(SCREEN_WIDTH, SCREEN_HEIGHT);
            Audio.init();
			FP.world = new GameWorld();
			FP.console.enable();
            FP.console.toggleKey = Key.T;
		}
	}
}
