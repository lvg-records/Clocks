package {
	import caurina.transitions.Tweener;
	import fl.text.TLFTextField;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockTable {
		public static var TYPE_1_TO_0:String
		public static var TYPE_0_TO_1:String
		
		public static const MODE_HOURS:int = 0;
		public static const MODE_DEC_MINUTES:int = 1;
		public static const MODE_ONE_MINUTES:int = 2;
		
		public static const COLOR_TXT_ACTIVE_ELEMENT:uint = 0xffffff;
		public static const COLOR_TXT_PACTIVE_ELEMENT:uint = 0x000000;
		
		public static var arrWithEl:Array;
		
		public static function lightClock(arr:Vector.<mcClockElement>, mode:int):void {
			var date:Date = new Date();
			switch (mode){
				case MODE_HOURS: 
					calculateHours(arr, date.hours);
					break;
				case MODE_DEC_MINUTES: 
					calculateDecMinutes(arr, date.minutes / 10);
					break;
				case MODE_ONE_MINUTES: 
					calculateOneMinutes(arr, date.minutes % 10);
					break;
				default: 
					showDefineSector(arr);
					break;
			}
		}
		
		static private function calculateOneMinutes(arr:Vector.<mcClockElement>, oneMin:int):void {
			showDefineSector(arr, oneMin);
		}
		
		static private function calculateDecMinutes(arr:Vector.<mcClockElement>, decMin:int):void {
			showDefineSector(arr, decMin);
		}
		
		static private function calculateHours(arr:Vector.<mcClockElement>, hours:int):void {
			
			switch (hours){
				case 0: 
				case 12: 
				case 10: 
				case 22: 
				case 24: 
					showDefineSector(arr, 0);
					break;
				case 1: 
				case 11: 
				case 13: 
				case 23: 
					showDefineSector(arr, 1);
					break;
				case 2: 
				case 14: 
					showDefineSector(arr, 2);
					break;
				case 3: 
				case 15: 
					showDefineSector(arr, 3);
					break;
				case 4: 
				case 16: 
					showDefineSector(arr, 4);
					break;
				case 5: 
				case 17: 
					showDefineSector(arr, 5);
					break;
				case 6: 
				case 18: 
					showDefineSector(arr, 6);
					break;
				case 7: 
				case 19: 
					showDefineSector(arr, 7);
					break;
				case 8: 
				case 20: 
					showDefineSector(arr, 8);
					break;
				case 9: 
				case 21: 
					showDefineSector(arr, 9);
					break;
			}
		}
		
		static private function showDefineSector(arr:Vector.<mcClockElement>, element_1:int = -1):void {
			//trace(element_1);
			var _cadr:int = element_1;
			if (_cadr == -1)
				_cadr = 11;
			Clock.finger.gotoAndStop(_cadr);
			
			var moveEl:Vector.<mcClockElement> = new Vector.<mcClockElement>();
			switch (element_1){
				case 0: 
					moveEl.push(Clock.arrClockElementsMask[0]);
					moveEl.push(Clock.arrClockElementsMask[4]);
					break;
				case 1: 
					moveEl.push(Clock.arrClockElementsMask[0]);
					break;
				case 2: 
					moveEl.push(Clock.arrClockElementsMask[0]);
					moveEl.push(Clock.arrClockElementsMask[1]);
					break;
				case 3: 
					moveEl.push(Clock.arrClockElementsMask[1]);
					break;
				case 4: 
					moveEl.push(Clock.arrClockElementsMask[1]);
					moveEl.push(Clock.arrClockElementsMask[2]);
					break;
				case 5: 
					moveEl.push(Clock.arrClockElementsMask[2]);
					break;
				case 6: 
					moveEl.push(Clock.arrClockElementsMask[2]);
					moveEl.push(Clock.arrClockElementsMask[3]);
					break;
				case 7: 
					moveEl.push(Clock.arrClockElementsMask[3]);
					break;
				case 8: 
					moveEl.push(Clock.arrClockElementsMask[3]);
					moveEl.push(Clock.arrClockElementsMask[4]);
					break;
				case 9: 
					moveEl.push(Clock.arrClockElementsMask[4]);
					break;
			}
			for (var i:int = 0; i < Clock.arrClockElementsMask.length; i++){
				Clock.arrClockElementsMask[i].bbb.visible = true;
				Clock.arrClockElementsMask[i].bbb.gotoAndStop(1);
				Clock.arrClockElementsMask[i].bbb2.visible = false;
				
				Clock.arrClockElementsMask[i].bbb.x = Clock.arrClockElementsPositions[i].x;
				Clock.arrClockElementsMask[i].bbb.y = Clock.arrClockElementsPositions[i].y;
				
				Clock.arrClockElementsMask[i].bbb2.x = Clock.arrClockElementsPositions2[i].x;
				Clock.arrClockElementsMask[i].bbb2.y = Clock.arrClockElementsPositions2[i].y;
			}
			var ddelay:Number = Clock.t.delay * 0.0005;
			var changePositionDelta:Number = 4;
			for (var j:int = 0; j < moveEl.length; j++){
				Tweener.addTween(moveEl[j].bbb, {time: ddelay, y: moveEl[j].bbb.y + changePositionDelta, onUpdate: complete});
				Tweener.addTween(moveEl[j].bbb2, {time: ddelay, y: moveEl[j].bbb2.y + changePositionDelta, onUpdate: complete});
			}
			var callNum:int = 0;
			function complete():void {
				if (callNum > ddelay*50)
					for (var f:int = 0; f < moveEl.length; f++){
						moveEl[f].bbb2.visible = true;
						moveEl[f].bbb.visible = false;
					}
				callNum++;
			}
		}
	}
}