package mvc.views.gameobjects 
{
	import flash.display.Sprite;
	import mx.core.UIComponent;
	
	public class StationEva extends Station 
	{
		[Embed(source="../../../assets/swf/station.swf", symbol="StationEvaArt")]
		private var _picSrc:Class;
		
		public function StationEva() 
		{
			var pic:Sprite = new _picSrc() as Sprite;
			super(pic, 'станция "Ева"');
			
			mouseChildren = false;
		}
	}
}