package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock {
		public static const IMAGE_NAME:String = 'image';
		public static const IMAGE_MASK:String = 'mask';
		public static const DELTA:int = 300;
		public static var CLOCK_SPEED:int = 1;
		public static const INDICATOR_RADIUS:int = 64;
		
		private var txtTime:TXT_time;
		
		public var arrClockElements:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		public var arrClockElementsMask:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		//public static var indicator:Sprite;
		public static var tips:Sprite;
		public static var isIndicatorActive:Boolean = false;
		
		public var t:Timer;
		
		private var mode:int = 0;
		
		public function Clock(content:DisplayObjectContainer){
			var spriteElements:Sprite = new mcBorder();
			content.addChild(spriteElements);
			
			for (var i:int = 0; i < 5; i++){
				//var mc:DisplayObject = new mcClockElement();
				var mc:DisplayObject = new mc_romb();
				spriteElements.addChild(mc);
				mc["romb"].visible = false;
				//mc.rotation = i * 72 + 72;
				mc.rotation = i * 72 + 80.6;
				var image:Sprite = new Sprite();
				spriteElements.addChild(image);
				image.mask = mc;
				arrClockElements.push(image);
				arrClockElementsMask.push(mc);
			}
			
			//indicator = new Sprite();
			//spriteElements.addChild(indicator);
			//indicator.visible = false;
			
			tips = new mcTips();
			spriteElements.addChildAt(tips, spriteElements.numChildren);
			
			txtTime = new TXT_time();
			spriteElements.addChild(txtTime);
			txtTime.txt.text = "";
			txtTime.y = 25;
			
			t = new Timer(1000 / CLOCK_SPEED);
			t.addEventListener(TimerEvent.TIMER, onTime);
			t.start();
			onTime();
		}
		
		private function updateTxtField(hours:int, minutes:int, seconds:int):void {
			txtTime.txt.text = normalizeTxt(hours) + ":" + normalizeTxt(minutes);
		}
		
		private function normalizeTxt(s:int):String {
			return (s < 10) ? ("0" + s) : String(s);
		}
		
		private function onTime(e:TimerEvent = null):void {
			ClockTable.lightClock(arrClockElements, mode, updateTxtField, this);
			mode++;
			
			if (mode >= 5)
				mode = 0;
		}
	
	}

}