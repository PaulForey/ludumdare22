package
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;

    public class Bullet extends Entity
    {
        [Embed(source="../assets/gfx/bullets.png")]
        private static const BULLETS:Class;

        private static const ACCELERATION_0:int = 30;
        private static const ACCELERATION_1:int = 40;
        private static const ACCELERATION_2:int = 12;
        private static const ACCELERATION_3:int = 200;

        private static const SPEED_0:int = 1200;
        private static const SPEED_1:int = 1600;
        private static const SPEED_2:int = 600;
        private static const SPEED_3:int = 50;

        private static const DIRECTION_VARIATION_0:int = 0;
        private static const DIRECTION_VARIATION_1:int = 1600;
        private static const DIRECTION_VARIATION_2:int = 60;
        private static const DIRECTION_VARIATION_3:int = 50;

        private static const DIRECTION_DEVIATION:int = 100;

        private var sprite:Spritemap;
        private var bulletType:int;
        private var bulletLeft:Boolean;
        private var acceleration:int;
        private var speed:int;
        private var directionVariation:int;
        private var dy:int;

        private var startx:int;
        private var starty:int;

        public function Bullet(bx:int, by:int, bulletType:int, bulletLeft:Boolean)
        {
            this.bulletType = bulletType;
            this.bulletLeft = bulletLeft;

            startx = bx;
            starty = by;

            sprite = new Spritemap(BULLETS, 8, 8);

            sprite.setFrame(bulletType);

            setHitbox(8, 8, 0, 0);

            acceleration = Bullet["ACCELERATION_" + bulletType.toString()];
            speed = Bullet["SPEED_" + bulletType.toString()];
            directionVariation = Bullet["DIRECTION_VARIATION_" + bulletType.toString()];

            super(bx, by, sprite);
        }

        public override function update():void
        {
            dy += acceleration * -1;

            dy = FP.clamp(dy, -speed, speed);

            y += dy * FP.elapsed;

            if (bulletType == 2)
            {
                if (bulletLeft)
                {
                    if (x > startx - DIRECTION_DEVIATION)
                        x -= directionVariation * FP.elapsed;
                }
                else
                {
                    if (x < startx + DIRECTION_DEVIATION)
                        x += directionVariation * FP.elapsed;
                }
            }
            else
            {
                x += (FP.random*directionVariation - directionVariation/2) * FP.elapsed;
            }

            if (y < -40 || y > FP.height+40)
                world.remove(this);
        }
    }
}
