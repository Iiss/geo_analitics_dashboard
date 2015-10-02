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
		
		
		public function AppConfig() 
		{
			
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(ConfigModel).asSingleton();
			injector.map(SmartFox).asSingleton();
			//MEDIATORS
			
			//Events
			
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}