package  
{
	import com.smartfoxserver.v2.SmartFox;
	import mvc.commands.ReportScanResultCommand;
	import mvc.commands.SendProbeRequestCommand;
	import mvc.commands.SendScanRequestCommand;
	import mvc.commands.SetupSessionCommand;
	import mvc.commands.StartupCommand;
	import mvc.events.GameEvent;
	import mvc.mediators.AppMediator;
	import mvc.mediators.ConsoleMediator;
	import mvc.mediators.MapViewMediator;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.ConsoleView;
	import mvc.views.MapView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	/**
	 * ...
	 * @author liss
	 */
	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var eventCommandMap:IEventCommandMap;

		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var signalCommandMap:ISignalCommandMap;
		
		public function AppConfig() 
		{
			
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(ConfigModel).asSingleton();
			injector.map(SessionModel).asSingleton();
			injector.map(SmartFox).toValue(new SmartFox());
			injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(App).toMediator(AppMediator);
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			mediatorMap.map(MapView).toMediator(MapViewMediator);
			//event
			eventCommandMap.map(SessionEvent.NEXT_SESSION, SessionEvent).toCommand(SetupSessionCommand);
			eventCommandMap.map(GameEvent.SCAN_REQUEST, GameEvent).toCommand(SendScanRequestCommand);
			eventCommandMap.map(GameEvent.SCAN_RESULT, GameEvent).toCommand(ReportScanResultCommand);
			eventCommandMap.map(GameEvent.PROBE_REQUEST, GameEvent).toCommand(SendProbeRequestCommand);
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}