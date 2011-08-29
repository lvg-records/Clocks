package  
{
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author LVG
	 */
	public class Cheats extends EventDispatcher
	{
		private static const MAX_ZOOM_IN		:int = 2;
		private static const MAX_ZOOM_OUT		:int = 1;
		private static const ZOOM_STEP			:Number = .2;
		
		//key code
		private static const KEY_PLUS_ON_NUM	:int = 107;
		private static const KEY_MINUS_ON_NUM	:int = 109;
		
		private static var   clock				:Clock;
		
		public static function initializeCheats(inputClock:Clock):void
		{
			clock = inputClock;
			clock.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		static private function onKeyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case KEY_PLUS_ON_NUM:
					zoomIn();
				break;
				case KEY_MINUS_ON_NUM:
					zoomOut();
				break;
			}
		}
		
		private static function zoomIn():void
		{
			if (clock.scaleX<=MAX_ZOOM_IN)
				clock.scaleX = clock.scaleY += ZOOM_STEP;
		}
		
		private static function zoomOut():void
		{
			if (clock.scaleX>=MAX_ZOOM_OUT)
				clock.scaleX = clock.scaleY -= ZOOM_STEP;
		}
	}

}