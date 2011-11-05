package {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock extends Sprite {
		public static const CLOCK_MODE_REAL:int = 0;
		public static const CLOCK_MODE_PREVIEW:int = 1;
		
		public static const NUMBER_OF_STAR:int = 12;
		
		public static const TIMER_SPEED:int = 1;
		public static const PREVIEW_DELAY:int = 10;
		public static const PREVIEW_SPEED:int = 4;
		public static var SWITCH_MINUTES_HOURS:int = 3;
		
		private var timer:Timer;
		//false - minutes     true - hours
		//private var mode:Boolean = false;
		private var mode:Boolean = true;
		private var numOfOnTimeCall:int;
		
		private var clock_mode:int = 0;
		
		private var txtTime:TXT_time;
		
		private var stars:Vector.<mc_star> = new Vector.<mc_star>();
		private var clockPoint:ClockPoint;
		private var content:Sprite;
		
		private var previewData:Array = [0,0,0];
		
		public function Clock(content:Sprite,clock_mode:int = 0){
			this.content = content;
			this.clock_mode = clock_mode;
			for (var i:int = 0; i < NUMBER_OF_STAR; i++){
				var star:mc_star = new mc_star();
				content.addChild(star);
				star.rotation = 360 / NUMBER_OF_STAR * i;
				star.star_red.rotation = -star.rotation;
				star.star_yellow.rotation = -star.rotation;
				stars.push(star);
			}
			
			clockPoint = new ClockPoint(stars);
			
			txtTime = new TXT_time();
			txtTime.scaleX = txtTime.scaleY = 1.7;
			content.addChild(txtTime);
			txtTime.txt.text = "";
			
			changeClockMode(clock_mode);
		}
		
		private function changeClockMode(_mode:int = 0):void {
			clock_mode = _mode;
			if (timer){
				timer.removeEventListener(TimerEvent.TIMER, onTime);
				timer.stop();
				timer = null;
			}
			
			switch (_mode){
				case CLOCK_MODE_REAL: 
					timer = new Timer(1000/TIMER_SPEED);
					timer.addEventListener(TimerEvent.TIMER, onTime);
					timer.start();
					onTime();
					break;
				case CLOCK_MODE_PREVIEW: 
					timer = new Timer(1000/PREVIEW_DELAY);
					timer.addEventListener(TimerEvent.TIMER, onTime);
					timer.start();
					onTime();
					break;
			}
		}
		
		private function onTime(e:TimerEvent = null):void {
			numOfOnTimeCall++;
			if (numOfOnTimeCall >= TIMER_SPEED * SWITCH_MINUTES_HOURS){
				mode = !mode;
				numOfOnTimeCall = 0;
			}
			
			if (clock_mode == 0){
				var date:Date = new Date();
				previewData[0] = date.hours;
				previewData[1] = date.minutes;
				previewData[2] = date.seconds;
			}
			else {
				previewData[2] += PREVIEW_SPEED;
				if (previewData[2] >= 60){
					previewData[1]++;
					previewData[2] = 0;
				}
				if (previewData[1] >= 60){
					previewData[0]++;
					previewData[1] = 0;
				}
				if (previewData[0] >= 24){
					previewData[0] = 0
				}
			}
			
			clockPoint.onTime(previewData[0], previewData[1], previewData[2], mode, timer.delay);
			//clockPoint.onTime(previewData[0], 0, 10, mode, timer.delay);
			updateTxtField(previewData[0], previewData[1], previewData[2]);
		}
		
		private function updateTxtField(hours:int, minutes:int, seconds:int):void {
			txtTime.txt.text = normalizeTxt(hours) + ":" + normalizeTxt(minutes);
		}
		
		private function normalizeTxt(s:int):String {
			return (s < 10) ? ("0" + s) : String(s);
		}
	}
}