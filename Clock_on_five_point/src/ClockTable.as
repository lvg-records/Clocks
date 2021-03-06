package  
{
	import caurina.transitions.Tweener;
	import fl.text.TLFTextField;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockTable 
	{
		public static var TYPE_1_TO_0:String
		public static var TYPE_0_TO_1:String
		
		
		public static const MODE_HOURS			:int = 0;
		public static const MODE_DEC_MINUTES	:int = 1;
		public static const MODE_ONE_MINUTES	:int = 2;
		
		public static const COLOR_TXT_ACTIVE_ELEMENT 	:uint = 0xffffff;
		public static const COLOR_TXT_PACTIVE_ELEMENT 	:uint = 0x000000;
		
		public static var arrWithEl				:Array;
		
		public static function lightClock(arr:Vector.<DisplayObject>,mode:int):void
		{
			var date:Date = new Date();
			switch (mode)
			{
				case MODE_HOURS:
					calculateHours(arr,date.hours);
				break;
				case MODE_DEC_MINUTES:
					calculateDecMinutes(arr,date.minutes/10);
				break;
				case MODE_ONE_MINUTES:
					calculateOneMinutes(arr,date.minutes%10);
				break;
				default:
					showDefineSector(arr);
				break;
			}
			if (ControlPanel.txtElementColor)
			{
				if (Clock.isIndicatorActive && mode < 3)
				{
					Clock.indicator.graphics.clear();
					Clock.indicator.graphics.beginFill(uint('0x' +ControlPanel.txtElementColor.text));
					Clock.indicator.graphics.drawCircle(0, 0, Clock.INDICATOR_RADIUS);
					Clock.indicator.graphics.endFill();
					Clock.indicator.alpha = 0;
					Clock.indicator.visible = true;
					Tweener.addTween(Clock.indicator, { alpha:1, time:Clock.t.delay / 2010 ,onComplete:backTween, transition:ClockTable.TYPE_0_TO_1 } );
				}
				else
					Clock.indicator.visible = false;
			}
			
			function backTween():void
			{
				Tweener.addTween(Clock.indicator, { alpha:0, time:Clock.t.delay / 2010, transition:ClockTable.TYPE_1_TO_0 } );
			}
		}
		
		static private function calculateOneMinutes(arr:Vector.<DisplayObject>, oneMin:int):void 
		{
			//Clock.isIndicatorActive = true;
			switch (oneMin)
			{
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
		
		static private function calculateDecMinutes(arr:Vector.<DisplayObject>, decMin:int):void 
		{
			Clock.isIndicatorActive = false;
			switch (decMin)
			{
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
		
		static private function calculateHours(arr:Vector.<DisplayObject>, hours:int):void 
		{
			if (hours == 10 || hours == 11 || hours == 12 || hours == 22 || hours == 23 || hours == 24)
				Clock.isIndicatorActive = true;
			else
				Clock.isIndicatorActive = false;
			switch (hours)
			{
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
		
		static private function showDefineSector(arr:Vector.<DisplayObject>,element_1:int = -1, element_2:int = -1):void
		{
			arrWithEl = new Array();
			for (var i:int = 0; i < arr.length; i++ )
			{
				if (i == element_1 || i == element_2)
				{
					arrWithEl.push(i);
					
					arr[i].visible = true;
					arr[i].alpha = 0;
					Tweener.addTween(arr[i], { alpha:1, time:Clock.t.delay / 2010 , onComplete:backTween, transition:ClockTable.TYPE_1_TO_0 } );
					(Clock.tips['t_' + i] as TLFTextField).textColor = COLOR_TXT_ACTIVE_ELEMENT;
				}
				else
				{
					arr[i].visible = false;
					(Clock.tips['t_' + i] as TLFTextField).textColor = COLOR_TXT_PACTIVE_ELEMENT;
				}
			}
			if (Clock.isIndicatorActive)
				(Clock.tips['t_' + i] as TLFTextField).textColor = COLOR_TXT_ACTIVE_ELEMENT;
			else 
				(Clock.tips['t_' + i] as TLFTextField).textColor = COLOR_TXT_PACTIVE_ELEMENT;
				
			function backTween():void
			{
				for (var g:int = 0; g < arrWithEl.length; g++ )
				{
					Tweener.addTween(arr[arrWithEl[g]], { alpha:0, time:Clock.t.delay / 2010, transition:ClockTable.TYPE_1_TO_0 } );
				}
			}
		}
	}
}