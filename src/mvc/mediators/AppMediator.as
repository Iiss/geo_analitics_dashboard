package mvc.mediators 
{
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
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
			eventMap.mapListener(sfs, SFSEvent.ROOM_VARIABLES_UPDATE, _dispatchForward);
		}
		
		private function _dispatchForward(e:SFSEvent):void
		{
			dispatch(e);
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
		}
		
	}

}