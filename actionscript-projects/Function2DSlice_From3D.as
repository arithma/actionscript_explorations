/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/tQ0s
 */

package 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.getTimer;
    
    /**
     * ...
     * @author arithma
     */
    public class Main extends Sprite 
    {
        private var bitmapData:BitmapData;
        public function Main():void 
        {
            bitmapData = new BitmapData(100, 100);
            addChild(new Bitmap(bitmapData));
            
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
            addEventListener(Event.ENTER_FRAME, frame);
        }
        
        private function frame(e:Event = null):void {
            var z:Number = (getTimer() % 4000 - 2000) / 2000.0;
            bitmapData.lock();
            for (var i:int = 0; i < 100; i++) {
                var x:Number = ( -50 + i) / 50.0;
                for (var j:int = 0; j < 100; j++) {
                    var y:Number = ( -50 + j) / 50.0;
                    
                    var theta:Number = Math.atan2(y, x);
                    var phi:Number = Math.atan2(z, Math.sqrt(y * y + x * x));
                    
                    var f:Number = Math.abs(.8 - Math.sqrt(x * x + y * y + z * z));
                    f *= 1 + .2 * Math.cos(theta * 20);
                    f *= 1 + .2 * Math.cos(phi * 20);
                    var color:uint;
                    if (f < .03)
                        color = 0xFF;
                    else
                        color = 0;
                    bitmapData.setPixel(i, j, color);
                }
            }
            bitmapData.unlock();
        }
    }
}
