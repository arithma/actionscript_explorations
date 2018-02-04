/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/1sAs
 */

package {
    import flash.display.Sprite;
    import flash.events.Event;
    public class Gear extends Sprite {
        private var gear:Sprite;
        private var gear2:Sprite;
        public function Gear() {
            gear = createGear(15, 70, 10);
            gear.x = stage.stageWidth * .5;
            gear.y = stage.stageHeight * .5;
            addChild(gear);
            
            gear2 = createGear(10, 14*3, 10);
            gear2.x = gear.x + 70 + 14 * 3 + 10;
            gear2.y = gear.y;
            addChild(gear2);
            
            addEventListener(Event.ENTER_FRAME, frame);
        }
        
        public function frame(e:Event):void{
            gear.rotation += 1;
            gear2.rotation -= 1.5;
        }
        
        public function createGear(teeth:int, R:Number, S:Number):Sprite{
            var gear:Sprite = new Sprite();
            
            var control:Vector.<Number> = new Vector.<Number>();
            control.push(1);
            control.push(1);
            control.push(0);
            control.push(0);
            
            gear.graphics.lineStyle(2, 0);
            for(var i:int = 0; i < 361; i++){
                var angle:Number = i/180*Math.PI;
                var index:int = Math.floor(i/360*teeth*control.length)%control.length;
                if(i==0)
                   gear.graphics.moveTo(
                     (R+control[index]*S)*Math.cos(angle),
                     (R+control[index]*S)*Math.sin(angle));
                else
                   gear.graphics.lineTo(
                     (R+control[index]*S)*Math.cos(angle),
                     (R+control[index]*S)*Math.sin(angle));
            }
            gear.graphics.drawCircle(0, 0, R*.9);
            
            return gear;
        }
    }
}