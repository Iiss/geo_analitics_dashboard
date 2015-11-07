package mvc.mediators 
{
	import mvc.models.CellLayerModel;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import mvc.views.components.AnalyticControlPanel;
	import flash.events.MouseEvent;
	import mvc.events.GameEvent;
	import mvc.models.SessionEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class AnalyticControlPanelMediator extends Mediator 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var view:AnalyticControlPanel;
		
		public function AnalyticControlPanelMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(sessionModel, SessionEvent.CELL_SELECTED, _update);
			eventMap.mapListener(sessionModel, SessionEvent.MAP_UPDATE, _update);
			eventMap.mapListener(sessionModel, SessionEvent.LAYER_SELECTED, _update);
			eventMap.mapListener(view.scanRequestBtn, MouseEvent.MOUSE_DOWN, _onScanRequestClick);
		}
		
		private function _update(e:SessionEvent):void
		{
			var scan_enabled:Boolean = false;
			if (sessionModel.currentLayer && sessionModel.currentCell)
			{
				var cl:CellLayerModel = sessionModel.currentCell.layers[sessionModel.currentLayer.id];
				scan_enabled = !cl.scanRequest && isNaN(cl.value);
			}
			
			view.scanRequestBtn.enabled = scan_enabled
		}
		
		private function _onScanRequestClick(e:MouseEvent):void
		{
			_dispatchCommandEvent(GameEvent.SCAN_REQUEST, { 
									x: sessionModel.currentCell.x,
									y: sessionModel.currentCell.y,
									layer_id: sessionModel.currentLayer.id
									})
		}
		
		private function _dispatchCommandEvent(eventType:String,data:Object=null):void
		{
			var ge:GameEvent = new GameEvent(eventType);
			ge.data = data;
			dispatch(ge);
		}
		
	}

}