package mvc.views.gameobjects
{
	import flash.display.*;

	public class ProbeProgressSkin extends Sprite
	{
		public function ProbeProgressSkin()
		{
			graphics.beginFill(0xFFFFFF, .5);
			graphics.drawCircle(0, 0, 10);
			graphics.drawCircle(0, 0, 7);
			graphics.drawRect(7, -2, 3, 4);
		}
	}
}
