package {
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockPoint {
		
		public static var TYPE_0_TO_1:String = "easeInQuint";
		public static var TYPE_1_TO_0:String = "easeOutQuint";
		
		private var arrPoints:Vector.<mc_star>;
		
		public function ClockPoint(stars:Vector.<mc_star> = null){
			this.arrPoints = stars;
		}
		
		private function light(index_1:int, index_2:int, speed:Number):void {
			for (var i:int = 0; i < arrPoints.length; i++){
				if (i == index_1 || i == index_2)
					arrPoints[i].star_red.alpha = 1;
				else
					arrPoints[i].star_red.alpha = 0;
			}
			if (index_2 != -1)
				lightStar(index_2, speed);
		}
		
		private function lightStar(index:int, speed:Number):void {
			Tweener.removeAllTweens();
			Tweener.addTween(arrPoints[index].star_red, {alpha: 0, time: speed, onComplete: lightBack, transition: TYPE_0_TO_1});
			
			function lightBack():void {
				Tweener.addTween(arrPoints[index].star_red, {alpha: 1, time: speed, transition: TYPE_1_TO_0});
			}
		}
		
		public function onTime(time_hours:Number, time_minutes:Number, time_seconds:Number, mode:Boolean, delay:Number):void {
			trace(arguments);
			
			//mode = false;
			//time_hours = 15;
			//time_minutes = 33;
			
			var speed:Number = (delay - delay * .1) / 2;
			if (!mode){
				light(time_hours % 12, -1, -1)
				return;
			}
			
			var less:Boolean = (int(time_minutes % 5) > 2);
			var index_1:int = (time_minutes / 5) + (less ? 1 : 0);
			var index_2:int = index_1 + (less ? -1 : +1);
			
			light(index_1, index_2, speed);
		}
	}
}