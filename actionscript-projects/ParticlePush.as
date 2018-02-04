/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/9wzF
 */

package {
    import flash.display.Sprite;
    import flash.events.Event;
    public class Demo extends Sprite {
        private var particles:Vector.<Particle>;
        public function Demo() {
            // write as3 code here..
            particles = new Vector.<Particle>();
            for(var i:int = 0; i < 100; i++){
                var particle:Particle = new Particle();
                particle.x = stage.stageWidth * Math.random();
                particle.y = stage.stageHeight * Math.random();
                particle.iniX = particle.x;
                particle.iniY = particle.y;
                particles.push(particle);
                addChild(particle);
            }
            stage.addEventListener(Event.ENTER_FRAME, frame);
        }
        
        public function frame(e:Event):void{
            for each(var particle:Particle in particles){
                var pullx:Number = particle.iniX - particle.x;
                var pully:Number = particle.iniY - particle.y;
                var pushx:Number = particle.x - mouseX;
                var pushy:Number = particle.y - mouseY;
                var pushd:Number = Math.sqrt(pushx * pushx + pushy * pushy);
                var f:Number = Math.exp(-.01*pushd);
                
                particle.x += (pullx * particle.factor1 + pushx * f * particle.factor2) * particle.damp;
                particle.y += (pully * particle.factor1 + pushy * f * particle.factor2) * particle.damp;
            }
        }
    }
}

import flash.display.Sprite;
class Particle extends Sprite{
    public function Particle(){
        graphics.beginFill(0x0);
        graphics.drawCircle(0, 0, 10);
        graphics.endFill();
        factor1 = 1.0;
        factor2 = Math.random() * .5 + .5;
        alpha = factor2;
        damp = 1.0;
    }

    public var factor1:Number;
    public var factor2:Number;
    public var damp:Number;
    public var iniX:Number;
    public var iniY:Number;
}