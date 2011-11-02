package {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock extends Sprite {
		public static const NUMBER_OF_STAR:int = 12;
		
		public static const TIMER_SPEED:int = 1;
		public static var SWITCH_MINUTES_HOURS:int = 3;
		
		private var timer:Timer;
		//false - minutes     true - hours
		//private var mode:Boolean = false;
		private var mode:Boolean = true;
		private var numOfOnTimeCall:int;
		
		private static var stars:Vector.<mc_star> = new Vector.<mc_star>();
		private var clockPoint:ClockPoint;
		
		public function Clock(content:Sprite){
			for (var i:int = 0; i < NUMBER_OF_STAR; i++){
				var star:mc_star = new mc_star();
				content.addChild(star);
				star.rotation = 360 / NUMBER_OF_STAR * i;
				star.star_red.rotation = -star.rotation;
				star.star_yellow.rotation = -star.rotation;
				//star.star_red.visible = false;
				stars.push(star);
			}
			
			clockPoint = new ClockPoint(stars);
			
			timer = new Timer(1000 / TIMER_SPEED);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTime);
			onTime();
		}
		
		private function onTime(e:TimerEvent = null):void {
			//numOfOnTimeCall++;
			//if (numOfOnTimeCall >= TIMER_SPEED * SWITCH_MINUTES_HOURS){
				//mode = !mode;
				//numOfOnTimeCall = 0;
			//}
			
			var date:Date = new Date();
			//var date:Date = new Date(null,null,null,17,31);
			clockPoint.onTime(date.hours, date.minutes, date.seconds, mode);
		}
	}
}