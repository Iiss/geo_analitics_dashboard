package mvc.views.gameobjects 
{
	import flash.display.DisplayObject;
	import flash.filters.DropShadowFilter;
	import mx.core.UIComponent;
	
	public class Station extends UIComponent
	{
		private const shadow:DropShadowFilter = new DropShadowFilter(3, 45, 0x110100, .7);
		
		public function Station(pic:DisplayObject,label:String="") 
		{
			if (label)
			{
				var tooltip:Tooltip = new Tooltip(label);
				tooltip.x = -23;
				tooltip.y = 14;
				addChild(tooltip);
			}
			
			pic.filters = [shadow];
			addChild(pic);
		}
		
	}

}