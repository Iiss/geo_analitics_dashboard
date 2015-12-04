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
		public static const CELL_SELECTED:String = "CELL_SELECTED";
		public static const LAYER_SELECTED:String = "LAYER_SELECTED";
		public static const LAYERS_CHANGED:String = "LAYERS_CHANGED";
		public static const LOCKED:String = "LOCKED";
		public static const UNLOCKED:String = "UNLOCKED";
		
		
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