package mvc.mediators 
{
	import mvc.models.SessionModel;
	import mx.collections.ArrayCollection;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import mvc.views.components.LayerSelector;
	import mvc.events.GameEvent;
	import spark.events.IndexChangeEvent;
	import mvc.models.SessionEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class LayerSelectorMediator extends Mediator 
	{
		[Inject]
		public var session:SessionModel;
		
		[Inject]
		public var view:LayerSelector;
		
		public function LayerSelectorMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
			eventMap.mapListener(view, IndexChangeEvent.CHANGE, _onLayerSelect);
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			if (!view.dataProvider)
			{
				view.dataProvider = new ArrayCollection();
			}
			
			ArrayCollection(view.dataProvider).source = session.layers;
			
			if (session.layers.length > 0)
			{
				selectLayer(0);
			}
		}
		
		private function _onLayerSelect(e:IndexChangeEvent=null):void
		{
			selectLayer(view.selectedIndex);
		}
		
		private function selectLayer(layerIndex:int):void
		{
			_dispatchCommandEvent(GameEvent.SELECT_LAYER, {layerIndex:layerIndex});
		}
		
		private function _dispatchCommandEvent(eventType:String,data:Object):void
		{
			var ge:GameEvent = new GameEvent(eventType);
			ge.data = data;
			dispatch(ge);
		}
		
	}

}