package {
	import caurina.transitions.Tweener;
	import fl.text.TLFTextField;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockTable {
		//static 
		private var clock:Clock;
		public static var TYPE_1_TO_0:String
		public static var TYPE_0_TO_1:String
		
		public static const PREVIEW_SPEED:int = 4;
		
		public static const MODE_HOURS:int = 0;
		public static const MODE_DEC_MINUTES:int = 1;
		public static const MODE_ONE_MINUTES:int = 2;
		
		public static const COLOR_TXT_ACTIVE_ELEMENT:uint = 0xffffff;
		public static const COLOR_TXT_PACTIVE_ELEMENT:uint = 0x000000;
		
		public static var arrWithEl:Array;
		
		private var previewData:Array = [0,0,0];
		
		public function ClockTable(clock:Clock){
			this.clock = clock;
		}
		
		public function lightClock(arr:Vector.<mc_romb>, mode:int, updateTxtField:Function, clock_mode:int = 0):void {
			//ClockTable.clock = clock;
			if (clock_mode == 0){
				var date:Date = new Date();
				previewData[0] = date.hours;
				previewData[1] = date.minutes;
				previewData[2] = date.seconds;
			}
			else {
				previewData[2] += PREVIEW_SPEED;
				if (previewData[2] >= 60){
					previewData[1]++;
					previewData[2] = 0;
				}
				if (previewData[1] >= 60){
					previewData[0]++;
					previewData[1] = 0;
				}
				if (previewData[0] >= 24){
					previewData[0] = 0
				}
			}
			updateTxtField(previewData[0], previewData[1], previewData[2]);
			switch (mode){
				case MODE_HOURS: 
					calculateHours(arr, previewData[0]);
					break;
				case MODE_DEC_MINUTES: 
					calculateDecMinutes(arr, previewData[1] / 10);
					break;
				case MODE_ONE_MINUTES: 
					calculateOneMinutes(arr, previewData[1] % 10);
					break;
				default: 
					showDefineSector(arr);
					break;
			}
		}
		
		private function calculateOneMinutes(arr:Vector.<mc_romb>, oneMin:int):void {
			switch (oneMin){
				case 0: 
					showDefineSector(arr, 0, 4);
					break;
				case 1: 
					showDefineSector(arr, 0);
					break;
				case 2: 
					showDefineSector(arr, 0, 1);
					break;
				case 3: 
					showDefineSector(arr, 1);
					break;
				case 4: 
					showDefineSector(arr, 1, 2);
					break;
				case 5: 
					showDefineSector(arr, 2);
					break;
				case 6: 
					showDefineSector(arr, 2, 3);
					break;
				case 7: 
					showDefineSector(arr, 3);
					break;
				case 8: 
					showDefineSector(arr, 3, 4);
					break;
				case 9: 
					showDefineSector(arr, 4);
					break;
			}
		}
		
		private function calculateDecMinutes(arr:Vector.<mc_romb>, decMin:int):void {
			switch (decMin){
				case 0: 
					showDefineSector(arr, 0, 4);
					break;
				case 1: 
					showDefineSector(arr, 0);
					break;
				case 2: 
					showDefineSector(arr, 0, 1);
					break;
				case 3: 
					showDefineSector(arr, 1);
					break;
				case 4: 
					showDefineSector(arr, 1, 2);
					break;
				case 5: 
					showDefineSector(arr, 2);
					break;
				case 6: 
					showDefineSector(arr, 2, 3);
					break;
			}
		}
		
		private function calculateHours(arr:Vector.<mc_romb>, hours:int):void {
			switch (hours){
				case 0: 
				case 12: 
				case 10: 
				case 22: 
				case 24: 
					showDefineSector(arr, 0, 4);
					break;
				case 1: 
				case 11: 
				case 13: 
				case 23: 
					showDefineSector(arr, 0);
					break;
				case 2: 
				case 12: 
				case 14: 
					showDefineSector(arr, 0, 1);
					break;
				case 3: 
				case 12: 
				case 15: 
					showDefineSector(arr, 1);
					break;
				case 4: 
				case 16: 
					showDefineSector(arr, 1, 2);
					break;
				case 5: 
				case 17: 
					showDefineSector(arr, 2);
					break;
				case 6: 
				case 18: 
					showDefineSector(arr, 2, 3);
					break;
				case 7: 
				case 19: 
					showDefineSector(arr, 3);
					break;
				case 8: 
				case 20: 
					showDefineSector(arr, 3, 4);
					break;
				case 9: 
				case 21: 
					showDefineSector(arr, 4);
					break;
			}
		}
		
		private function showDefineSector(arr:Vector.<mc_romb>, element_1:int = -1, element_2:int = -1):void {
			arrWithEl = new Array();
			for (var i:int = 0; i < arr.length; i++){
				if (i == element_1 || i == element_2){
					arrWithEl.push(i);
					
					arr[i].visible = true;
					arr[i].alpha = 0;
					Tweener.addTween(arr[i], {alpha: 1, time: clock.t.delay / 2010, onComplete: backTween, transition: ClockTable.TYPE_1_TO_0});
					(clock.tips['t_' + i] as TLFTextField).textColor = COLOR_TXT_ACTIVE_ELEMENT;
				} else {
					arr[i].visible = false;
					(clock.tips['t_' + i] as TLFTextField).textColor = COLOR_TXT_PACTIVE_ELEMENT;
				}
			}
			(clock.tips['t_' + i] as TLFTextField).visible = false;
			
			function backTween():void {
				for (var g:int = 0; g < arrWithEl.length; g++){
					Tweener.addTween(arr[arrWithEl[g]], {alpha: 0, time: clock.t.delay / 2010, transition: ClockTable.TYPE_1_TO_0});
				}
			}
		}
	}
}