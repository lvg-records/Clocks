package 
{
	import fl.controls.Button;
	import fl.controls.ProgressBar;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author LVG
	 */
	public class Main extends Sprite 
	{
		public static const CLOCK_ON_FIVE_SECTORS		:String = "swf/Clockonfivesectors.swf";
		public static const CLOCK_ARC					:String = "swf/ArcClock.swf";
		public static const CLOCK_ARC_V2				:String = "swf/ArcClock_v2.swf";
		public static const CLOCK_6_PIXELS				:String = "swf/Clockon6pixels.swf";
		
		//clocks
		private var clock_on_five_sector				:Loader;
		private var clock_arc							:Loader;
		private var clock_arc_v2						:Loader;
		private var clock_6_pixels						:Loader;
		
		//btns
		private var btnClockOnFiveSectors				:Button;
		private var btnArcClock							:Button;
		private var __id1_								:Button;
		private var __id2_								:Button;
		
		private var loader								:Loader;
		private var bk									:MovieClip;
		private var placeForClock						:MovieClip;
		private var progress							:ProgressBar;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			bk = new mcMain();
			addChild(bk);
			
			placeForClock = bk['placeForClock'];
			progress = bk['progress'];
			progress.visible = false;
			
			btnClockOnFiveSectors = bk['btn_five_sector'];
			btnClockOnFiveSectors.addEventListener(MouseEvent.CLICK, loadClockOnFiveSectors );
			
			btnArcClock = bk['btnArcClock'];
			btnArcClock.addEventListener(MouseEvent.CLICK, loadArcClock );
			
			__id1_ = bk['__id1_'];
			__id1_.label = "Clock on 6 pixels";
			__id1_.addEventListener(MouseEvent.CLICK, loadClockOnSixPixel);
			
			__id2_ = bk['__id2_'];
			__id2_.label = "Arc clock (version 2)";
			__id2_.addEventListener(MouseEvent.CLICK, loadArcClock_v2);
			
			loadClockOnFiveSectors();
		}
		
		private function loadArcClock_v2(e:MouseEvent):void 
		{
			hideClocks();
			if (!clock_arc_v2)
			{
				clock_arc_v2 = LoadClock.load(CLOCK_ARC_V2, progress);
				placeForClock.addChild(clock_arc_v2);
			}
			else
				clock_arc_v2.visible = true;
		}
		
		private function loadClockOnSixPixel(e:MouseEvent):void 
		{
			hideClocks();
			if (!clock_6_pixels)
			{
				clock_6_pixels = LoadClock.load(CLOCK_6_PIXELS,progress);
				placeForClock.addChild(clock_6_pixels);
			}
			else
				clock_6_pixels.visible = true;
		}
		
		private function loadArcClock(e:MouseEvent):void 
		{
			hideClocks();
			if (!clock_arc)
			{
				clock_arc = LoadClock.load(CLOCK_ARC,progress);
				placeForClock.addChild(clock_arc);
			}
			else
				clock_arc.visible = true;
		}
		
		private function loadClockOnFiveSectors(e:MouseEvent = null):void
		{
			hideClocks();
			if (!clock_on_five_sector)
			{
				clock_on_five_sector = LoadClock.load(CLOCK_ON_FIVE_SECTORS,progress);
				placeForClock.addChild(clock_on_five_sector);
			}
			else
				clock_on_five_sector.visible = true;
		}
		
		private function hideClocks():void
		{
			for (var i:int = 0; i < placeForClock.numChildren; i++ )
				placeForClock.getChildAt(i).visible=false;
		}
		
	}
}