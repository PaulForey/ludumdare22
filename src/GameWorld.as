package
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
    import net.flashpunk.graphics.Backdrop;

	public class GameWorld extends World 
    {
        private var player:Player;

        [Embed(source="../assets/gfx/backgroundStars.png")]
        private static const BACKGROUND_STARS:Class;
        [Embed(source="../assets/gfx/backgroundSpace.png")]
        private static const BACKGROUND_SPACE:Class;

        public var spaceSpeed:int = 25;
        private var starSpeed:int = 1;

        private var backgroundStars:Backdrop;
        private var backgroundSpace:Backdrop;

        public function GameWorld()
        {
            backgroundStars = new Backdrop(BACKGROUND_STARS, true, false);
            addGraphic(backgroundStars);

            backgroundSpace = new Backdrop(BACKGROUND_SPACE, false, true);
            addGraphic(backgroundSpace);

            player = new Player(FP.halfWidth, FP.halfHeight);
            add(player);
        }

        public override function update():void
        {
            super.update();

            backgroundSpace.y += spaceSpeed * FP.elapsed;
            backgroundStars.x += starSpeed * FP.elapsed;
        }
    }
}
