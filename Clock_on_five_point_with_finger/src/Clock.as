package  
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock 
	{
		public static const IMAGE_NAME			:String = 'image';
		public static const IMAGE_MASK			:String = 'mask';
		public static const DELTA				:int = 300;
		public static var   CLOCK_SPEED			:int = 1;
		
		public static var arrClockElementsMask	:Vector.<mcClockElement> = new Vector.<mcClockElement>();
		public static var tips					:mcTips;
		
		public static var t					:Timer;
		private var txtTime					:TextField;
		private var mode					:int = 0;
		public static var finger:Finger;
		
		public function Clock(content:DisplayObjectContainer) 
		{
			var spriteElements:Sprite = new mcBorder();
			content.addChild(spriteElements);
			
			for (var i:int = 0; i < 5; i++)
			{
				var mc:mcClockElement = new mcClockElement();
				spriteElements.addChild(mc);
				mc.rotation = i * 72 + 72;
				mc.bbb.rotation =  - (i * 72 + 72);
				mc.y = -5;
				arrClockElementsMask.push(mc);
			}
			finger = new Finger();
			spriteElements.addChild(finger);
			finger.scaleX = finger.scaleY = 1.3;
			finger.fing.alpha = 0.25;
			finger.alpha = 0.3;
			
			finger.gotoAndStop(11);
			
			tips = new mcTips();
			tips.t_5.visible = false;
			spriteElements.addChildAt(tips,spriteElements.numChildren);
			
			t = new Timer(1000 / CLOCK_SPEED);
			t.addEventListener(TimerEvent.TIMER, onTime);
			t.start();
			onTime();
		}
		
		private function onTime(e:TimerEvent = null):void
		{
			ClockTable.lightClock(arrClockElementsMask, mode);
			mode++;
			
			if (mode >= 5)
				mode = 0;
		}
	}
}