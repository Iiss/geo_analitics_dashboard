package mvc.views.gameobjects 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import mx.core.UIComponent;
	import flash.display.MovieClip
	import flash.events.TimerEvent;
	import mvc.views.gameobjects.Tooltip;
	/**
	 * ...
	 * @author liss
	 */
	public class Zond extends UIComponent 
	{
		[Embed(source="../../../assets/swf/probe_button.swf", symbol="ProbeButtonArt")]
		private var _probeBtnSrc:Class;
		
		private var _probeBtn:Sprite;
		private var _speed:Number = 5;
		private var _speedVector:Point = new Point();
		private var _state:String;
		private var _zond:ZondAnimation;
		private var _timer:Timer;
		private var _probeTooltip:Tooltip;
		public static const DIG_DURATION:int = 2500;
		
		public function Zond() 
		{
			super ();
			
			_timer = new Timer(DIG_DURATION, 1);
			
			_probeBtn = new _probeBtnSrc as Sprite;
			_probeBtn.scaleX = _probeBtn.scaleY = 2;
			_probeBtn.visible = false;
			
			addChild(_probeBtn);
			
			var tooltip:Tooltip = new Tooltip("зонд");
			tooltip.x = -10;
			tooltip.y = 9;
			addChild(tooltip);
			
			_probeTooltip = new Tooltip("взять пробу");
			_probeTooltip.x = -5;
			_probeTooltip.y = -35;
			_probeTooltip.visible = false;
			addChild(_probeTooltip);
			
			_zond = new ZondAnimation();
			_zond.state = ZondAnimation.DEFAULT_STATE;
			addChild(_zond);
			
			addEventListener(MouseEvent.MOUSE_DOWN, _onClick);
		}
		
		private function _onClick(e:MouseEvent):void
		{
			var zond:ZondAnimation = e.target as ZondAnimation;
			if (zond)
			{
				if (_speedVector.x != 0 || _speedVector.y != 0)
				{
					_speedVector.x = 0;
					_speedVector.y = 0;
				}
				else
				{
					_probeBtn.visible = _probeTooltip.visible = true;
					removeEventListener(MouseEvent.MOUSE_DOWN, _onClick);
					_probeBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onDig);
				}
			}
			
		}
		
		private function _onDig(e:MouseEvent):void
		{
			_probeBtn.visible = _probeTooltip.visible = false;
			_probeBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onDig);
			_zond.state = ZondAnimation.DIG_STATE;
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, _onDigComplete);
			_timer.start();
		}
		
		private function _onDigComplete(e:TimerEvent):void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onDigComplete);
			_zond.state = ZondAnimation.FULL_STATE;
		}
	}
}