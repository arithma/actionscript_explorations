/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/uTvm
 */

// forked from arithma's persistent swarms
package 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    
    /**
     * ...
     * @author ...
     */
    public class Main extends Sprite 
    {
        public const N:int = 400;
        public const S:Number = 5;
        public var points:Array;
        public var bmp:Bitmap;
        public var bmpdata:BitmapData;
        public var sprite:Sprite;
        
        public function Main():void 
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
            stage.frameRate = 120;
            bmpdata = new BitmapData(stage.stageWidth, stage.stageHeight);
            bmp = new Bitmap(bmpdata);
            addChild(bmp);
            
            sprite = new Sprite();
            
            points = new Array();
            
            for (var i:int = 0; i < N; i++) {
                var arrw:Arrow = new Arrow();
                arrw.x = Math.random() * stage.stageWidth;
                arrw.y = Math.random() * stage.stageHeight;
                arrw.mag = Math.random() * 2 - 1;
                arrw.graphics.beginFill(Math.random() * 0xFFFFFF);
                arrw.graphics.moveTo( -Math.sin(Math.PI / 10)*S, (.5 - Math.cos(Math.PI / 10)) * S);
                arrw.graphics.lineTo( +Math.sin(Math.PI / 10)*S, (.5 - Math.cos(Math.PI / 10)) * S);
                arrw.graphics.lineTo( 0, .5 * S);
                arrw.graphics.endFill();
                arrw.rotation = Math.atan2(arrw.vy, arrw.vx) * 180 / Math.PI - 90;
                sprite.addChild(arrw);
                points.push(arrw);
            }
            
            addEventListener(Event.ENTER_FRAME, frame);
        }
        
        private function frame(e:Event = null):void {
            for each(var arrw:Arrow in points) {
                var vx:Number = 0;
                var vy:Number = 0;
                if(Math.random()<.008){
                    arrw.x = Math.random() * stage.stageWidth;
                    arrw.y = Math.random() * stage.stageHeight;
                }

                for each(var other:Arrow in points) {
                    if (other != arrw) {
                        var dx:Number = other.x - arrw.x;
                        var dy:Number = other.y - arrw.y;
                        var dist2:Number = dx*dx + dy*dy;
                                            
                        var dist:Number = Math.sqrt(dist2);
                        var ux:Number = dx / dist;
                        var uy:Number = dy / dist;
                        
                        var attr1:Number = 5 * Math.exp(-dist*.02) * arrw.mag * other.mag;
                        var attr2:Number = .5 * Math.exp(-dist*.03);
                        var repul:Number = -20 * Math.exp(-dist2*.005);
                        var rot1:Number = 1.5 * Math.exp(-dist * .1);
                        
                        vx += (attr1 + attr2 + repul) * ux;
                        vy += (attr1 + attr2 + repul) * uy;
                        
                        vx -= rot1 * uy;
                        vy += rot1 * ux;
                    }
                }
                
                arrw.x += .1*vx;
                arrw.y += .1*vy;
                arrw.rotation = Math.atan2(vy, vx) * 180 / Math.PI - 90;
            }
            
            var result:Sprite = new Sprite();
            result.addChild(bmp);
            bmp.transform.colorTransform = new ColorTransform(.99, .99, .99, 1, .01);
            result.addChild(sprite);
            bmpdata.draw(result);
            addChild(bmp);
            bmp.transform.colorTransform = new ColorTransform();
        }
        
    }
    
}

import flash.display.Sprite;
class Arrow extends Sprite{
    public var vx:Number;
    public var vy:Number;
    
    public var mag:Number;
}
