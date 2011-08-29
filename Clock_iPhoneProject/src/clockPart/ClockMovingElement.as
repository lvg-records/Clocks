package clockPart 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockMovingElement extends Sprite
	{
		public var arrow				:Sprite;
		public var arrowColor			:uint;
		
		public function updatePosition(time:int):void
		{
			rotation = time * 6;
		}
		
		public function setFilter():void
		{
			
		}
	}

}
