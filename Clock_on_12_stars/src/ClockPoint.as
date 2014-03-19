package {
	import caurina.transitions.Tweener;


	public class ClockPoint {

		public static var TYPE_0_TO_1:String = "easeInQuint";
		public static var TYPE_1_TO_0:String = "easeOutQuint";

		private var arrPoints:Vector.<mc_star>;

		public function ClockPoint(stars:Vector.<mc_star> = null) {
			this.arrPoints = stars;
		}

		private function light(index_1:int, index_2:int, speed:Number, light_number:int):void {
			for(var i:int = 0; i < arrPoints.length; i++) {
				if(i == index_1 || i == index_2) {
					arrPoints[i].star_red.alpha = 1;
				} else {
					arrPoints[i].star_red.alpha = 0;
				}
			}
			if(index_2 != -1) {
				lightStar(index_2, speed, light_number);
			}
		}

		private function lightStar(index:int, speed:Number, light_number:int):void {
			if(light_number <= 0) {
				return;
			}

			Tweener.addTween(arrPoints[index].star_red, {alpha:0, time:speed, onComplete:lightBack, transition:TYPE_0_TO_1});

			function lightBack():void {
				light_number -= 2;
				Tweener.addTween(arrPoints[index].star_red, {alpha:1, time:speed, onComplete:recurse, transition:TYPE_1_TO_0});
			}

			function recurse():void {
				lightStar(index, speed, light_number);
			}
		}

		public function onTime(time_hours:Number, time_minutes:Number, time_seconds:Number, mode:Boolean, delay:Number):void {
			//trace(arguments);
			//Tweener.removeAllTweens();

			//var speed:Number = (delay - delay * .1) / 2000;
			//var light_number:int = 2;
			//time_minutes = 0;
			//time_seconds = 40;
			var d:Number = ((delay /*- delay * .1*/) / 2000);
			var percent:Number = ((int(time_minutes % 5) * 60 + time_seconds)) / 300;
			var light_number:int = (d * 10 * percent + 2);
			//light_number = (int(light_number / 2) == 0) ? light_number : light_number - 1;

			var speed:Number = (d / light_number);
			if(!mode) {
				light(time_hours % 12, -1, -1, -1)
				return;
			}

			var less:Boolean = (int(time_minutes % 5) > 2);
			var index_1:int = (time_minutes / 5) + (less ? 1 : 0);
			var index_2:int = index_1 + (less ? -1 : +1);

			index_1 = index_1 == 12 ? 0 : index_1;
			index_2 = index_2 == 12 ? 0 : index_2;

			light(index_1, index_2, speed, light_number);
		}
	}
}
