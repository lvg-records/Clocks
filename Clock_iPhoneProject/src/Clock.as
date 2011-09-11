package  
{
	import clockPart.ArrowHours;
	import clockPart.ArrowMinutes;
	import clockPart.ArrowSeconds;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock extends Sprite
	{
		public static const CLOCK_MODE_REAL		:int = 0;
		public static const CLOCK_MODE_PREVIEW	:int = 1;
		
		public static const PREVIEW_SPEED		:int = 2;
		
		public static const CLOCK_DELTA_X:int = 300;
		public static const CLOCK_DELTA_Y:int = 300;
		
		private var time:Timer;
		
		private var arrow_seconds:ArrowSeconds;
		private var arrow_minutes:ArrowMinutes;
		private var arrow_hourds:ArrowHours;
		private var center:MovieClip;
		private var grid:Grid;
		
		private var previewData:Array = [0, 0, 0];
		
		private var mode:int = 0;
		
		public function Clock() 
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			init();
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
			
			
			changeClockMode(CLOCK_MODE_PREVIEW);
		}
		
		private function changeClockMode(_mode:int = 0):void 
		{
			mode = _mode;
			if (time)
			{
				time.removeEventListener(TimerEvent.TIMER,onTime);
				time.stop();
				time = null;
			}
			
			
			switch (_mode)
			{
				case CLOCK_MODE_REAL:
					time = new Timer(1000);
					time.addEventListener(TimerEvent.TIMER,onTime);
					time.start();
					onTime();
				break;
				case CLOCK_MODE_PREVIEW:
					addEventListener(Event.ENTER_FRAME, onEnterFrame)
				break;
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			previewData[2]+=PREVIEW_SPEED;
			if (previewData[2] >= 60)
			{
				previewData[1]++;
				previewData[2] = 0;
			}
			if (previewData[1] >= 60)
			{
				previewData[0]++;
				previewData[1] = 0;
			}
			if (previewData[0] >= 24)
			{
				previewData[0] = 0
			}
			arrow_seconds.updatePosition(previewData[2]);
			arrow_minutes.updatePosition(previewData[1]);
			arrow_hourds.updatePosition(previewData[0]);
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