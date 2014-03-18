package {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	public class Clock extends Sprite {

		public static const TIMER_SPEED:int = 1;
		public static var SWITCH_MINUTES_HOURS:int = 15;

		public static var arrPoints:Vector.<ClockPoint>;
		private var timer:Timer;
		//false - minutes     true - hours
		private var mode:Boolean = false;
		private var numOfOnTimeCall:int;

		public function Clock(content:Sprite) {

			arrPoints = new Vector.<ClockPoint>();
			arrPoints.push(new ClockPoint(content, 1, 0));
			arrPoints.push(new ClockPoint(content, 1, 1));
			arrPoints.push(new ClockPoint(content, 1, 2));
			arrPoints.push(new ClockPoint(content, 0, 2));
			arrPoints.push(new ClockPoint(content, 0, 1));
			arrPoints.push(new ClockPoint(content, 0, 0));

			timer = new Timer(1000 / TIMER_SPEED);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTime);

			onTime();
		}

		private function onTime(e:TimerEvent = null):void {

			numOfOnTimeCall++;
			if(numOfOnTimeCall >= TIMER_SPEED * SWITCH_MINUTES_HOURS) {
				mode = !mode;
				numOfOnTimeCall = 0;
			}

			var date:Date = new Date();
			ClockPoint.onTime(date.minutes, date.hours, date.seconds, mode);
		}

	}
}
