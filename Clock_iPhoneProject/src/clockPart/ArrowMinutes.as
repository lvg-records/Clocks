package clockPart 
{
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author LVG
	 */
	public class ArrowMinutes extends ClockMovingElement
	{
		private const glowFilter:GlowFilter = new GlowFilter(0x400000, 1, 2, 2, 10,2);
		private const bevelFilter		:BevelFilter = new BevelFilter(0,45,0x000000);
		
		private var arrArrows			:Vector.<Sprite>;
		private var arrArrows_body		:Vector.<Sprite>;
		
		private var simpleSprite		:Sprite;
		
		public override function ArrowMinutes() 
		{
			arrArrows = new Vector.<Sprite>();
			arrArrows_body = new Vector.<Sprite>();
			
			simpleSprite = new Sprite();
			addChild(simpleSprite);
			
			arrArrows[0] = new arrow_minutes_two();
			simpleSprite.addChild(arrArrows[0]);
			
			arrArrows[1] = new arrow_minutes_two_m();
			simpleSprite.addChild(arrArrows[1]);
			
			arrArrows[2] = new arrow_minutes_one_m();
			simpleSprite.addChild(arrArrows[2]);
			
			arrArrows[3] = new arrow_minutes_one();
			simpleSprite.addChild(arrArrows[3]);
			
			arrArrows_body[0] = new arrow_minutes_vertical();
			addChild(arrArrows_body[0]);
			
			arrArrows_body[1] = new arrow_minutes_arc();
			addChild(arrArrows_body[1]);
			
			arrArrows_body[2] = new arrow_minutes_arc_m();
			addChild(arrArrows_body[2]);
		}
		
		public override function setFilter():void
		{
			for (var i:int = 0; i < arrArrows_body.length; i++ )
			{
				arrArrows_body[i].filters = [glowFilter, bevelFilter];
			}
			
			for (var j:int = 0; j < arrArrows.length; j++ )
			{
				arrArrows[j].filters = [glowFilter, bevelFilter];
			}
		}
		
		public override function updatePosition(time:int):void
		{
			var position_0:int = int((time + 2) / 5);
			switch (position_0)
			{
				case 0:
				case 3:
				case 6:
				case 9:
				case 12:
					simpleSprite.rotation = 0;
				break;
				case 1:
				case 4:
				case 7:
				case 10:
					simpleSprite.rotation = 30;
				break;
				case 2:
				case 5:
				case 8:
				case 11:
					simpleSprite.rotation = 60;
				break;
			}
			
			arrArrows[0].visible = false;
			arrArrows[1].visible = false;
			arrArrows[2].visible = false;
			arrArrows[3].visible = false;
			
			arrArrows_body[0].visible = false;
			arrArrows_body[1].visible = false;
			arrArrows_body[2].visible = false;
			
			var angle:int = int((time+2) / 15) * 15 * 30;
			rotation = angle;
			
			//big arrow
			var position_1:int = time % 15;
			switch (position_1)
			{
				case 0:
				case 1:
				case 2:
				case 13:
				case 14:
					arrArrows_body[0].visible = true;
				break;
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
					arrArrows_body[1].visible = true;
				break;
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:
					arrArrows_body[2].visible = true;
				break;
			}
			
			//big arrow
			var position_2:int = time % 5;
			switch (position_2)
			{
				case 1:
				case 6:
					arrArrows[2].visible = true;
				break;
				case 2:
				case 7:
					arrArrows[3].visible = true;
				break;
				case 3:
				case 8:
					arrArrows[0].visible = true;
				break;
				case 4:
				case 9:
					arrArrows[1].visible = true;
				break;
			}
		}
	}
}