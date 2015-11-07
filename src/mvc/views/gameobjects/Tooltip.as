package mvc.views.gameobjects 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import assets.BenderFont;
	/**
	 * ...
	 * @author liss
	 */
	public class Tooltip extends Sprite
	{
		public function Tooltip(text:String) 
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat(new BenderFont().fontName, 7, 0x604932);
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = text;
			const border:Number = 3;
			tf.x = border + 1;
			tf.y = 1;
			graphics.beginFill(0xFFFAE5, .7);
			graphics.lineStyle(0, 0x736049, .3);
			const roundness:Number = 4;
			graphics.drawRoundRect(0, 0, tf.width + border * 2, tf.height, roundness);
			addChild(tf);
			
			mouseEnabled = false;
			mouseChildren = false;
		}		
	}
}