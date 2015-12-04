package mvc.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class GameEvent extends Event 
	{
		public static const SCAN_REQUEST:String = "SCAN_REQUEST";
		public static const SCAN_RESULT:String = "SCAN_RESULT";
		public static const SELECT_CELL:String = "SELECT_CELL";
		public static const SELECT_LAYER:String = "SELECT_LAYER";
		public static const DELIVER_PROBE:String = "DELIVER_PROBE";
		public static const ASSIGN_PROBE:String = "ASSIGN_PROBE";
		public static const PLACE_PLANT:String = "PLACE_PLANT";
		public static const REMOVE_PLANT:String = "REMOVE_PLANT";
		public static const PING:String = "PING";
		public var data:*
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			var e:GameEvent = new GameEvent(type, bubbles, cancelable);
			e.data = data;
			return e;
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}