package {

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	[SWF(width = '600', height = '600', backgroundColor = '#003298')]
	public class Start_ver2 extends Sprite {

		private var container:mainContainer;
		private var itemContainers:Vector.<itemContainer>;

		public function Start_ver2() {
			initContainer();
			initStars();
			initTimeHandler();
		}

		private function initContainer():void {
			container = new mainContainer();
			addChild(container);
		}

		private function initStars():void {
			itemContainers = new Vector.<itemContainer>();
			for(var i:int = 0; i < 12; i++) {
				var star:itemContainer = container["item_" + i];
				itemContainers.push(star);
			}
		}

		private function initTimeHandler():void {
			var timer:Timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, timeUpdater);
			timer.start();
			timeUpdater();
		}

		private function timeUpdater(event:TimerEvent = null):void {
			for each(var _itemContainer:itemContainer in itemContainers) {
				_itemContainer.gotoAndStop(1);
			}

			var date:Date = new Date();

			var currentHour:int = (date.hours % 12);
			itemContainers[currentHour].gotoAndStop(2);

			var currentMinutes:int = (date.minutes / 5);
			itemContainers[currentMinutes].gotoAndStop(3 + date.minutes % 5);
		}
	}
}
