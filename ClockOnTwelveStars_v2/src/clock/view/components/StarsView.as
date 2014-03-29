package clock.view.components {
	import flash.display.DisplayObject;
	import flash.display.Sprite;


	public class StarsView {

		protected const NUMBER_OF_STAR:int = 12;

		private var _content:Sprite;
		protected var stars:Vector.<mc_star>;

		public function StarsView(content:Sprite) {

			this._content = new Sprite();
			content.addChild(this._content);

			createStars();
		}

		protected function createStars():void {

			stars = new <mc_star>[];
			for(var i:int = 0; i < NUMBER_OF_STAR; i++) {
				var star:mc_star = new mc_star();
				_content.addChild(star);
				star.rotation = 360 / NUMBER_OF_STAR * i;
				for(var starChildIndex:int = 0; starChildIndex < star.numChildren; starChildIndex++) {
					var child:DisplayObject = star.getChildAt(starChildIndex);
					child.rotation = -star.rotation;
				}
				stars.push(star);
			}
		}

		public function update(date:Date):void {

		}

		public function get content():Sprite {
			return _content;
		}

		protected function hideStarsExcept(starName:String):void {

			for(var starIndex:int = 0; starIndex < stars.length; starIndex++) {
				var star:mc_star = stars[starIndex];
				for(var starChildIndex:int = 0; starChildIndex < star.numChildren; starChildIndex++) {
					var child:DisplayObject = star.getChildAt(starChildIndex);
					child.visible = child.name == starName;
				}
			}
		}
	}
}
