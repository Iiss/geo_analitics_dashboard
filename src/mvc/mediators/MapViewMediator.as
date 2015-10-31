package mvc.mediators 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mvc.events.GameEvent;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.MapView;
	import mx.collections.ArrayCollection;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import spark.events.IndexChangeEvent;
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
		
		private var _selection:Point;
		
		public function MapViewMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
			eventMap.mapListener(sfs, SFSEvent.ROOM_VARIABLES_UPDATE, _onRoomVarsUpdate);
			//ui
			eventMap.mapListener(view.layersList, IndexChangeEvent.CHANGE, _invalidateLayerSelection);
			eventMap.mapListener(view.clickArea, MouseEvent.MOUSE_DOWN, _onMapClick);
			eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanRequest);
		}
		
		private function _onMapClick(e:MouseEvent):void
		{
			var cw:Number = view.clickArea.width / session.mapInfo.width;
			var rh:Number = view.clickArea.height / session.mapInfo.height;
			
			if (!_selection) _selection = new Point();
			
			_selection.x = Math.floor(e.localX/cw);
			_selection.y = Math.floor(e.localY / rh);
			
			//validate cell info
			view.cellInfo.showCellInfo(session.layers,session.cells[_selection.x + _selection.y * session.mapInfo.width],_selection.x,_selection.y);
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			view.tileList.dataProvider = new ArrayCollection(session.cells);
			view.layersList.dataProvider = new ArrayCollection(session.layers);
			view.drawGrid(session.mapInfo.width, session.mapInfo.height);
			
			if (session.layers.length > 0)
			{
				view.layersList.selectedIndex = 0;
				_invalidateLayerSelection()
			}
		}
		
		private function _invalidateLayerSelection(e:IndexChangeEvent=null):void
		{
			view.setLayerId(session.layers[view.layersList.selectedIndex].id);
		}
		
		private function _onScanRequest(e:MouseEvent):void
		{
			var w:int = session.mapInfo.width;
			var layerId:int = parseInt(view.layersList.selectedItem['id']);
			
			if (!(layerId && _selection)) return;
			
			var ge:GameEvent = new GameEvent(GameEvent.SCAN_REQUEST);
			ge.data = { x:_selection.x, y:_selection.y, layer_id:layerId };
			dispatch(ge);
		}
		
		private function _onRoomVarsUpdate(e:SFSEvent):void
		{
			session.attachScanRequests();
			(view.tileList.dataProvider as ArrayCollection).refresh();
		}
	}
}