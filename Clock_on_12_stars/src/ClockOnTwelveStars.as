package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockOnTwelveStars extends Sprite {
		
		public function ClockOnTwelveStars():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//var bk:mcPanelForElements = new mcPanelForElements();
			//addChild(bk);
			
			var sp_1:Sprite = new Sprite();
			addChild(sp_1);
			var sp_2:Sprite = new Sprite();
			addChild(sp_2);
			
			var clock:Clock = new Clock(sp_1);
			sp_1.x = sp_1.y = 300;
			sp_1.scaleX = sp_1.scaleY = 1.4;
			
			var clock2:Clock = new Clock(sp_2, Clock.CLOCK_MODE_PREVIEW);
			sp_2.x = 700;
			sp_2.y = 300;
			sp_2.scaleX = sp_2.scaleY = 1.4;
		}
	}
}