package minigame 
{
	import flash.events.Event;

	public class MinigameEvent extends Event 
	{
		public static const WIN:String = "win";
		
		public function MinigameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MinigameEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MinigameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}