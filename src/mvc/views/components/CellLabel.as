package mvc.views.components 
{
	import spark.components.Label;
	import spark.filters.GlowFilter;
	/**
	 * ...
	 * @author liss
	 */
	public class CellLabel extends Label 
	{
		public function CellLabel() 
		{
			super();
			styleName = "cellLabel";
			filters = [new GlowFilter(0,1,4,4,2)];
		}	
	}
}