package {
	import flash.display.Sprite;
	import flash.events.TimerEvent;

    import view.ClockView;


    public class Clock {

		private var clockView:ClockView;
		private var clockTimer:ClockTimer;

		public function Clock() {

		}

        public function init(content:Sprite):void {

			clockView = new ClockView();
			clockView.init(content);

			clockTimer = new ClockTimer();
			clockTimer.addEventListener(TimerEvent.TIMER, updateView);
			clockTimer.start();
		}

		private function updateView(event:TimerEvent):void {
			clockView.update(clockTimer.getCurrentDate());
		}
	}
}
