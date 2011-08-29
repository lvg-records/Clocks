package clockPart 
{
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author LVG
	 */
	public class ArrowHours extends ClockMovingElement
	{
		private const glowFilter:GlowFilter = new GlowFilter(0x222222, 1, 2, 2, 5,5);
		private const bewelFilter:BevelFilter = new BevelFilter(0);
		
		private var arrArrows_body		:Vector.<Sprite>;
		
		public override function ArrowHours() 
		{
			arrArrows_body = new Vector.<Sprite>();
			
			arrArrows_body[0] = new arrow_hours_vertical();
			addChild(arrArrows_body[0]);
			
			arrArrows_body[1] = new arrow_hours_arc();
			addChild(arrArrows_body[1]);
			
			arrArrows_body[2] = new arrow_hours_arc_m();
			addChild(arrArrows_body[2]);
			
			setFilter();
		}
		
		public override function setFilter():void
		{
			for (var i:int = 0; i < arrArrows_body.length; i++ )
			{
				arrArrows_body[i].filters = [glowFilter];
			}
		}
		
		public override function updatePosition(time:int):void
		{
			
			arrArrows_body[0].visible = false;
			arrArrows_body[1].visible = false;
			arrArrows_body[2].visible = false;
			
			var angle:int = int(time / 3) * 3 * 30;
			rotation = angle;
			
			var position:int = time % 12;
			switch (position)
			{
				case 0:
				case 3:
				case 6:
				case 9:
					arrArrows_body[0].visible = true;
					break;
				case 1:
				case 4:
				case 7:
				case 10:
					arrArrows_body[1].visible = true;
					break;
				case 2:
				case 5:
				case 8:
				case 11:
					arrArrows_body[2].visible = true;
					break;
			}
		}
	}

}
