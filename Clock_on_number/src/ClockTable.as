package {
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockTable {
		public static var TYPE_1_TO_0:String
		public static var TYPE_0_TO_1:String
		
		public static const MODE_DEC_HOURS:int = 0;
		public static const MODE_ONE_HOURS:int = 1;
		public static const MODE_DEC_MINUTES:int = 3;
		public static const MODE_ONE_MINUTES:int = 4;
		
		//public static const COLOR_TXT_ACTIVE_ELEMENT 	:uint = 0xffffff;
		//public static const COLOR_TXT_PACTIVE_ELEMENT 	:uint = 0x000000;
		
		public static var arrWithEl:Array;
		
		public static function lightClock(nuber_txt:mc_number, mode:int):void {
			var date:Date = new Date();
			switch (mode){
				case MODE_DEC_HOURS: 
					lightNumber(nuber_txt, date.hours / 10);
					break;
				case MODE_ONE_HOURS: 
					lightNumber(nuber_txt, date.hours % 10);
					break;
				case MODE_DEC_MINUTES: 
					lightNumber(nuber_txt, date.minutes / 10);
					break;
				case MODE_ONE_MINUTES: 
					lightNumber(nuber_txt, date.minutes % 10);
					break;
				default: 
					lightNumber(nuber_txt);
					break;
			}
		}
		
		private static function lightNumber(nuber_txt:mc_number, number:int = -1, time:Number = 450):void {
			var timeStr:String = number == -1 ? "" : number.toString();
			
			nuber_txt.txt.text = timeStr;
			//nuber_txt.txt.textColor = ;
			nuber_txt.alpha = 0;
			Tweener.addTween(nuber_txt, {alpha: 1, time: Clock.t.delay / 2010, onComplete: backTween, transition: ClockTable.TYPE_1_TO_0});
			
			function backTween():void {
				Tweener.addTween(nuber_txt, {alpha: 0, time: Clock.t.delay / 2010, transition: ClockTable.TYPE_1_TO_0});
			}
		}
	}
}