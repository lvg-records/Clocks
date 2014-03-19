package view.components {
	import flash.display.Sprite;


	public class TextView extends StarsView {

		private var txtTime:TXT_time;

		public function TextView(content:Sprite) {
			super(content);
		}

		override protected function createStars():void {
			super.createStars();

            txtTime = new TXT_time();
            txtTime.txt.text = "";
            content.addChild(txtTime);

            for each(var star:mc_star in stars) {
                star.alpha = 0.5;
            }
		}

		override public function update(date:Date):void {
			super.update(date);

			txtTime.txt.text = date.hours + ":" + date.minutes + ":" + date.seconds;
			trace(txtTime.txt.text);
		}
	}
}
