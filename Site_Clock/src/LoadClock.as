package  
{
	import fl.controls.ProgressBar;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author LVG
	 */
	public class LoadClock 
	{
		private static var _progressBar:ProgressBar;
		
		public static function load(url:String,progress:ProgressBar):Loader
		{
			_progressBar = progress;
			_progressBar.direction = 'right';
			_progressBar.mode = 'manual';
			var loader:Loader = new Loader();
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = url;
			configureListeners(loader.contentLoaderInfo);
			loader.load(urlRequest);
			_progressBar.visible = true;
			_progressBar.source = loader;
			
			return loader;
		}
		
		private static function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }

        private static function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
			_progressBar.visible = false;
        }

        private static function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private static function initHandler(event:Event):void {
            trace("initHandler: " + event);
        }

        private static function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private static function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private static function progressHandler(event:ProgressEvent):void {
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
			_progressBar.setProgress(event.bytesLoaded,event.bytesTotal);
        }

        private static function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
        }
		
	}

}