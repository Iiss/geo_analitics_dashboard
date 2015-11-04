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
			eventMap.mapListener(sfs, SFSEvent.CONNECTION_LOST, _onConnectionLost);
			//ui
			eventMap.mapListener(view.layersList, IndexChangeEvent.CHANGE, _invalidateLayerSelection);
			eventMap.mapListener(view.clickArea, MouseEvent.MOUSE_DOWN, _onMapClick);
			eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanRequest);
			eventMap.mapListener(view.doScanBtn, MouseEvent.MOUSE_DOWN, _onScanResultClick);
			eventMap.mapListener(view.probeBtn, MouseEvent.MOUSE_DOWN, _onProbeBtnClick);
			eventMap.mapListener(view.deliverProbeBtn, MouseEvent.MOUSE_DOWN, _onDeliverProbeBtnClick);
			eventMap.mapListener(view.assignProbeBtn, MouseEvent.MOUSE_DOWN, _onAssignProbeBtnClick);
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
			var layerId:int = parseInt(view.layersList.selectedItem['id']);
			if (!(layerId && _selection)) return;
			_dispatchCommandEvent(GameEvent.SCAN_REQUEST,
								{ x:_selection.x, y:_selection.y, layer_id:layerId })
		}
		
		private function _onScanResultClick(e:MouseEvent):void
		{
			var layerId:int = parseInt(view.layersList.selectedItem['id']);
			if (!(layerId && _selection)) return;
			_dispatchCommandEvent(GameEvent.SCAN_RESULT,
								{ x:_selection.x, y:_selection.y, layer_id:layerId })
		}
		
		private function _onProbeBtnClick(e:MouseEvent):void
		{
			if (!_selection) return;
			_dispatchCommandEvent(GameEvent.PROBE_REQUEST,
								{ x:_selection.x, y:_selection.y })
		}
		
		private function _onDeliverProbeBtnClick(e:MouseEvent):void
		{
			if (!_selection) return;
			_dispatchCommandEvent(GameEvent.DELIVER_PROBE,
								{ x:_selection.x, y:_selection.y, rock_key:26})
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
		
		private function _onRoomVarsUpdate(e:SFSEvent):void
		{
			session.attachScanRequests();
			session.attachScanResults();
			(view.tileList.dataProvider as ArrayCollection).refresh();
		}
		
		private function _onConnectionLost(e:SFSEvent):void
		{
			trace('connection lost...');
		}
	}
}