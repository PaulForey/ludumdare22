package
{
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Emitter;

    public class EngineEmitter extends Entity
    {
        [Embed(source="../assets/gfx/engineParticle.png")]
        private static const ENGINE_PARTICLE:Class;

        private var emitter:Emitter;

        private var firing:Boolean = false;

        private var playerX:int;
        private var playerY:int;

        public function EngineEmitter()
        {
            // MAH PARTICLAES 
            emitter = new Emitter(ENGINE_PARTICLE, 4, 4);
            emitter.newType("engine1", [0, 1, 2, 3]);
            emitter.newType("engine2", [1, 3, 0, 2]);
            emitter.newType("engine3", [2, 0, 3, 1]);

            emitter.setColor("engine1", 0xFF0000, 0xAA3333);
            emitter.setColor("engine2", 0xAA3333, 0xFFFFFF);
            emitter.setColor("engine3", 0xFFFFFF, 0xFF0000);

            emitter.setMotion("engine1", 190, 20, 0.2, 160, 10, 0.1);
            emitter.setMotion("engine2", 190, 24, 0.2, 165, 7, 0.1);
            emitter.setMotion("engine3", 190, 22, 0.2, 165, 13, 0.1);

            this.graphic = emitter;

            super(0, 0, emitter);
        }

        public function start(playerX:int, playerY:int):void
        {
            firing = true;
            this.playerX = playerX;
            this.playerY = playerY;
        }

        public function stop():void
        {
            firing = false;
        }

        public override function update():void
        {
            if (firing)
            {
                for (var i:int = 0; i < 10; i ++)
                {
                    emitter.emit("engine1", playerX, playerY);
                    emitter.emit("engine2", playerX, playerY);
                    emitter.emit("engine3", playerX, playerY);
                }
            }
            super.update();
        }
    }
}
