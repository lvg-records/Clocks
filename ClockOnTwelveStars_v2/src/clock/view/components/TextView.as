package clock.view.components {
	import flash.display.Sprite;


	public class TextView extends StarsView {

		private var txtTime:TXT_time;

		public function TextView(content:Sprite) {
			super(content);
		}

		override protected function createStars():void {

			txtTime = new TXT_time();
			txtTime.txt.text = "";
			content.addChild(txtTime);

			super.createStars();

			hideStarsExcept("preview_mc");
		}

		override public function update(date:Date):void {
			super.update(date);

			txtTime.txt.text = date.hours + ":" + date.minutes + ":" + date.seconds;
			//			trace(txtTime.txt.text);
		}
	}
}
