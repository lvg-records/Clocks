package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author LVG
	 */
	public class ClockEvent extends Event
	{
		public static const CLICK:String = 'ClockEvent_click'
		
		private var _data:Object;
		
		public function ClockEvent( type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super(type, bubbles, cancelable);
			this._data = data;
			
		}
		
		public function get data():Object 
		{
			return _data;
		}
	}
}