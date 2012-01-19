package  
{
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class TransitionTypes 
	{
		public static var VEC_TRANSITION_TYPES:Vector.<String>;
		
		private static var vecBtn:Vector.<TransitionButton>;
		private static var cPanel:ControlPanel;
		
		private static var callBack:Function;
		private static var txtInput:TextInput;
		
		private static var panel:MovieClip;
		
		public static function setTransition(controlPanel:ControlPanel, text:TextInput, _callBack:Function):void
		{
			trace("call setTransition");
			
			cPanel = controlPanel;
			callBack = _callBack;
			txtInput = text;
			
			initTransType();
		}
		
		static private function initTransType():void 
		{
			VEC_TRANSITION_TYPES = new Vector.<String>()
			VEC_TRANSITION_TYPES.push("easeInSine");
			VEC_TRANSITION_TYPES.push("easeOutSine");
			VEC_TRANSITION_TYPES.push("easeInOutSine");
			VEC_TRANSITION_TYPES.push("easeOutInSine");
			VEC_TRANSITION_TYPES.push("easeInQuad");
			VEC_TRANSITION_TYPES.push("easeOutQuad");
			VEC_TRANSITION_TYPES.push("easeInOutQuad");
			VEC_TRANSITION_TYPES.push("easeOutInQuad");
			
			VEC_TRANSITION_TYPES.push("easeInCubic");
			VEC_TRANSITION_TYPES.push("easeOutCubic");
			VEC_TRANSITION_TYPES.push("easeInOutCubic");
			VEC_TRANSITION_TYPES.push("easeOutInCubic");
			VEC_TRANSITION_TYPES.push("easeInQuart");
			VEC_TRANSITION_TYPES.push("easeOutQuart");
			VEC_TRANSITION_TYPES.push("easeInOutQuart");
			VEC_TRANSITION_TYPES.push("easeOutInQuart");
			
			VEC_TRANSITION_TYPES.push("easeInQuint");
			VEC_TRANSITION_TYPES.push("easeOutQuint");
			VEC_TRANSITION_TYPES.push("easeInOutQuint");
			VEC_TRANSITION_TYPES.push("easeOutInQuint");
			VEC_TRANSITION_TYPES.push("easeInExpo");
			VEC_TRANSITION_TYPES.push("easeOutExpo");
			VEC_TRANSITION_TYPES.push("easeInOutExpo");
			VEC_TRANSITION_TYPES.push("easeOutInExpo");
			
			VEC_TRANSITION_TYPES.push("easeInCirc");
			VEC_TRANSITION_TYPES.push("easeOutCirc");
			VEC_TRANSITION_TYPES.push("easeInOutCirc");
			VEC_TRANSITION_TYPES.push("easeOutInCirc");
			VEC_TRANSITION_TYPES.push("easeInElastic");
			VEC_TRANSITION_TYPES.push("easeOutElastic");
			VEC_TRANSITION_TYPES.push("easeInOutElastic");
			VEC_TRANSITION_TYPES.push("easeOutInElastic");
			
			VEC_TRANSITION_TYPES.push("easeInBack");
			VEC_TRANSITION_TYPES.push("easeOutBack");
			VEC_TRANSITION_TYPES.push("easeInOutBack");
			VEC_TRANSITION_TYPES.push("easeOutInBack");
			VEC_TRANSITION_TYPES.push("easeInBounce");
			VEC_TRANSITION_TYPES.push("easeOutBounce");
			VEC_TRANSITION_TYPES.push("easeInOutBounce");
			VEC_TRANSITION_TYPES.push("easeOutInBounce");
			
			
			panel = new mcTransitionTypes();
			cPanel.addChild(panel);
			
			vecBtn = new Vector.<TransitionButton>();
			for (var i:int = 0; i < 40; i++ )
			{
				vecBtn.push(new TransitionButton(panel["hit_" + i],i)); 
				vecBtn[i].addEventListener(ClockEvent.CLICK,hitType);
			}
		}
		
		static private function hitType(e:ClockEvent):void 
		{
			txtInput.text = VEC_TRANSITION_TYPES[int(e.data)];
			
			destroy();
		}
		
		static private function destroy():void 
		{
			panel.parent.removeChild(panel);
			
			callBack();
		}
		
	}

}
import flash.events.Event;
import flash.events.EventDispatcher;

class TransitionButton extends EventDispatcher
{
	private var _num:int;
	function TransitionButton(mc:flash.display.MovieClip, num:int)
	{
		this._num = num;
		mc.addEventListener(flash.events.MouseEvent.CLICK, hitType);
		mc.useHandCursor = true;
		mc.buttonMode = true;
	}
	
	private function hitType(e:Event):void 
	{
		dispatchEvent(new ClockEvent(ClockEvent.CLICK, _num));
	}
}