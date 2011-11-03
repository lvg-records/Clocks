package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockOnTwelveStars extends Sprite {
		private var controlPanel:ControlPanel;
		
		public function ClockOnTwelveStars():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			
			var bk:Sprite = new mcPanelForElements();
			sprite.addChild(bk);
			
			var clock:Clock = new Clock(bk['place']);
		}
	}
}