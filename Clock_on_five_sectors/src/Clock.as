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
		public static const	INDICATOR_RADIUS	:int = 20;
		
		public static var arrClockElements		:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		public static var arrClockElementsMask	:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		public static var indicator				:Sprite;
		public static var isIndicatorActive		:Boolean = false;
		
		public var t						:Timer;
		private var txtTime					:TextField;
		private var mode					:int = 0;
		
		public function Clock(content:DisplayObjectContainer) 
		{
			var spriteElements:Sprite = new Sprite();
			content.addChild(spriteElements);
			
			for (var i:int = 0; i < 5; i++)
			{
				var mc:DisplayObject = new mcClockElement();
				spriteElements.addChild(mc);
				mc.rotation = i * 72;
				var image:Sprite = new Sprite();
				spriteElements.addChild(image);
				image.mask = mc;
				arrClockElements.push(image); 
				arrClockElementsMask.push(mc);
			}
			
			indicator = new Sprite();
			spriteElements.addChild(indicator);
			
			t = new Timer(1000 / CLOCK_SPEED);
			t.addEventListener(TimerEvent.TIMER, onTime);
			t.start();
			onTime();
		}
		
		private function onTime(e:TimerEvent = null):void
		{
			ClockTable.lightClock(arrClockElements, mode);
			mode++;
			
			if (mode >= 5)
				mode = 0;
		}
		
	}

}