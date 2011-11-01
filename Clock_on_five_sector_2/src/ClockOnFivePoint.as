package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockOnFivePoint extends Sprite {
		private var clock:Clock;
		private var controlPanel:ControlPanel;
		
		public function ClockOnFivePoint():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			
			sprite.x = Clock.DELTA;
			sprite.y = Clock.DELTA + 80;
			clock = new Clock(sprite);
			
			var sprite2:Sprite = new Sprite();
			addChild(sprite2);
			sprite2.x = Clock.DELTA *2.5;
			sprite2.y = Clock.DELTA + 80;
			var clock2:Clock = new Clock(sprite2, 1);
			
			//controlPanel = new ControlPanel(sprite, clock);
			//addChild(controlPanel);
		}
	
	}
}