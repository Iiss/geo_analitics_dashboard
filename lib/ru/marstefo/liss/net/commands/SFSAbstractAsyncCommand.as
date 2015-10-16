package ru.marstefo.liss.net.commands 
{
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import ru.marstefo.liss.utils.LogService;
	
	public class SFSAbstractAsyncCommand extends AsyncCommand
	{
		[Inject]
		public var logger:LogService;
		
		
		
		protected function _reportError(e:*):void
		{
			logger.error(e.toString());
			dispatchComplete(false);
		}
		
		protected function _dTrace(msg:*):void
		{
			if (!msg) return;
			logger.log(msg.toString());
		}
	}
}