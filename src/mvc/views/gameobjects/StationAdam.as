package mvc.views.gameobjects 
{
	import flash.display.Sprite;
	import mx.core.UIComponent;
	
	public class StationAdam extends Station 
	{
		[Embed(source="../../../assets/swf/station.swf", symbol="StationAdamArt")]
		private var _picSrc:Class;
		
		public function StationAdam() 
		{
			var pic:Sprite = new _picSrc() as Sprite;
			super(pic, 'станция "Адам"');
			
			mouseEnabled = false;
			mouseChildren = false;
		}
	}
}