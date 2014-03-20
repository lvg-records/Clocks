package {
    import clock.model.Clock;

    import flash.display.Sprite;
	import flash.events.Event;


	[SWF(width = 600, height = 600)]
	public class ClockOnTwelveStars_v2 extends Sprite {

		public function ClockOnTwelveStars_v2():void {
			if(stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var content:Sprite = new Sprite();
			addChild(content);

			var clock:Clock = new Clock();
			clock.init(content);
		}
	}
}
