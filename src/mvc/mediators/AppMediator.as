package mvc.mediators 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import mvc.events.GameEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class AppMediator extends Mediator
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var view:App;
		
		[Inject]
		public var session:SessionModel;
		
		public function AppMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sfs, SFSEvent.ROOM_JOIN, _onConnection);
			eventMap.mapListener(session, SessionEvent.LOAD, _onSessionLoad);
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
		}
		
		private function _onConnection(e:SFSEvent):void
		{
			dispatch(new SessionEvent(SessionEvent.NEXT_SESSION));
		}
		
		private function _onSessionLoad(e:SessionEvent):void
		{
			view.currentState = "loading";
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			view.currentState = "in_game";
			var t:Timer = new Timer(24000);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();
		}
		private function onTimer(e:*):void
		{
			trace("dispatch");
			_dispatchCommandEvent(GameEvent.ASSIGN_PROBE,
								{ probe_id:1, kern_id:2128506})
			
		}
		
		
		private function _dispatchCommandEvent(eventType:String,data:Object):void
		{
			var ge:GameEvent = new GameEvent(eventType);
			ge.data = data;
			dispatch(ge);
		}
	}

}