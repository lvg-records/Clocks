package view {
	import flash.display.Sprite;

	import view.components.HoursView;
	import view.components.MinutesView;
	import view.components.SecondsView;
	import view.components.TextView;


	public class ClockView {

		private var content:Sprite;

		private var textView:TextView;
		private var hoursView:HoursView;
		private var minutesView:MinutesView;
		private var secondsView:SecondsView;

		public function ClockView() {
		}

		public function init(content:Sprite):void {

			createContent(content);
			createComponentsView();
		}

		private function createContent(content:Sprite):void {

			this.content = new Sprite();
			this.content.x = 300;
			this.content.y = 300;
			content.addChild(this.content);
		}

		private function createComponentsView():void {

			textView = new TextView(content);
			hoursView = new HoursView(content);
			minutesView = new MinutesView(content);
			secondsView = new SecondsView(content);
		}

		public function update(date:Date):void {

			textView.update(date);
			hoursView.update(date);
			minutesView.update(date);
			secondsView.update(date);
		}
	}
}
