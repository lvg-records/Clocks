package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class PlayText extends Sprite 
	{
		private var clock				:Clock;
		private var controlPanel		:ControlPanel;
		
		
		public function PlayText():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var _mask:Sprite = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0,0,600,600);
			_mask.graphics.endFill();
			addChild(_mask)
			
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			sprite.mask = _mask;
			
			sprite.x = Clock.DELTA;
			sprite.y = Clock.DELTA + 80;
			clock = new Clock(sprite);
			
			controlPanel = new ControlPanel(sprite,clock);
			addChild(controlPanel);
		}
		
	}
}