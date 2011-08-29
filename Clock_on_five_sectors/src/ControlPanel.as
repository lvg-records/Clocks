package  
{
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
	public class ControlPanel extends Sprite
	{
		private var controlPanel	:Sprite;
		private var preferancePanel	:Sprite;
		private var helpPanel		:Sprite;
		
		private var btnPreferance	:RadioButton;
		private var btnHelp			:RadioButton;
		
		//preferance
		private var btnChangeColor	:Button;
		private var btnChangeBkColor:Button;
		private var btnChangeSize	:Button;
		private var btnChangeSpeed	:Button;
		private var btnChangeDivColor:Button;
		
		public static var txtElementColor	:TextInput;
		public static var txtBkColor		:TextInput;
		public static var txtSize			:TextInput;
		public static var txtSpeed			:TextInput;
		public static var txtDivColor		:TextInput;
		
		private var _content:Sprite;
		private var _clock:Clock;
		
		public function ControlPanel(content:Sprite,clock:Clock) 
		{
			_clock = clock;
			_content = content;
			if (stage) 
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event=null):void 
		{
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
			btnChangeColor.addEventListener(MouseEvent.CLICK, changeColor);
			txtElementColor = preferancePanel['txt_element_1'];
			
			btnChangeBkColor = preferancePanel['btn_element_2'];
			btnChangeBkColor.addEventListener(MouseEvent.CLICK, changeBkColor);
			txtBkColor = preferancePanel['txt_element_2'];
			
			btnChangeSize = preferancePanel['btn_element_3'];
			btnChangeSize.addEventListener(MouseEvent.CLICK, changeSize);
			txtSize = preferancePanel['txt_element_3'];
			
			btnChangeSpeed = preferancePanel['btn_element_4'];
			btnChangeSpeed.addEventListener(MouseEvent.CLICK, changeSpeed);
			txtSpeed = preferancePanel['txt_element_4'];
			
			btnChangeDivColor = preferancePanel['btn_element_5'];
			btnChangeDivColor.addEventListener(MouseEvent.CLICK,changeDivisionColor);
			txtDivColor = preferancePanel['txt_element_5'];
			
			changeBkColor();
			updateControlPanelView();
			changeSize();
			changeSpeed();
			changeColor();
			changeDivisionColor();
		}
		
		private function changeDivisionColor(e:MouseEvent=null):void 
		{
			for (var i:int = 0; i < Clock.arrClockElements.length; i++ )
			{
				if (Clock.arrClockElements[i] is Sprite)
				{
					var image:Sprite = (Clock.arrClockElements[i] as Sprite);
					image.filters = [new GlowFilter(uint('0x'+txtDivColor.text),1,2,2,5,5)]
				}
			}
			Clock.indicator.filters = [new GlowFilter(uint('0x' + txtDivColor.text), 1, 2, 2, 5, 5)];
		}
		
		private function updateControlPanelView(e:MouseEvent = null):void 
		{
			preferancePanel.visible = btnPreferance.selected;
			helpPanel.visible = btnHelp.selected;
		}
		
		private function changeSpeed(e:MouseEvent = null):void 
		{
			_clock.t.delay = 1000/Number(txtSpeed.text);
		}
		
		private function changeColor(e:MouseEvent = null):void 
		{
			for (var i:int = 0; i < Clock.arrClockElements.length; i++ )
			{
				if (Clock.arrClockElements[i] is Sprite)
				{
					var image:Sprite = (Clock.arrClockElements[i] as Sprite);
					image.graphics.clear();
					image.graphics.beginFill(uint('0x' + txtElementColor.text));
					image.graphics.drawRect(-Clock.DELTA, -Clock.DELTA, Clock.DELTA * 2, Clock.DELTA * 2);
					image.graphics.endFill();
					image.mask = Clock.arrClockElementsMask[i];
				}
			}
			Clock.indicator.graphics.clear();
			Clock.indicator.graphics.beginFill((Clock.isIndicatorActive)?uint('0x' + txtElementColor.text):uint('0x' + txtBkColor.text));
			Clock.indicator.graphics.drawCircle(0, 0, Clock.INDICATOR_RADIUS);
			Clock.indicator.graphics.endFill();
		}
		
		private function changeSize(e:MouseEvent = null):void
		{
			for (var i:int = 0; i < _content.numChildren; i++ )
				_content.getChildAt(i).scaleX = _content.getChildAt(i).scaleY = Number(txtSize.text);
		}
		
		private function changeBkColor(e:MouseEvent = null):void
		{
			_content.graphics.clear();
			_content.graphics.beginFill(uint('0x'+txtBkColor.text));
			_content.graphics.drawRect(-Clock.DELTA*2, -Clock.DELTA*2, Clock.DELTA * 4, Clock.DELTA * 4);
			_content.graphics.endFill();
		}
		
	}

}