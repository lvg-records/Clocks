package {
	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.TextInput;
	import fl.events.ComponentEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ConvolutionFilter;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ControlPanel extends Sprite {
		public var controlPanel:Sprite;
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
		
		private var btn_hit_0:MovieClip;
		private var btn_hit_1:MovieClip;
		
		public static var txtElementColor:TextInput;
		public static var txtBkColor:TextInput;
		public static var txtSize:TextInput;
		public static var txtSpeed:TextInput;
		public static var txtDivColor:TextInput;
		
		private var txtZeroToOne:TextInput;
		private var txtOneToZero:TextInput;
		
		private var _content:Sprite;
		private var _clock:Clock;
		
		public function ControlPanel(content:Sprite, clock:Clock){
			_clock = clock;
			_content = content;
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			controlPanel = new mcControlPanel();
			addChild(controlPanel);
			
			preferancePanel = controlPanel['preferance'];
			helpPanel = controlPanel['tutorial'];
			
			btnPreferance = controlPanel['btn_1'];
			btnPreferance.addEventListener(MouseEvent.CLICK, updateControlPanelView);
			btnPreferance.visible = false;
			
			btnHelp = controlPanel['btn_2'];
			btnHelp.addEventListener(MouseEvent.CLICK, updateControlPanelView);
			btnHelp.visible = false;
			
			btnChangeColor = preferancePanel['btn_element_1'];
			btnChangeColor.addEventListener(MouseEvent.CLICK, changeColor);
			txtElementColor = preferancePanel['txt_element_1'];
			
			btnChangeBkColor = preferancePanel['btn_element_2'];
			btnChangeBkColor.addEventListener(MouseEvent.CLICK, changeBkColor);
			txtBkColor = preferancePanel['txt_element_2'];
			
			btnChangeSize = preferancePanel['btn_element_3'];
			btnChangeSize.addEventListener(MouseEvent.CLICK, changeSize);
			txtSize = preferancePanel['txt_element_3'];
			txtSize.text = String(0.8);
			
			btnChangeSpeed = preferancePanel['btn_element_4'];
			btnChangeSpeed.addEventListener(MouseEvent.CLICK, changeSpeed);
			txtSpeed = preferancePanel['txt_element_4'];
			
			btnChangeDivColor = preferancePanel['btn_element_5'];
			btnChangeDivColor.addEventListener(MouseEvent.CLICK, changeDivisionColor);
			btnChangeDivColor.visible = false;
			txtDivColor = preferancePanel['txt_element_5'];
			txtDivColor.visible = false;
			
			btnZeroToOne = preferancePanel['btn_element_10'];
			btnZeroToOne.addEventListener(MouseEvent.CLICK, changeTrnsionType_0_to_1);
			txtZeroToOne = preferancePanel['txt_element_10'];
			
			btnOneToZero = preferancePanel['btn_element_11'];
			btnOneToZero.addEventListener(MouseEvent.CLICK, changeTrnsionType_1_to_0);
			txtOneToZero = preferancePanel['txt_element_11'];
			
			btn_hit_0 = preferancePanel['hit_0'];
			btn_hit_0.useHandCursor = true;
			btn_hit_0.buttonMode = true;
			btn_hit_0.addEventListener(MouseEvent.CLICK, set_0_1_Type);
			
			btn_hit_1 = preferancePanel['hit_1'];
			btn_hit_1.useHandCursor = true;
			btn_hit_1.buttonMode = true;
			btn_hit_1.addEventListener(MouseEvent.CLICK, set_1_0_Type);
			
			changeBkColor();
			updateControlPanelView();
			changeSize();
			changeSpeed();
			changeColor();
			changeDivisionColor();
			
			changeTrnsionType_1_to_0();
			changeTrnsionType_1_to_0();
		}
		
		private function set_1_0_Type(e:MouseEvent):void {
			TransitionTypes.setTransition(this, txtOneToZero, changeTrnsionType_1_to_0);
		}
		
		private function set_0_1_Type(e:MouseEvent):void {
			TransitionTypes.setTransition(this, txtZeroToOne, changeTrnsionType_0_to_1);
		}
		
		private function changeTrnsionType_1_to_0(e:MouseEvent = null):void {
			ClockTable.TYPE_1_TO_0 = txtOneToZero.text;
		}
		
		private function changeTrnsionType_0_to_1(e:MouseEvent = null):void {
			ClockTable.TYPE_0_TO_1 = txtZeroToOne.text;
		}
		
		private function changeDivisionColor(e:MouseEvent = null):void {
			for (var i:int = 0; i < _clock.arrClockElements.length; i++){
				if (_clock.arrClockElements[i] is Sprite){
					var image:Sprite = (_clock.arrClockElements[i] as Sprite);
				}
			}
		}
		
		private function updateControlPanelView(e:MouseEvent = null):void {
			preferancePanel.visible = btnPreferance.selected;
			helpPanel.visible = btnHelp.selected;
		}
		
		private function changeSpeed(e:MouseEvent = null):void {
			_clock.t.delay = 1000 / Number(txtSpeed.text);
		}
		
		private function changeColor(e:MouseEvent = null):void {
			for (var i:int = 0; i < _clock.arrClockElements.length; i++){
				if (_clock.arrClockElements[i] is Sprite){
					var image:Sprite = (_clock.arrClockElements[i] as Sprite);
					image.graphics.clear();
					image.graphics.beginFill(uint('0x' + txtElementColor.text));
					image.graphics.drawRect(-Clock.DELTA, -Clock.DELTA, Clock.DELTA * 2, Clock.DELTA * 2);
					image.graphics.endFill();
					image.mask = _clock.arrClockElementsMask[i];
				}
			}
		}
		
		private function changeSize(e:MouseEvent = null):void {
			for (var i:int = 0; i < _content.numChildren; i++)
				_content.getChildAt(i).scaleX = _content.getChildAt(i).scaleY = Number(txtSize.text);
		}
		
		private function changeBkColor(e:MouseEvent = null):void {
			_content.graphics.clear();
			_content.graphics.beginFill(uint('0x' + txtBkColor.text));
			_content.graphics.drawRect(-Clock.DELTA * 2, -Clock.DELTA * 2, Clock.DELTA * 4, Clock.DELTA * 4);
			_content.graphics.endFill();
		}
	
	}

}