package {
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock {
		public static const IMAGE_NAME:String = 'image';
		public static const IMAGE_MASK:String = 'mask';
		public static const DELTA:int = 300;
		public static var CLOCK_SPEED:int = 2;
		public static const INDICATOR_RADIUS:int = 64;
		
		public static var t:Timer;
		private var txtTime:TextField;
		private var mode:int = 0;
		
		public static var nuber_txt:mc_number;
		
		public function Clock(content:DisplayObjectContainer){
			nuber_txt = new mc_number();
			content.addChild(nuber_txt);
			
			t = new Timer(1000 / CLOCK_SPEED);
			t.addEventListener(TimerEvent.TIMER, onTime);
			t.start();
			onTime();
		}
		
		private function onTime(e:TimerEvent = null):void {
			trace(getTimer());
			ClockTable.lightClock(nuber_txt, mode);
			mode++;
			
			if (mode >= 8)
				mode = 0;
		}
	}
}