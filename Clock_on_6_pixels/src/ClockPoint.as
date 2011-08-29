package  
{
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockPoint 
	{
		public static var COLOR_HOURS:uint = 0x000000;
		public static var COLOR_MINUTES:uint = 0x890000;
		
		public static var TYPE_0_TO_1:String;
		public static var TYPE_1_TO_0:String;
		
		public static const POINT_RADIUS	:int = 50;
		public static const POINT_DELTA_X	:int = 90;
		public static const POINT_DELTA_Y	:int = 80;
		public static var lastUsedPoint		:int=-7;
		public static var _speed			:Number;
		public static var isUp				:Boolean = false;
		
		public var point:Sprite;
		private var numToSplash:int = 0;
		
		public function ClockPoint(container:Sprite,_x:Number,_y:Number) 
		{
			point = new Sprite();
			container.addChild(point);
			point.x = _x*POINT_RADIUS*2.1 + POINT_DELTA_X;
			point.y = _y*POINT_RADIUS*2.1 + POINT_DELTA_Y;
			point.graphics.beginFill(0x000000);
			point.graphics.drawCircle(-POINT_RADIUS/2, -POINT_RADIUS/2, POINT_RADIUS);
			point.graphics.endFill();
			
			//var pointNumber:TextField = new TextField();
			//pointNumber.text = Clock.arrPoints.length.toString();
			//point.addChild(pointNumber);
			//pointNumber.textColor = 0xffffff;
			//pointNumber.x =-POINT_RADIUS / 2;
			//pointNumber.y =-POINT_RADIUS / 2;
		}
		
		public static function redrawClockPoint(color:uint = 0):void
		{
			if (color == 0)
				color = ClockPoint.COLOR_HOURS;
			for (var i:int = 0; i < Clock.arrPoints.length; i++ )
			{
				Clock.arrPoints[i].point.graphics.clear();
				Clock.arrPoints[i].point.graphics.beginFill(color);
				Clock.arrPoints[i].point.graphics.drawCircle( -POINT_RADIUS/2, -POINT_RADIUS/2, POINT_RADIUS);
				Clock.arrPoints[i].point.graphics.endFill();
			}
		}
		
		/*private static function tweenPoint1(_point:Sprite, speed:int):void
		{
			var lightSpeed:Number = 1 / speed;
			Tweener.addTween(_point, { alpha:Math.abs(_point.alpha-1), time:lightSpeed, onComplete:tweenPointAgain } );
			function tweenPointAgain():void
			{
				if (speed == 0)
					return;
				speed--;
				Tweener.addTween(_point, { alpha:Math.abs(_point.alpha-1), time:lightSpeed, onComplete:tweenPointAgain } );
			}
		}*/
		
		private static function changeOnTime(activeClockPoint:uint, light:int = -1, speed:int = 2):void 
		{
			for (var i:int = 0; i < Clock.arrPoints.length; i++ )
			{
				if (i == activeClockPoint)
					Clock.arrPoints[i].point.alpha = 1;
				else if (i != light)
					Clock.arrPoints[i].point.alpha = 0;
			}
			//clock mode
			if (speed < 0)
			{
				Tweener.removeAllTweens();
				Clock.arrPoints[activeClockPoint].point.alpha = 1;
				if (activeClockPoint > light || (activeClockPoint == 0 && light == 5))
					Clock.arrPoints[light].point.alpha = 1;
				else
					Clock.arrPoints[light].point.alpha = 0;
				lastUsedPoint = -7;
				return;
			}
			//end clock mode
			
			isUp = Boolean(activeClockPoint < light);
			_speed = !isUp?speed:(300 - speed);
			if (light != -1)
			{
				if (lastUsedPoint != light)
				{
					Tweener.removeAllTweens();
					lastUsedPoint = light;
					tweenPoint();
				}
			}
		}
		
		private static function tweenPoint():void
		{
			var trnsation_type:String = (Clock.arrPoints[lastUsedPoint].point.alpha < 0.5)?TYPE_0_TO_1:TYPE_1_TO_0;
			
			//trnsation_type = "easeInExpo";
			
			if (lastUsedPoint > 0 && lastUsedPoint < 7)
			{
				var curSpeed:Number = _speed / 100;
				if (curSpeed < 0.1)
				{
					if (Clock.arrPoints[lastUsedPoint].point.alpha < 0.5)
						Tweener.addTween(Clock.arrPoints[lastUsedPoint].point, { alpha:1, time:curSpeed } );
					setTimeout(tweenPoint,1000);
					return;
				}
				Tweener.removeAllTweens();
				Tweener.addTween(Clock.arrPoints[lastUsedPoint].point, { alpha:Math.abs(Clock.arrPoints[lastUsedPoint].point.alpha - 1), time:curSpeed, onComplete:tweenPoint ,transition:trnsation_type} );
			}
		}
		
		public static function onTime(time_minutes:Number, time_hours:Number, time_seconds:Number, mode:Boolean):void
		{
			if (mode)
				redrawClockPoint();
			else
				redrawClockPoint(COLOR_MINUTES);
				
			var _sector:int = mode?(time_minutes / 5):time_hours%12;
			var speed:Number = mode?(int(time_minutes % 5) * 60 + time_seconds):-1;
			switch(_sector)
			{
				case 0:
					changeOnTime(0,5,speed);
				break;
				case 1:
					changeOnTime(0,1,speed);
				break;
				case 2:
					changeOnTime(1,0,speed);
				break;
				case 3:
					changeOnTime(1,2,speed);
				break;
				case 4:
					changeOnTime(2,1,speed);
				break;
				case 5:
					changeOnTime(2,3,speed);
				break;
				case 6:
					changeOnTime(3,2,speed);
				break;
				case 7:
					changeOnTime(3,4,speed);
				break;
				case 8:
					changeOnTime(4,3,speed);
				break;
				case 9:
					changeOnTime(4,5,speed);
				break;
				case 10:
					changeOnTime(5,4,speed);
				break;
				case 11:
					changeOnTime(5,0,speed);
				break;
			}
		}
	}
}