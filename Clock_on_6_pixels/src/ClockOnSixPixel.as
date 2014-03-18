package {
	import flash.display.Sprite;
	import flash.events.Event;



	public class ClockOnSixPixel extends Sprite {

		private var controlPanel:ControlPanel;

		public function ClockOnSixPixel():void {

			if(stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var _mask:Sprite = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, 600, 600);
			_mask.graphics.endFill();
			addChild(_mask);

			var sprite:Sprite = new Sprite();
			addChild(sprite);
			sprite.mask = _mask;

			var bk:Sprite = new mcPanelForElements();
			sprite.addChild(bk);

			var clock:Clock = new Clock(bk['place']);

			controlPanel = new ControlPanel(sprite, clock);
			addChild(controlPanel);
		}

	}
}
