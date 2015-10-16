package mvc.models 
{
	import flash.events.EventDispatcher;
	import org.osflash.signals.Signal;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class SessionModel extends EventDispatcher
	{
		public var propertyChanged:Signal = new Signal(String, Object);
		
		private var _layers:Array;
		
		public function SessionModel() 
		{
			
		}
		
		public function setup():void
		{
			dispatchEvent(new SessionEvent(SessionEvent.LOAD));
			var t:Timer = new Timer(3000, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE,
			function():void { 
				dispatchEvent(new SessionEvent(SessionEvent.READY));
				trace("Session ready");
				} );
			t.start();
		}
	}
}