package {
	import clockPart.ArrowHours;
	import clockPart.ArrowMinutes;
	import clockPart.ArrowSeconds;
	import fl.controls.CheckBox;
	import fl.events.ComponentEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Clock extends Sprite {
		
		public static const CLOCK_MODE_REAL:int = 0;
		public static const CLOCK_MODE_PREVIEW:int = 1;
		
		public static const PREVIEW_SPEED:int = 2;
		
		public static const CLOCK_DELTA_X:int = 250;
		public static const CLOCK_DELTA_Y:int = 300;
		
		private var time:Timer;
		
		private var arrow_seconds:ArrowSeconds;
		private var arrow_minutes:ArrowMinutes;
		private var arrow_hourds:ArrowHours;
		private var center:MovieClip;
		private var grid:Grid;
		
		private var txtTime:TXT_time;
		
		private var previewData:Array = [0, 0, 0];
		
		private var mode:int = 0;
		private var clock_mode:int = 0;
		
		public function Clock(clock_mode:int = 0){
			this.clock_mode = clock_mode;
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			init();
		}
		
		private function init():void {
			x = CLOCK_DELTA_X;
			y = CLOCK_DELTA_Y;
			
			arrow_minutes = new ArrowMinutes();
			addChild(arrow_minutes);
			
			arrow_seconds = new ArrowSeconds();
			addChild(arrow_seconds);
			
			arrow_hourds = new ArrowHours();
			addChild(arrow_hourds);
			
			center = new mcCenter();
			addChild(center);
			
			txtTime = new TXT_time();
			addChild(txtTime);
			txtTime.txt.text = "";
			txtTime.y = 25;
			
			Cheats.initializeCheats(this);
			
			var chBox:CheckBox = new CheckBox();
			chBox.visible = false;
			chBox.label = "Preview";
			addChild(chBox);
			chBox.y = -170;
			chBox.addEventListener(ComponentEvent.BUTTON_DOWN, onBtnDown);
			function onBtnDown(e:ComponentEvent):void {
				changeClockMode(int(!chBox.selected));
			}
			
			changeClockMode(clock_mode);
		}
		
		private function changeClockMode(_mode:int = 0):void {
			mode = _mode;
			if (time){
				time.removeEventListener(TimerEvent.TIMER, onTime);
				time.stop();
				time = null;
			}
			if (hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			switch (_mode){
				case CLOCK_MODE_REAL: 
					time = new Timer(1000);
					time.addEventListener(TimerEvent.TIMER, onTime);
					time.start();
					onTime();
					break;
				case CLOCK_MODE_PREVIEW: 
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
					break;
			}
		}
		
		private function onEnterFrame(e:Event):void {
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
			
			moveClockArrows(previewData[0], previewData[1], previewData[2]);
			arrow_seconds.updatePosition(previewData[2]);
			arrow_minutes.updatePosition(previewData[1]);
			arrow_hourds.updatePosition(previewData[0]);
		}
		
		private function onTime(e:TimerEvent = null):void {
			var date:Date = new Date();
			
			moveClockArrows(date.hours, date.minutes, date.seconds);
		}
		
		private function moveClockArrows(hours:int, minutes:int, seconds:int):void {
			updateTxtField(hours, minutes, seconds);
			arrow_hourds.updatePosition(hours);
			arrow_minutes.updatePosition(minutes);
			arrow_seconds.updatePosition(seconds);
		}
		
		private function updateTxtField(hours:int, minutes:int, seconds:int):void {
			//txtTime.txt.text = normalizeTxt(hours) + ":" + normalizeTxt(minutes) + ":" + normalizeTxt(seconds);
			txtTime.txt.text = normalizeTxt(hours) + ":" + normalizeTxt(minutes);
		}
		
		private function normalizeTxt(s:int):String {
			return (s < 10) ? ("0" + s) : String(s);
		}
	}
}