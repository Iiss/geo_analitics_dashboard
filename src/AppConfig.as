package  
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import mvc.commands.*;
	import mvc.events.GameEvent;
	import mvc.mediators.*;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.components.AnalyticControlPanel;
	import mvc.views.components.CellInfoPanel;
	import mvc.views.components.LayerSelector;
	import mvc.views.ConsoleView;
	import mvc.views.MapView;
	import minigame.*;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	import mvc.views.components.SelectionLock;
	
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
			injector.map(SessionModel).asSingleton();
			injector.map(SmartFox).toValue(new SmartFox());
			injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(App).toMediator(AppMediator);
			mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
			mediatorMap.map(MapView).toMediator(MapViewMediator);
			mediatorMap.map(LayerSelector).toMediator(LayerSelectorMediator);
			mediatorMap.map(CellInfoPanel).toMediator(CellInfoPanelMediator);
			mediatorMap.map(AnalyticControlPanel).toMediator(AnalyticControlPanelMediator);
			mediatorMap.map(MinigameView).toMediator(MinigameViewMediator);
			mediatorMap.map(SelectionLock).toMediator(SelectionLockMediator);
			//event
			eventCommandMap.map(SessionEvent.NEXT_SESSION, SessionEvent).toCommand(SetupSessionCommand);
			eventCommandMap.map(GameEvent.SCAN_REQUEST, GameEvent).toCommand(SendScanRequestCommand);
			eventCommandMap.map(GameEvent.SCAN_RESULT, GameEvent).toCommand(ReportScanResultCommand);
			eventCommandMap.map(GameEvent.DELIVER_PROBE, GameEvent).toCommand(DeliverProbeCommand);
			eventCommandMap.map(GameEvent.ASSIGN_PROBE, GameEvent).toCommand(AssignProbeCommand);
			eventCommandMap.map(SFSEvent.ROOM_VARIABLES_UPDATE, SFSEvent).toCommand(UpdateRoomVarsCommand);
			eventCommandMap.map(GameEvent.SELECT_CELL, GameEvent).toCommand(SelectCellCommand);
			eventCommandMap.map(GameEvent.SELECT_LAYER, GameEvent).toCommand(SelectLayerCommand);
			eventCommandMap.map(GameEvent.PING, GameEvent).toCommand(PingCommand);
			//Commands
			directCommandMap.map(StartupCommand).execute();
		}
		
	}

}