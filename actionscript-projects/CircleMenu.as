/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/wIOd
 */

package 
{
    import caurina.transitions.Tweener;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.utils.setInterval;
    
    /**
     * ...
     * @author arithma
     */
    public class CircleMenu extends Sprite 
    {
        private var buttonsHours:Array;
        private var buttonsMinutes:Array;
        private var buttonsSeconds:Array;
        public function CircleMenu() {
            buttonsHours = new Array();
            buttonsMinutes = new Array();
            buttonsSeconds = new Array();
            
            for (var i:int = 0; i < 12; i++) {
                var button:Sprite = new Sprite();
                if(i%3==0)
                    button.graphics.beginFill(0x990000);
                else
                    button.graphics.beginFill(0);
                    
                button.graphics.drawRoundRect( -30, -8 - 150, 60, 16, 5, 5);
                button.graphics.endFill();
                
                buttonsHours.push(button);
                button.x = stage.stageWidth * .5;
                button.y = stage.stageHeight * .5;
                addChild(button);
                button.buttonMode = true;
                
                button.rotation = 360 / 12 * i;
            }
            for (i = 0; i < 60; i++) {
                button = new Sprite();
                if(i%5==0)
                    button.graphics.beginFill(0x990000);
                else
                    button.graphics.beginFill(0);
                button.graphics.drawRoundRect( -4, -4 - 120, 8, 8, 5, 5);
                button.graphics.endFill();
                
                buttonsMinutes.push(button);
                button.x = stage.stageWidth * .5;
                button.y = stage.stageHeight * .5;
                addChild(button);
                button.buttonMode = true;
                
                button.rotation = 360 / 12 * i;
                
            }
            for (var i:int = 0; i < 60; i++) {
                var button:Sprite = new Sprite();
                if(i%5==0)
                    button.graphics.beginFill(0x990000);
                else
                    button.graphics.beginFill(0);
                button.graphics.drawRoundRect( -4, -4 - 100, 8, 8, 5, 5);
                button.graphics.endFill();
                
                buttonsSeconds.push(button);
                button.x = stage.stageWidth * .5;
                button.y = stage.stageHeight * .5;
                addChild(button);
                button.buttonMode = true;
                
                button.rotation = 360 / 12 * i;
                
            }
            
            setInterval(tick, 300);
        }
        
        private function tick():void {
            var date:Date = new Date();
            // hours
            var index:int = date.hours % 12;
            var center:Number = 360 / 12 * index;
            while (center - buttonsHours[index].rotation > 180)
                center -= 360;
            while (center - buttonsHours[index].rotation < -180)
                center += 360;
            Tweener.addTween(buttonsHours[index], { rotation:center, time:1, scaleY:1.1 } );
            buttonsHours[index].transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0xFF, 0x66);
            for (var i:int = index + 1; i < index + 12; i++) {
                var r:int = i % 12;
                r = (r - index) % 12;
                var rot:Number = (360 / 13 * (r + ((r > 0)?.5: -.5)) + center);
                while (rot - buttonsHours[i % 12].rotation > 180)
                    rot -= 360;
                while (rot - buttonsHours[i % 12].rotation < -180)
                    rot += 360;
                Tweener.addTween(buttonsHours[i%12], { rotation:rot, scaleY:1, time:1 } );
                buttonsHours[i%12].transform.colorTransform = new ColorTransform();
            }
            // minutes
            index = date.minutes;
            var center:Number = 360 / 60 * index;
            while (center - buttonsMinutes[index].rotation > 180)
                center -= 360;
            while (center - buttonsMinutes[index].rotation < -180)
                center += 360;
            Tweener.addTween(buttonsMinutes[index], { rotation:center, time:1, scaleY:1.1 } );
            buttonsMinutes[index].transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0xFF, 0x66);
            for (var i:int = index + 1; i < index + 60; i++) {
                var r:int = i % 60;
                r = (r - index) % 60;
                var rot:Number = (360 / 61 * (r + ((r > 0)?.5: -.5)) + center);
                while (rot - buttonsMinutes[i % 60].rotation > 180)
                    rot -= 360;
                while (rot - buttonsMinutes[i % 60].rotation < -180)
                    rot += 360;
                Tweener.addTween(buttonsMinutes[i%60], { rotation:rot, scaleY:1, time:1 } );
                buttonsMinutes[i%60].transform.colorTransform = new ColorTransform();
            }
            // seconds
            index = date.seconds;
            var center:Number = 360 / 60 * index;
            while (center - buttonsSeconds[index].rotation > 180)
                center -= 360;
            while (center - buttonsSeconds[index].rotation < -180)
                center += 360;
            Tweener.addTween(buttonsSeconds[index], { rotation:center, time:1, scaleY:1.1 } );
            buttonsSeconds[index].transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0xFF, 0x66);
            for (var i:int = index + 1; i < index + 60; i++) {
                var r:int = i % 60;
                r = (r - index) % 60;
                var rot:Number = (360 / 61 * (r + ((r > 0)?.5: -.5)) + center);
                while (rot - buttonsSeconds[i % 60].rotation > 180)
                    rot -= 360;
                while (rot - buttonsSeconds[i % 60].rotation < -180)
                    rot += 360;
                Tweener.addTween(buttonsSeconds[i%60], { rotation:rot, scaleY:1, time:1 } );
                buttonsSeconds[i%60].transform.colorTransform = new ColorTransform();
            }
        }
    }
    
}