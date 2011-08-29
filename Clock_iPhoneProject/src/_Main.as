package 
{
		import flash.display.Sprite;  
		import flash.display.StageAlign;
		import flash.display.StageScaleMode;
		import flash.text.TextField;  
		import flash.text.TextFormat;  
	
	/**
	 * ...
	 * @author LVG
	 */
	public class _Main extends Sprite 
	{
		
		public function _Main():void 
		{
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var tf:TextField = new TextField();  
			var format:TextFormat = new TextFormat();  
			format.font = "_sans";  
			format.size = 48;  
			tf.defaultTextFormat = format;  
			tf.text = "Hello World";  
			tf.width = stage.stageWidth - 20;  
			tf.x = 10;  
			tf.y = 10;  
			addChild(tf);  
			addChild(new RulesGfx());
		}
		
	}
	
}