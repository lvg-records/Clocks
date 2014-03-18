package {
	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.TextInput;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ControlPanel extends Sprite {

		private var controlPanel:Sprite;
		private var preferancePanel:Sprite;
		private var helpPanel:Sprite;

		private var btnPreferance:RadioButton;
		private var btnHelp:RadioButton;

		//preferance
		private var btnChangeColor:Button;
		private var btnChangeBkColor:Button;
		private var btnChangeSize:Button;
		private var btnChangeSpeed:Button;
		private var btnChangeDivColor:Button;

		private var btnZeroToOne:Button;
		private var btnOneToZero:Button;

		public static var txtElementColor:TextInput;
		public static var txtBkColor:TextInput;
		public static var txtSize:TextInput;
		public static var txtSpeed:TextInput;
		public static var txtDivColor:TextInput;

		private var txtZeroToOne:TextInput;
		private var txtOneToZero:TextInput;

		private var _content:Sprite;
		private var _clock:Clock;

		public function ControlPanel(content:Sprite, clock:Clock) {
			_clock = clock;
			_content = content;
			if(stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			controlPanel = new mcControlPanel();
			addChild(controlPanel);

			preferancePanel = controlPanel['preferance'];
			helpPanel = controlPanel['tutorial'];

			btnPreferance = controlPanel['btn_1'];
			btnPreferance.addEventListener(MouseEvent.CLICK, updateControlPanelView);

			btnHelp = controlPanel['btn_2'];
			btnHelp.addEventListener(MouseEvent.CLICK, updateControlPanelView);

			btnChangeColor = preferancePanel['btn_element_1'];
			//btnChangeColor.visible = false;
			btnChangeColor.addEventListener(MouseEvent.CLICK, changeColor);
			btnChangeColor.label = "Hours element color";
			txtElementColor = preferancePanel['txt_element_1'];
			//txtElementColor.visible = false;

			btnChangeBkColor = preferancePanel['btn_element_2'];
			btnChangeBkColor.addEventListener(MouseEvent.CLICK, changeBkColor);
			btnChangeBkColor.label = "Delay between hours and minutes";
			txtBkColor = preferancePanel['txt_element_2'];
			txtBkColor.text = String(15);

			btnChangeSize = preferancePanel['btn_element_3'];
			btnChangeSize.addEventListener(MouseEvent.CLICK, changeSize);
			txtSize = preferancePanel['txt_element_3'];

			btnChangeSpeed = preferancePanel['btn_element_4'];
			btnChangeSpeed.addEventListener(MouseEvent.CLICK, changeSpeed);
			btnChangeSpeed.visible = false;
			txtSpeed = preferancePanel['txt_element_4'];
			txtSpeed.visible = false;

			btnChangeDivColor = preferancePanel['btn_element_5'];
			//btnChangeDivColor.visible = false;
			btnChangeDivColor.label = "Minutes element color";
			btnChangeDivColor.addEventListener(MouseEvent.CLICK, changeDivisionColor);
			txtDivColor = preferancePanel['txt_element_5'];
			//txtDivColor.visible = false;

			//changeBkColor();
			updateControlPanelView();
			//changeSize();
			//changeSpeed();
			//changeColor();
			//changeDivisionColor();

			btnZeroToOne = preferancePanel['btn_element_10'];
			btnZeroToOne.addEventListener(MouseEvent.CLICK, changeTrnsionType_0_to_1);
			txtZeroToOne = preferancePanel['txt_element_10'];

			btnOneToZero = preferancePanel['btn_element_11'];
			btnOneToZero.addEventListener(MouseEvent.CLICK, changeTrnsionType_1_to_0);
			txtOneToZero = preferancePanel['txt_element_11'];
		}

		private function changeTrnsionType_1_to_0(e:MouseEvent):void {
			ClockPoint.TYPE_1_TO_0 = txtOneToZero.text;
		}

		private function changeTrnsionType_0_to_1(e:MouseEvent):void {
			ClockPoint.TYPE_0_TO_1 = txtZeroToOne.text;
		}

		private function changeDivisionColor(e:MouseEvent = null):void {
			ClockPoint.COLOR_HOURS = uint('0x' + txtDivColor.text);
			var color:uint = ClockPoint.COLOR_HOURS;
			for(var i:int = 0; i < Clock.arrPoints.length; i++) {
				Clock.arrPoints[i].point.graphics.clear();
				Clock.arrPoints[i].point.graphics.beginFill(color);
				Clock.arrPoints[i].point.graphics.drawCircle(-ClockPoint.POINT_RADIUS / 2, -ClockPoint.POINT_RADIUS / 2,
															 ClockPoint.POINT_RADIUS);
				Clock.arrPoints[i].point.graphics.endFill();
			}
		}

		private function changeSpeed(e:MouseEvent = null):void {

		}

		private function changeSize(e:MouseEvent = null):void {
			Clock.arrPoints[0].point.parent.scaleX = Clock.arrPoints[0].point.parent.scaleY = Number(txtSize.text);
		}

		private function changeBkColor(e:MouseEvent = null):void {
			Clock.SWITCH_MINUTES_HOURS = int(txtBkColor.text);
		}

		private function changeColor(e:MouseEvent = null):void {
			ClockPoint.COLOR_MINUTES = uint('0x' + txtElementColor.text);
			var color:uint = ClockPoint.COLOR_MINUTES;
			for(var i:int = 0; i < Clock.arrPoints.length; i++) {
				Clock.arrPoints[i].point.graphics.clear();
				Clock.arrPoints[i].point.graphics.beginFill(color);
				Clock.arrPoints[i].point.graphics.drawCircle(-ClockPoint.POINT_RADIUS / 2, -ClockPoint.POINT_RADIUS / 2,
															 ClockPoint.POINT_RADIUS);
				Clock.arrPoints[i].point.graphics.endFill();
			}
		}

		private function updateControlPanelView(e:MouseEvent = null):void {
			preferancePanel.visible = btnPreferance.selected;
			helpPanel.visible = btnHelp.selected;
		}
	}

}
