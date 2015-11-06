package mvc.models 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SessionEvent extends Event 
	{
		public static const LOAD:String = "LOAD";
		public static const READY:String = "READY";
		public static const NEXT_SESSION:String = "NEXT_SESSION";
		public static const MAP_UPDATE:String = "MAP_UPDATE";
		
		
		public function SessionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SessionEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SessionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}