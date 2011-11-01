package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock {
		
		public static const CLOCK_MODE_REAL:int = 0;
		public static const CLOCK_MODE_PREVIEW:int = 1;
		
		public static const IMAGE_NAME:String = 'image';
		public static const IMAGE_MASK:String = 'mask';
		public static const DELTA:int = 300;
		public static var CLOCK_SPEED:int = 1;
		public static const INDICATOR_RADIUS:int = 64;
		
		private var txtTime:TXT_time;
		
		public var arrClockElements:Vector.<mc_romb> = new Vector.<mc_romb>();
		//public var arrClockElementsMask:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public var tips:Sprite;
		public var clockTable:ClockTable;
		
		public var t:Timer;
		
		private var mode:int = 0;
		private var clock_mode:int = 0;
		private var content:DisplayObjectContainer;
		
		public function Clock(content:DisplayObjectContainer, mode:int = CLOCK_MODE_REAL){
			this.content = content;
			clock_mode = mode;
			content.scaleX = content.scaleY = 0.7;
			var spriteElements:Sprite = new mcBorder();
			content.addChild(spriteElements);
			
			clockTable = new ClockTable(this);
			
			for (var i:int = 0; i < 5; i++){
				var mc:mc_romb = new mc_romb();
				spriteElements.addChild(mc);
				mc.romb.visible = false;
				mc.rotation = i * 72 + 80.6;
				var image:Sprite = new Sprite();
				spriteElements.addChild(image);
				//image.mask = mc;
				arrClockElements.push(mc);
					//arrClockElementsMask.push(mc);
			}
			
			tips = new mcTips();
			spriteElements.addChildAt(tips, spriteElements.numChildren);
			
			txtTime = new TXT_time();
			txtTime.scaleX = txtTime.scaleY = 1.7;
			spriteElements.addChild(txtTime);
			txtTime.txt.text = "";
			
			changeClockMode(clock_mode);
		}
		
		private function changeClockMode(_mode:int = 0):void {
			mode = _mode;
			if (t){
				t.removeEventListener(TimerEvent.TIMER, onTime);
				t.stop();
				t = null;
			}
			if (content.hasEventListener(Event.ENTER_FRAME))
				content.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			switch (_mode){
				case CLOCK_MODE_REAL: 
					t = new Timer(1000);
					t.addEventListener(TimerEvent.TIMER, onTime);
					t.start();
					onTime();
					break;
				case CLOCK_MODE_PREVIEW: 
					//content.addEventListener(Event.ENTER_FRAME, onEnterFrame);
					t = new Timer(1000/ClockTable.PREVIEW_SPEED);
					t.addEventListener(TimerEvent.TIMER, onTime);
					t.start();
					onTime();
					break;
			}
		}
		
		private function onEnterFrame(e:Event):void {
			onTime();
		}
		
		private function updateTxtField(hours:int, minutes:int, seconds:int):void {
			txtTime.txt.text = normalizeTxt(hours) + ":" + normalizeTxt(minutes);
		}
		
		private function normalizeTxt(s:int):String {
			return (s < 10) ? ("0" + s) : String(s);
		}
		
		private function onTime(e:TimerEvent = null):void {
			clockTable.lightClock(arrClockElements, mode, updateTxtField, clock_mode);
			mode++;
			
			if (mode >= 5)
				mode = 0;
		}
	}
}