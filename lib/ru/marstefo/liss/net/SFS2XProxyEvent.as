package ru.marstefo.liss.net
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SFS2XProxyEvent extends Event 
	{
		public static const CONSOLE_MESSAGE:String = "SFS2XProxyEvent.CONSOLE_MESSAGE";
		public static const READY:String = "SFS2XProxyEvent.READY"; 
		public var data:*
		
		public function SFS2XProxyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SFS2XProxyEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SFS2XProxyEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}