package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ArcClock_v2 extends Sprite {
		private var clock:Clock;
		private var clock_preview:Clock;
		
		public function ArcClock_v2():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//var _grid:MovieClip = new mcGrid_2();
			//addChild(_grid);
			//_grid.x = Clock.CLOCK_DELTA_X;
			//_grid.y = Clock.CLOCK_DELTA_Y;
			
			clock = new Clock(Clock.CLOCK_MODE_REAL);
			addChild(clock);
			clock.scaleX = clock.scaleY = 1.6;
			
			clock_preview = new Clock(Clock.CLOCK_MODE_PREVIEW);
			addChild(clock_preview);
			clock_preview.scaleX = clock_preview.scaleY = 1.6;
			clock_preview.x = Clock.CLOCK_DELTA_X * 3;
		}
	}
}