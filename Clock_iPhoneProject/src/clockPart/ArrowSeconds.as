package clockPart 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author LVG
	 */
	public class ArrowSeconds extends ClockMovingElement
	{
		private const glowFilter		:GlowFilter = new GlowFilter(0xFF0000, 1, 4, 4,1,2);
		
		public var mcArrow:MovieClip;
		
		public override function ArrowSeconds() 
		{
			mcArrow = new arrow_seconds();
			addChild(mcArrow);
			mcArrow.y -= 4;
			mcArrow.filters = [glowFilter];
		}
	}
}