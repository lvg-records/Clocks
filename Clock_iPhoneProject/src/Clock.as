package  
{
	import clockPart.ArrowHours;
	import clockPart.ArrowMinutes;
	import clockPart.ArrowSeconds;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock extends Sprite
	{
		public static const CLOCK_DELTA_X:int = 300;
		public static const CLOCK_DELTA_Y:int = 300;
		
		private var time:Timer;
		
		private var arrow_seconds:ArrowSeconds;
		private var arrow_minutes:ArrowMinutes;
		private var arrow_hourds:ArrowHours;
		private var center:MovieClip;
		private var grid:Grid;
		
		public function Clock() 
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			//scaleX = scaleY = 1;
			init();
			time = new Timer(1000);
			time.addEventListener(TimerEvent.TIMER,onTime);
			time.start();
			addEventListener(AccelerometerEvent.UPDATE,onAccelerometr);
		}
		
		private function onAccelerometr(e:AccelerometerEvent):void 
		{
			trace(e);
		}
		
		private function init():void 
		{
			x = CLOCK_DELTA_X;
			y = CLOCK_DELTA_Y;
			
			arrow_minutes = new ArrowMinutes();
			addChild(arrow_minutes);
			
			arrow_seconds = new ArrowSeconds();
			addChild(arrow_seconds);
			
			arrow_hourds = new ArrowHours();
			addChild(arrow_hourds);
			
			center = new mcCenter();
			addChild(center);
			
			Cheats.initializeCheats(this);
			onTime();
		}
		
		private function onTime(e:TimerEvent = null):void 
		{
			var date:Date = new Date();
			arrow_seconds.updatePosition(date.seconds);
			arrow_minutes.updatePosition(date.minutes);
			arrow_hourds.updatePosition(date.hours);
		}
	}
}