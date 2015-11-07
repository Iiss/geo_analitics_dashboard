package mvc.mediators 
{
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.MouseEvent;
	import mvc.events.GameEvent;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.MapView;
	import mx.collections.ArrayCollection;
	import robotlegs.bender.bundles.mvcs.Mediator;
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
			eventMap.mapListener(session, SessionEvent.MAP_UPDATE, _onMapUpdate);
			eventMap.mapListener(session, SessionEvent.LAYER_SELECTED, _onLayerSelected);
			
			//ui
			eventMap.mapListener(view.clickArea, MouseEvent.MOUSE_DOWN, _onMapClick);
		}
		
		private function _onMapClick(e:MouseEvent):void
		{
			var cw:Number = view.clickArea.width / session.mapInfo.width;
			var rh:Number = view.clickArea.height / session.mapInfo.height;
			
			_dispatchCommandEvent(GameEvent.SELECT_CELL,
								{ x:Math.floor(e.localX/cw), y:Math.floor(e.localY / rh) })
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			view.tileList.dataProvider = new ArrayCollection(session.cells);
			view.drawGrid(session.mapInfo.width, session.mapInfo.height);
		}
		
		private function _onLayerSelected(e:SessionEvent=null):void
		{
			view.setLayerId(session.currentLayer.id);
		}
		
		private function _onAssignProbeBtnClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.ASSIGN_PROBE,
								{ probe_id:1, kern_id:2128506})
		}
		
		private function _dispatchCommandEvent(eventType:String,data:Object):void
		{
			var ge:GameEvent = new GameEvent(eventType);
			ge.data = data;
			dispatch(ge);
		}
		
		private function _onMapUpdate(e:SessionEvent):void
		{
			(view.tileList.dataProvider as ArrayCollection).refresh();
		}
	}
}