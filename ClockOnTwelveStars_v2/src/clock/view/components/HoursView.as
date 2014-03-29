package clock.view.components {
	import flash.display.Sprite;


	public class HoursView extends StarsView {

		public function HoursView(content:Sprite) {
			super(content);
		}

		override protected function createStars():void {
			super.createStars();

			hideStarsExcept("hours_mc");
		}

		override public function update(date:Date):void {
			super.update(date);

			for(var starIndex:int = 0; starIndex < stars.length; starIndex++) {
				var star:mc_star = stars[starIndex];
				star.visible = starIndex == int(date.hours % 12);
			}
		}
	}
}
