package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author LVG
	 */
	public class Grid extends Sprite
	{
		private const LEFT_BORDER			:int = -300;
		private const TOP_BORDER			:int = -300;
		private const COORDINATE_SIZE		:int = 4;
		
		
		public function Grid() 
		{
			for (var i:int = 0; i < 600;i+=5 )
			{
				var lineVertic:Sprite = new Sprite();
				addChild(lineVertic);
				lineVertic.graphics.beginFill(0x663300);
				lineVertic.graphics.drawRect(0,0,1,600);
				lineVertic.graphics.endFill();
				
				lineVertic.x = i + LEFT_BORDER;
				lineVertic.y = TOP_BORDER;
				
				var lineHoriz:Sprite = new Sprite();
				addChild(lineHoriz);
				lineHoriz.graphics.beginFill(0x663300);
				lineHoriz.graphics.drawRect(0,0,600,1);
				lineHoriz.graphics.endFill();
				
				lineHoriz.x = LEFT_BORDER;
				lineHoriz.y =i+ TOP_BORDER;
			}
			
			var lineX:Sprite = new Sprite();
			addChild(lineX);
			lineX.graphics.beginFill(0x003300);
			lineX.graphics.drawRect(-COORDINATE_SIZE/2,0,COORDINATE_SIZE,600);
			lineX.graphics.endFill();
			lineX.y = TOP_BORDER;
			
			var lineY:Sprite = new Sprite();
			addChild(lineY);
			lineY.graphics.beginFill(0x003300);
			lineY.graphics.drawRect(0,-COORDINATE_SIZE/2,600,COORDINATE_SIZE);
			lineY.graphics.endFill();
			lineY.x = LEFT_BORDER;
		}
		
	}

}