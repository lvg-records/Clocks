package {
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockPoint {
		
		public static var TYPE_0_TO_1:String;
		public static var TYPE_1_TO_0:String;
		
		public static var lastUsedPoint:int = -7;
		public static var _speed:Number;
		public static var isUp:Boolean = false;
		
		private var numToSplash:int = 0;
		
		private var arrPoints:Vector.<mc_star>;
		
		public function ClockPoint(stars:Vector.<mc_star> = null){
			this.arrPoints = stars;
		}
		
		private function changeOnTime(activeClockPoint:uint, light:int = -1, speed:int = 2):void {
			for (var i:int = 0; i < arrPoints.length; i++){
				if (i == activeClockPoint)
					arrPoints[i].star_red.alpha = 1;
				else if (i != light)
					arrPoints[i].star_red.alpha = 0;
			}
			//clock mode
			if (speed < 0){
				Tweener.removeAllTweens();
				arrPoints[activeClockPoint].star_red.alpha = 1;
				if (activeClockPoint > light || (activeClockPoint == 0 && light == 5))
					arrPoints[light].star_red.alpha = 1;
				else
					arrPoints[light].star_red.alpha = 0;
				//lastUsedPoint = -7;
				return;
			}
			//end clock mode
			
			isUp = Boolean(activeClockPoint < light);
			_speed = !isUp ? speed : (300 - speed);
			if (light != -1){
				if (lastUsedPoint != light){
					Tweener.removeAllTweens();
					lastUsedPoint = light;
					tweenPoint();
				}
			}
		}
		
		private function tweenPoint():void {
			var trnsation_type:String = (arrPoints[lastUsedPoint].star_red.alpha < 0.5) ? TYPE_0_TO_1 : TYPE_1_TO_0;
			
			if (lastUsedPoint > 0 && lastUsedPoint < 7){
				var curSpeed:Number = _speed / 100;
				if (curSpeed < 0.1){
					if (arrPoints[lastUsedPoint].star_red.alpha < 0.5)
						Tweener.addTween(arrPoints[lastUsedPoint].star_red, {alpha: 1, time: curSpeed});
					setTimeout(tweenPoint, 1000);
					return;
				}
				Tweener.removeAllTweens();
				Tweener.addTween(arrPoints[lastUsedPoint].star_red, {alpha: Math.abs(arrPoints[lastUsedPoint].star_red.alpha - 1), time: curSpeed, onComplete: tweenPoint /*, transition: trnsation_type*/});
			}
		}
		
		public function onTime(time_hours:Number, time_minutes:Number, time_seconds:Number, mode:Boolean):void {
			trace(arguments);
			
			time_hours = 15;
			time_minutes = 34;
			
			var _sector:int = mode ? (time_minutes / 5) : time_hours % 12;
			var speed:Number = mode ? (int(time_minutes % 5) * 60 + time_seconds) : -1;
			
			var less:Boolean = (int(time_minutes % 5) > 2);
			var index_1:int = (time_minutes / 5) + (less? 1:0) //time_minutes / 5;
			var index_2:int = index_1+(less? -1 :+1);
			
			changeOnTime(index_1, index_2, speed);
			
			//if (speed == -1)
				//changeOnTime(time_hours % 12);
			//changeOnTime(_sector, 1, speed);
			return;
			//else
				switch (_sector){
				case 0: 
					changeOnTime(0, 5, speed);
					break;
				case 1: 
					changeOnTime(0, 1, speed);
					break;
				case 2: 
					changeOnTime(1, 0, speed);
					break;
				case 3: 
					changeOnTime(1, 2, speed);
					break;
				case 4: 
					changeOnTime(2, 1, speed);
					break;
				case 5: 
					changeOnTime(2, 3, speed);
					break;
				case 6: 
					changeOnTime(3, 2, speed);
					break;
				case 7: 
					changeOnTime(3, 4, speed);
					break;
				case 8: 
					changeOnTime(4, 3, speed);
					break;
				case 9: 
					changeOnTime(4, 5, speed);
					break;
				case 10: 
					changeOnTime(5, 4, speed);
					break;
				case 11: 
					changeOnTime(5, 0, speed);
					break;
			}
		}
	}
}