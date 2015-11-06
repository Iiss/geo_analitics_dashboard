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
		
		public function MapViewMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
			eventMap.mapListener(session, SessionEvent.MAP_UPDATE, _onMapUpdate);
			eventMap.mapListener(session, SessionEvent.CELL_SELECTED, _onCellSelected);
			
			//ui
			eventMap.mapListener(view.layersList, IndexChangeEvent.CHANGE, _invalidateLayerSelection);
			eventMap.mapListener(view.clickArea, MouseEvent.MOUSE_DOWN, _onMapClick);
		/*	eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanRequest);
			eventMap.mapListener(view.doScanBtn, MouseEvent.MOUSE_DOWN, _onScanResultClick);
			eventMap.mapListener(view.probeBtn, MouseEvent.MOUSE_DOWN, _onProbeBtnClick);
			eventMap.mapListener(view.deliverProbeBtn, MouseEvent.MOUSE_DOWN, _onDeliverProbeBtnClick);
			eventMap.mapListener(view.assignProbeBtn, MouseEvent.MOUSE_DOWN, _onAssignProbeBtnClick);*/
		}
		
		private function _onMapClick(e:MouseEvent):void
		{
			var cw:Number = view.clickArea.width / session.mapInfo.width;
			var rh:Number = view.clickArea.height / session.mapInfo.height;
			
			var ge:GameEvent =  new GameEvent(GameEvent.SELECT_CELL);
			ge.data = { x:Math.floor(e.localX/cw), y:Math.floor(e.localY / rh) };
			dispatch(ge);
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
		
	/*	private function _onScanRequest(e:MouseEvent):void
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
		*/
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
			_varlidateCellInfo();
			(view.tileList.dataProvider as ArrayCollection).refresh();
		}
		
		private function _onCellSelected(e:SessionEvent):void
		{
			_varlidateCellInfo()
		}
		
		private function _varlidateCellInfo():void
		{
			view.cellInfo.showCellInfo(session.layers,session.currentCell);
		}
		private function _validateScanBtn():void
		{
		}
	}
}