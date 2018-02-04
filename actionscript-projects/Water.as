/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/AtQU
 */

package {
    import flash.display.Sprite;
    import flash.utils.getTimer;
    import flash.display.GradientType;
    import flash.geom.Matrix;
    import flash.events.Event;
    public class FlashTest extends Sprite {
            private var water:Sprite;
            private var watermat:Matrix;
        public function FlashTest() {
            // write as3 code here..
            water = new Sprite();
            water.y = stage.stageHeight * .5 + 100;
            watermat = new Matrix();
            watermat.createGradientBox(800, 180, Math.PI / 2);
            addChild(water);
            updateWater();
            
            stage.frameRate = 120;
            addEventListener(Event.ENTER_FRAME, frame);
        }
        
        private function frame(e:Event):void{
                updateWater();
        }
        
        private function updateWater():void {
            water.graphics.clear();
            water.graphics.moveTo(0, 0);
            water.graphics.beginGradientFill(GradientType.LINEAR,
                [0x6699FF, 0x3366FF, 0x44], [.8, 1, 1], [0x00, 0x40, 0xFF], watermat);
            water.graphics.lineTo(0, 200);
            water.graphics.lineTo(800, 200);
            for (var i:int = 800; i >= 0; i -= 2) {
                water.graphics.lineTo(i, (Math.sin(getTimer()/300 + 1.213)*.5+1) * Math.sin(i / 10 + getTimer()/1000 ) * 2.5 + Math.sin(getTimer()/400) * Math.sin(-getTimer()/200.4-i/5.93));
            }
            water.graphics.endFill();
        }

    }
}