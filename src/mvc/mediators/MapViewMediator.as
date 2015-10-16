package mvc.mediators 
{
	import com.smartfoxserver.v2.SmartFox;
	import mvc.models.SessionModel;
	import mx.collections.ArrayCollection;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import com.smartfoxserver.v2.entities.Room;
	import mvc.models.SessionEvent;
	import mvc.views.MapView;
	/**
	 * ...
	 * @author liss
	 */
	public class MapViewMediator extends Mediator 
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var session:SessionModel;
		
		[Inject]
		public var view:MapView;
		
		public function MapViewMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			var room:Room = sfs.lastJoinedRoom;
			var tiles:Array = room.getVariable("mapData").getSFSObjectValue().getDoubleArray("1");
			//view.tileList.dataProvider = new ArrayCollection(tiles);
			
			
			//view.layersList = 
			
			view.drawGrid();
		}
		
	}

}