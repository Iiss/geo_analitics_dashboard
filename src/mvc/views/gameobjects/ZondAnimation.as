package mvc.views.gameobjects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	/**
	 * ...
	 * @author liss
	 */
	public class ZondAnimation extends Sprite
	{
		[Embed(source="../../../assets/swf/zond.swf", symbol="ZondDiggingArt")]
		private var _digSrc:Class;
		
		[Embed(source="../../../assets/swf/zond.swf", symbol="ZondEmptyArt")]
		private var _emptySrc:Class;
		
		[Embed(source="../../../assets/swf/zond.swf", symbol="ZondFullArt")]
		private var _fullSrc:Class;
		
		private const shadow:DropShadowFilter = new DropShadowFilter(3, 45, 0x110100, .7);
		
		private var _emptySkin:Sprite;
		private var _digginSkin:MovieClip;
		private var _fullSkin:Sprite;
		private var _state:String;
		
		public static const DEFAULT_STATE:String = "default";
		public static const DIG_STATE:String = "dig";
		public static const FULL_STATE:String = "full";
		
		public function ZondAnimation() 
		{
			_emptySkin = new _emptySrc() as Sprite;
			_digginSkin = new _digSrc() as MovieClip;
			_fullSkin = new _fullSrc() as Sprite;
			
			filters = [shadow];
			
			mouseChildren = false;
		}
		
		public function get state():String { return _state; }
		public function set state(value:String):void
		{
			if (_state == value) return;
			_state = value;
			
			switch(_state)
			{
				case DEFAULT_STATE:
					removeAll();
					addChild(_emptySkin);
					break;
					
				case DIG_STATE:
					removeAll();
					addChild(_digginSkin);
					break;
					
				case FULL_STATE:
					removeAll();
					addChild(_fullSkin);
					break;
			}
		}
		
		private function removeAll():void
		{
			for (var i:int = numChildren - 1; i >= 0; i--)
			{
				removeChildAt(i);
			}
		}
		
	}

}