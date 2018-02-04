/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/pQcR
 */

package 
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    /**
     * ...
     * @author arithma
     */
    public class Main extends Sprite 
    {
        private var book:Sprite;
        private var page:Sprite;
        private var origX:Number;
        private var origY:Number;
        
        public function Main():void 
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
            book = new Sprite();
            
            book.x = stage.stageWidth * .5;
            book.y = stage.stageHeight * .5;
            
            addChild(book);
            
            book.graphics.beginFill(0);
            book.graphics.drawRect(0, -120, -200, 240);
            
            book.graphics.beginFill(0xFF);
            book.graphics.drawRect(0, -120, 200, 240);
            
            page = new Sprite();
            book.addChild(page);
        }
        
        private function mouseDown(e:MouseEvent):void 
        {
            origX = 200;
            origY = book.mouseY;
            
            updateSprites();
            
            addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
            addEventListener(MouseEvent.MOUSE_UP, mouseUp);
        }
        
        private function mouseUp(e:MouseEvent):void 
        {
            removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
        }
        
        private function mouseMove(e:MouseEvent):void 
        {
            updateSprites();
        }
            
        private function updateSprites():void 
        {
            var mX:Number = book.mouseX;
            var mY:Number = book.mouseY;
            
            var centerX:Number = (origX + mX) * .5;
            var centerY:Number = (origY + mY) * .5;
            
            var At:Number = (-120 - centerY) / (mX - centerX);
            var Ax:Number = centerX - At * (mY - centerY);
            var Ay:Number = -120;
            
            var Bt:Number = (+120 - centerY) / (mX - centerX);
            var Bx:Number = centerX - Bt * (mY - centerY);
            var By:Number = +120;
            
            if (Ax < 0) {
                var Zx:Number = origX - centerX;
                var Zy:Number = origY - centerY;
                var d2:Number = Zx * Zx + Zy * Zy;
                var d:Number = Math.sqrt(d2);
                Zx /= d;
                Zy /= d;
                
                var farDst:Number = (0 - centerX) * Zx + (-120 - centerY) * Zy;
                var nearDst:Number = (Ax - centerX) * Zx + (Ay - centerY) * Zy;
                var diff:Number = farDst - nearDst;
                
                centerX += Zx * diff;
                centerY += Zy * diff;
                
                mX = origX + 2 * (centerX - origX);
                mY = origY + 2 * (centerY - origY);
                
                Ax = 0;
                Ay = -120;
                
                Bt = (+120 - centerY) / (mX - centerX);
                Bx = centerX - Bt * (mY - centerY);
                By = +120;
            }
            
            if (Bx < 0) {
                var Zx:Number = origX - centerX;
                var Zy:Number = origY - centerY;
                var d2:Number = Zx * Zx + Zy * Zy;
                var d:Number = Math.sqrt(d2);
                Zx /= d;
                Zy /= d;
                
                var farDst:Number = (0 - centerX) * Zx + (120 - centerY) * Zy;
                var nearDst:Number = (Bx - centerX) * Zx + (By - centerY) * Zy;
                var diff:Number = farDst - nearDst;
                
                centerX += Zx * diff;
                centerY += Zy * diff;
                
                mX = origX + 2 * (centerX - origX);
                mY = origY + 2 * (centerY - origY);
                
                Bx = 0;
                By = +120;
                
                At = (-120 - centerY) / (mX - centerX);
                Ax = centerX - At * (mY - centerY);
                Ay = -120;
            }
            
            var planeFuncU:Number = -(200 - centerX) * (Ay - centerY) + ( -120 - centerY) * (Ax - centerX);
            var factorU:Number = planeFuncU / ((Ax - centerX) * (Ax - centerX) + (Ay - centerY) * (Ay - centerY));
            var Ux:Number = 200 - 2 * factorU * (-(Ay - centerY));
            var Uy:Number = -120 - 2 * factorU * (Ax - centerX);
            
            var planeFuncV:Number = -(200 - centerX) * (Ay - centerY) + ( 120 - centerY) * (Ax - centerX);
            var factorV:Number = planeFuncV / ((Ax - centerX) * (Ax - centerX) + (Ay - centerY) * (Ay - centerY));
            var Vx:Number = 200 - 2 * factorV * (-(Ay - centerY));
            var Vy:Number = 120 - 2 * factorV * (Ax - centerX);
            
            if (Ax > 200) {
                Ay = centerY + (Ay - centerY) / (Ax - centerX) * (200 - centerX);
                Ax = 200;
                Ux = Ax;
                Uy = Ay;
            }
            
            if (Bx > 200) {
                By = centerY + (By - centerY) / (Bx - centerX) * (200 - centerX);
                Bx = 200;
                Vx = Bx;
                Vy = By;
            }
            
            page.graphics.clear();
            page.graphics.beginFill(0xFF0000, 0.5);
            var triangles:Vector.<Number> = new Vector.<Number>();
            triangles.push(Ax, Ay, Ux, Uy, Vx, Vy);
            triangles.push(Bx, By, Vx, Vy, Ax, Ay);
            page.graphics.drawTriangles(triangles);
            page.graphics.endFill();
        }
    }
}