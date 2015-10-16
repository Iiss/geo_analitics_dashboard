package ru.marstefo.liss.utils 
{
	import flash.events.EventDispatcher;
	import com.smartfoxserver.v2.logging.LoggerEvent;
	
	public class LogService extends EventDispatcher
	{
		public function log(msg:String):void
		{
			report(msg, LoggerEvent.INFO);
		}
		
		public function warn(msg:String):void
		{
			report(msg, LoggerEvent.WARNING);
		}
		
		public function error(msg:String):void
		{
			report(msg, LoggerEvent.ERROR);
		}
		
		private function report(msg:String, msgType:String = null):void
		{
			var e:LoggerEvent = new LoggerEvent(msgType,{message:msg});
			dispatchEvent(e);
		}
	}
}