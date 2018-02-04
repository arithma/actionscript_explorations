/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/o8DD
 */

package 
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    /**
     * ...
     * @author ...
     */
    public class Main extends Sprite 
    {
        private static const N:int = 1024;
        private static const M:Number = 10;
        private static const C:Number = 10/100;
        private var list:Array;
        private var positions:Array;
        public function Main():void 
        {
            list = new Array();
            positions = new Array();
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            
            removeEventListener(Event.ADDED_TO_STAGE, init);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
            stage.frameRate = 120;
            // entry point
            for (var i:int = 0; i < N; i++) {
                var shape:Shape = new Shape();
                shape.graphics.beginFill(Math.random() * 0xFFFF);
                shape.graphics.drawCircle( 0, 0, Math.random() * 5 + 5);
                shape.graphics.endFill();
                //var pos:Object = { x:stage.stageWidth / 32 * (i%32), y:stage.stageHeight * Math.random() };
                var w:Number = stage.stageWidth;
                var h:Number = stage.stageHeight;
                var pos:Object = { x:(i%32) / 32. * w * .8 + .1 * w, y:Math.floor(i/32) / 32. * h * .8 + .1 * h };
                shape.x = pos.x;
                shape.y = pos.y;
                positions.push(pos);
                addChild(shape);
                list.push(shape);
            }
        }
        
        private function mouseMoveListener(e:MouseEvent = null):void {
            for (var i:int = 0; i < N; i++) {
                var shape:Shape = list[i];
                var pos:Object = positions[i];
                var diff:Object = {x:pos.x-mouseX, y:pos.y-mouseY};
                var dist:Number = Math.sqrt(diff.x*diff.x + diff.y*diff.y);
                
                var scale:Number = 1 + (M - 1) * Math.exp( -dist * C);
                shape.scaleX = scale;
                shape.scaleY = scale;
                
                var ndist:Number = (Math.exp( -C * dist) - 1) * (1 - M) / C + dist;
                var ndistRatio:Number = ndist / dist;
                var ndiff:Object = { x:diff.x * ndistRatio, y:diff.y * ndistRatio };
                shape.x = mouseX + ndiff.x;
                shape.y = mouseY + ndiff.y;
            }
        }
        
    }
    
}