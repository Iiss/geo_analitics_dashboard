package ru.marstefo.liss.net.commands
{
	import ru.marstefo.liss.utils.LogService;
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author liss
	 */
	public class LoadCommandBase extends AsyncCommand
	{
		[Inject]
		public var logger:LogService;
		
		public function LoadCommandBase() 
		{
			super();
		}
		
		protected function load(url:String):void 
		{
			var loader:URLLoader = new URLLoader();
			addListeners(loader);
			loader.load(new URLRequest(url));
		}
		
		protected function onComplete(result:*):void
		{
			//override me please :)
		}
		
		private function addListeners(l:IEventDispatcher):void
		{
			l.addEventListener(Event.COMPLETE, _onComplete);
			l.addEventListener(IOErrorEvent.IO_ERROR, _onError);
			l.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
		}
		
		private function removeListeners(l:IEventDispatcher):void
		{
			l.removeEventListener(Event.COMPLETE, _onComplete);
			l.removeEventListener(IOErrorEvent.IO_ERROR, _onError);
			l.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
		}
		
		private function _onComplete(e:Event):void
		{
			var l:URLLoader = e.currentTarget as URLLoader;
			removeListeners(l);
			
			if (l != null && l.data!=null)
			{
				try 
				{
					onComplete(l.data);
					dispatchComplete(true);
				}
				catch (e:Error)
				{
					_reportError(e)
				}
			}
			
			dispatchComplete(false);
		}
		
		private function _onError(e:Event):void
		{
			removeListeners(e.currentTarget as IEventDispatcher);
			_reportError(e);
		}
		
		private function _reportError(e:*):void
		{
			logger.error(e.toString());
			dispatchComplete(false);
		}

	}

}