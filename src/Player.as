package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;

	public class Player extends Entity 
	{
        [Embed(source="../assets/gfx/player.png")]
        private static const PLAYER:Class;

        private static const RELOADING_TIME_0:int = 3;
        private static const RELOADING_TIME_1:int = 1;
        private static const RELOADING_TIME_2:int = 8;
        private static const RELOADING_TIME_3:int = 5;

        private var sprite:Spritemap;

        private var engine:EngineEmitter;

        private var speed:int = 500;
        private var acceleration:int = 60;
        private var friction:int = 30;
        private var shipWidth:int = 64;
        private var shipHeight:int = 64;

        private var currentWeapon:int = 0;
        private var bulletLeft:Boolean = false;
        private var reloadingTimer:int = 0;

        private var dx:Number = 0;
        private var dy:Number = 0;

		public function Player(px:int, py:int) 
		{
			sprite = new Spritemap(PLAYER,shipWidth,shipHeight);
			super(px-shipHeight/2, py-shipWidth/2, sprite);
			setHitbox(64, 64, 0, 0);

            engine = new EngineEmitter();

            // Define some inputs
            Input.define("left", Key.LEFT, Key.A);
            Input.define("right", Key.RIGHT, Key.D);
            Input.define("up", Key.UP, Key.W);
            Input.define("down", Key.DOWN, Key.S);
            Input.define("fire", Key.SPACE, Key.E, Key.Q);
            Input.define("wep0", Key.DIGIT_1);
            Input.define("wep1", Key.DIGIT_2);
            Input.define("wep2", Key.DIGIT_3);
            Input.define("wep3", Key.DIGIT_4);
		}

        public override function added():void
        {
            world.add(engine);
        }
		
		public override function update():void
		{
            // MOVEMENT STUFF
			dx += acceleration * (int(Input.check("right")) - int(Input.check("left")));
			dy += acceleration * (int(Input.check("down")) - int(Input.check("up")));

            if (!Input.check("right") && !Input.check("left") && !Input.check("down") && !Input.check("up"))
            {
                if (dx > 0)
                    dx -= friction;
                else if (dx < 0)
                    dx += friction;

                if (dy > 0)
                    dy -= friction;
                else if (dy < 0)
                    dy += friction;
            }
            
            dx = FP.clamp(dx, -speed, speed);
            dy = FP.clamp(dy, -speed, speed);

            x += int(dx * FP.elapsed);
            y += int(dy * FP.elapsed);

            if (x < 0 || x > FP.width-shipWidth)
            {
                x = FP.clamp(x, 0, FP.width-shipWidth);
                dx = -dx*0.5;
            }

            if (y < 0 || y > FP.height-shipHeight)
            {
                y = FP.clamp(y, 0, FP.height-shipHeight);
                dy = -dy*0.5;
            }

            // ANIMATION STUFF
            if (Input.check("right"))
                sprite.setFrame(2, currentWeapon);
            else if (Input.check("left"))
                sprite.setFrame(1, currentWeapon);
            else 
                sprite.setFrame(0, currentWeapon);

            if (Input.check("up"))
            {
                engine.start(x+31, y+58);
                (world as GameWorld).spaceSpeed = 50;
            }
            else
            {
                engine.stop();
                (world as GameWorld).spaceSpeed = 25;
            }

            // GUN STUFF
            if (Input.check("fire"))
                fire();

            if (Input.check("wep0"))
                currentWeapon = 0;
            else if (Input.check("wep1"))
                currentWeapon = 1;
            else if (Input.check("wep2"))
                currentWeapon = 2;
            else if (Input.check("wep3"))
                currentWeapon = 3;

            if (reloadingTimer > 0)
                reloadingTimer--
        }

        private function fire():void
        {
            if (reloadingTimer == 0)
            {
                bulletLeft = !bulletLeft; // Alternates bullet fire between left and right guns.
                reloadingTimer = Player["RELOADING_TIME_" + currentWeapon.toString()];

                if (bulletLeft)
                {
                    if (sprite.frame % 3 == 0)
                        world.add(new Bullet(x+6, y+28, currentWeapon, bulletLeft));
                    else if (sprite.frame % 3 == 2)
                        world.add(new Bullet(x+10, y+24, currentWeapon, bulletLeft));
                    else
                        world.add(new Bullet(x+2, y+24, currentWeapon, bulletLeft));
                }
                else
                {
                    if (sprite.frame % 3 == 0)
                        world.add(new Bullet(x+50, y+28, currentWeapon, bulletLeft));
                    else if (sprite.frame % 3 == 2)
                        world.add(new Bullet(x+54, y+24, currentWeapon, bulletLeft));
                    else
                        world.add(new Bullet(x+46, y+24, currentWeapon, bulletLeft));
                }
            }
        }
	}
}
