/**
 * Copyright arithma ( http://wonderfl.net/user/arithma )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/zyEA
 */

package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import flash.text.TextField;
	import flash.display.Sprite;
        import flash.system.LoaderContext;
	public class Main extends Sprite {
		private const dt = 0.003;
		private var bitdata:BitmapData;
		private var ldr:Loader;
		private var butterflies:Array;
		private var timer:Number;
		private var timerTXT:TextField;
		public function Main():void {
			stage.frameRate = 120;
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			ldr.load(new URLRequest(
"http://assets.wonderfl.net/images/related_images/0/06/0635/06352a3dc6759a85d732f374bffadaa7be0efacd"),
new LoaderContext(true));
			butterflies = new Array();
			timer = getTimer();
			timerTXT = new TextField();
			addChild(timerTXT);
		}
		
		function onLoaded(e:Event):void {
			var bitmap:Bitmap = ldr.content as Bitmap;
			
			bitdata = bitmap.bitmapData;
			
			for (var i:int = 0; i < 100; i++) {
				var butterfly:Butterfly = new Butterfly();
				var ratio:Number = Math.random() * 0.5 + 0.5;
				butterfly.scaleX = 0.05 * ratio;
				butterfly.scaleY = 0.05 * ratio;
				butterfly.index = (Math.floor(Math.random() * 20));
				
				butterfly.x = stage.stageWidth * Math.random();
				butterfly.y = stage.stageHeight * 0.9 + (1 - Math.pow(Math.random(), 2)) * stage.stageHeight * 0.1;
				
				butterfly.vx = Math.random() * 30 + 10;
				butterfly.vy = 0;
				
				var color:uint = bitdata.getPixel(Math.round(Math.random()*bitdata.width), 0);
				var r:uint = color / 0x10000;
				var g:uint = color / 0x100 % 0x100;
				var b:uint = color % 0x100;
				butterfly.transform.colorTransform =
                                    new ColorTransform(0, 0, 0, 0.8, r, g, b);
				
				addChild(butterfly);
				butterflies.push(butterfly);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		function onEnterFrame(e:Event):void {
			timerTXT.text = String(Number(timerTXT.text)*0.9+0.1*(getTimer() - timer));
			timer = getTimer();
			for each(var b in butterflies) {
				b.x += b.vx * dt;
				b.y += b.vy * dt;
				
				b.vx += ((Math.random() * 2 - 1) * 5000 + (stage.mouseX - b.x) * 3) * dt;
				b.vy += ((Math.random() * 2 - 1) * 5000 + (stage.mouseY - b.y) * 3) * dt;
				b.vx *= Math.pow(0.5, dt);
				b.vy *= Math.pow(0.5, dt);
				b.rotation = -Math.atan2( -b.vy, b.vx) * 180 / Math.PI;
				b.update();
			}
		}
	}
}
import flash.display.Shape;
import flash.display.Sprite;

class ButterflyWing extends Shape{
	public function ButterflyWing():void {
		graphics.beginFill(0);
		
		graphics.curveTo(200+100, 180+0, 200, 180);
		graphics.curveTo(-50+0, 150+90, -50, 150);
		graphics.curveTo(-150+50, 200+50, -150, 200);
		graphics.curveTo(-100, 0, 0, 0);
		
		graphics.endFill();
	}
}

class Butterfly extends Sprite {
	private var wing1:ButterflyWing;
	private var wing2:ButterflyWing;
	public var index:int;
	public var vx:Number;
	public var vy:Number;
	
	public function Butterfly():void {
		vx = 0;
		vy = 0;
		
		index = 0;
		
		wing1 = new ButterflyWing();
		wing2 = new ButterflyWing();
		wing2.scaleY = -1;
		
		addChild(wing1);
		addChild(wing2);
	}
	
	public function update():void {
		if (index < 10){
			wing1.scaleY = +.5;
			wing2.scaleY = -.5;
		}
		else{
			wing1.scaleY = +1;
			wing2.scaleY = -1;
		}
		index = (index + 1) % 20;
	}
}