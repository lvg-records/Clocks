package clock.model {
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	[Event(type = "flash.events.TimerEvent", name = "timer")]
	public class ClockTimer extends EventDispatcher {

		private var timer:Timer;

		public function ClockTimer() {
			init();
		}

		private function init():void {
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimeChange);
		}

		private function onTimeChange(event:TimerEvent = null):void {
			dispatchEvent(new TimerEvent(TimerEvent.TIMER));
		}

		public function start():void {
			timer.start();
			onTimeChange();
		}

		public function stop():void {
			timer.stop();
		}

		public function getCurrentDate():Date {
			var date:Date = new Date();
			var date:Date = new Date(null, null, null, 20, 13, 37);
			return date;
		}
	}
}
