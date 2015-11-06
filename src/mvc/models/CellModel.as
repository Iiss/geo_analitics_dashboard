package mvc.models 
{
	/**
	 * ...
	 * @author liss
	 */
	public class CellModel 
	{
		public var layers:Array;
		public var x:int;
		public var y:int;
		
		public function CellModel(layersList:Array) 
		{
			layers = new Array();
			for each (var l:Object in layersList)
			{
				layers[l.id] = new CellLayerModel;
			}
		}
		
		public function addScanRequest(layerId:int):void
		{
			if (layerId >= layers.length || layerId < 0) return;
			var l:CellLayerModel = layers[layerId] as CellLayerModel;
			if (l) l.scanRequest = true;
		}
		
		public function addValue(layerId:int,value:Number):void
		{
			if (layerId >= layers.length || layerId < 0) return;
			var l:CellLayerModel = layers[layerId] as CellLayerModel;
			if (l) l.value = value;
		}
	}
}