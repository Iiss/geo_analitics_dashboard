package  
{
	import com.smartfoxserver.v2.SmartFox;
	import mvc.commands.StartupCommand;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.net.models.ConfigModel;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import mvc.models.SessionModel;
	import mvc.models.SessionEvent;
	import mvc.commands.TestCommand;
	import mvc.views.ConsoleView;
	import mvc.mediators.ConsoleMediator;
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
			injector.map(SessionModel).toValue(new SessionModel());
			injector.map(SmartFox).toValue(new SmartFox());
			injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			//event
			eventCommandMap.map(SessionEvent.SESSION_READY, SessionEvent).toCommand(TestCommand);
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}