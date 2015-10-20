package mvc.models 
{
	/**
	 * ...
	 * @author liss
	 */
	public class MapInfo 
	{
		public var tile:String;
		public var width:int;
		public var height:int;
		
		public function setup(src:Object):void
		{
			tile = src["title"];
			width = src["width"];
			height = src["height"];
		}
	}
}