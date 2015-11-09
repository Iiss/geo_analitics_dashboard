package mvc.views.gameobjects 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import mx.core.UIComponent;
	
	public class DriverJoint extends UIComponent
	{
		private var _targets:Dictionary;
		private var _size:int;
		public function get size():int { return _size; }
		
		public function DriverJoint() 
		{
			_targets = new Dictionary;
		}
		
		public function addTarget(target:DisplayObject,jointPos:Point):void
		{
			_targets[target] = jointPos;
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function removeTarget(target:DisplayObject):void
		{
			delete _targets[target];
			_getSize();
			if (size < 0)
			{
				removeEventListener(Event.ENTER_FRAME, update);
				graphics.clear();
			}
		}
		
		private function update(e:*=null):void
		{
			graphics.clear();
			graphics.lineStyle(0, 0xFFFFFF, .4);
			
			for (var t:* in _targets)
			{
				var focusPos:Point = _targets[t];
				
				graphics.moveTo(focusPos.x,focusPos.y)
				graphics.lineTo(t.x, t.y);
				graphics.beginFill(0xFFFFFF, .1);
				graphics.drawCircle(t.x, t.y, 6);
				graphics.beginFill(0xFFFFFF, .4);
				graphics.drawCircle(0, 0, 3);
			}
		}
		
		private function _getSize():void
		{
			var n:int = 0;
			for (var key:* in _targets)
				n++;
			
			_size = n;
		}
	}

}