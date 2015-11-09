package mvc.views.gameobjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import mvc.views.gameobjects.ProbeProgressSkin;
	import mvc.views.gameobjects.Tooltip;
	import mx.core.UIComponent;
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
		private var _probeProgress:ProbeProgressSkin;
		
		public static const DIG_DURATION:int = 2500;
		
		public function Zond() 
		{
			super ();
			
			_timer = new Timer(DIG_DURATION, 1);
			
			_probeBtn = new _probeBtnSrc as Sprite;
			_probeBtn.scaleX = _probeBtn.scaleY = 2;
			_probeBtn.visible = false;	
			addChild(_probeBtn);
		
			addChild(new Tooltip("зонд",-10,9));
	
			_probeTooltip = new Tooltip("взять пробу",-5,-35);
			_probeTooltip.visible = false;
			addChild(_probeTooltip);
		
			_zond = new ZondAnimation();
			_zond.state = ZondAnimation.DEFAULT_STATE;
			addChild(_zond);
			
			_probeProgress = new ProbeProgressSkin()
			_probeProgress.visible = false;
			addChild(_probeProgress);
			
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
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			_probeProgress.visible = true;
			_timer.start();
		}
		
		private function _onDigComplete(e:TimerEvent):void
		{
			_probeProgress.visible = false;
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onDigComplete);
			removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
			_zond.state = ZondAnimation.FULL_STATE;
		}
		
		private function _onEnterFrame(e:Event):void
		{
			_probeProgress.rotation += 7;
		}
	}
}