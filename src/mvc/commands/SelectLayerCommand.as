package mvc.commands 
{
	import mvc.events.GameEvent;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SelectLayerCommand extends Command 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var gameEvent:GameEvent;
		
		public function SelectLayerCommand() 
		{
			super()
		}
		
		override public function execute():void 
		{
			super.execute();
			if (!sessionModel.layers) return;
			
			var ind:int = gameEvent.data.layerIndex;
			if (ind < 0 || ind >= sessionModel.layers.length) return;
			
			sessionModel.currentLayer = sessionModel.layers[ind];
		}
		
	}

}