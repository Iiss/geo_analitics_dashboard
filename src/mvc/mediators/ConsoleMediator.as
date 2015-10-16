package mvc.mediators 
{
	import com.smartfoxserver.v2.logging.LoggerEvent;
	import com.smartfoxserver.v2.SmartFox;
	import flash.text.TextFormat;
	import mvc.views.ConsoleView;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.liss.utils.LogService;
	import spark.utils.TextFlowUtil;
	/**
	 * ...
	 * @author liss
	 */
	public class ConsoleMediator extends Mediator
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var view:ConsoleView;
		
		[Inject]
		public var logger:LogService;
		
		public function ConsoleMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sfs.logger, LoggerEvent.INFO, _onLogger);
			eventMap.mapListener(sfs.logger, LoggerEvent.WARNING, _onLogger);
			eventMap.mapListener(sfs.logger, LoggerEvent.ERROR, _onLogger);
			eventMap.mapListener(logger, LoggerEvent.INFO, _onLogger);
			eventMap.mapListener(logger, LoggerEvent.WARNING, _onLogger);
			eventMap.mapListener(logger, LoggerEvent.ERROR, _onLogger);
		}
		private function _onLogger(e:LoggerEvent):void
		{
			var color:uint = Math.random() * 0xFFFFFF;
			var prefix:String = "";

			switch(e.type)
			{
				case LoggerEvent.WARNING:
					prefix = "[WARNING] ";
					break;
				case LoggerEvent.ERROR:
					prefix = "[ERROR] ";
					break;
			}
			
			view.text += prefix+e.params.message+"\n";
		}
	}

}