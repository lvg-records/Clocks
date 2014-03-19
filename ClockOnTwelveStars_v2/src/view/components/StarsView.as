package view.components {
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
				star.star_red.rotation = -star.rotation;
				star.star_yellow.rotation = -star.rotation;
				stars.push(star);
			}
		}

		public function update(date:Date):void {

		}

		public function get content():Sprite {
			return _content;
		}
	}
}
