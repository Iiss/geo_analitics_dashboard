package mvc.mediators 
{
	import com.greensock.TweenNano;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mvc.events.GameEvent;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
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
			eventMap.mapListener(session, SessionEvent.LOCKED, _onSessionLoad);
			eventMap.mapListener(session, SessionEvent.UNLOCKED, _onSessionUnlock);
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
			eventMap.mapListener(sfs, SFSEvent.ROOM_VARIABLES_UPDATE, _dispatchForward);
		}
		
		private function _dispatchForward(e:SFSEvent):void
		{
			dispatch(e);
		}
		private function _onSessionUnlock(e:SessionEvent):void
		{
			dispatch(new SessionEvent(SessionEvent.NEXT_SESSION));
		}
		
		private function _onConnection(e:SFSEvent):void
		{
			dispatch(new SessionEvent(SessionEvent.NEXT_SESSION));
			var t:Timer = new Timer(10000, 0);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			dispatch(new GameEvent(GameEvent.PING));
		}
		
		private function _onSessionLoad(e:SessionEvent):void
		{
			view.currentState = "loading";
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			TweenNano.delayedCall(3, _gotoGame);
		}
		
		private function _gotoGame():void
		{
			view.currentState = "in_game";
		}
	}
}