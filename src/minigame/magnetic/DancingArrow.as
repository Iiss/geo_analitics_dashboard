package minigame.magnetic
{
	import flash.display.*;
	import flash.events.*;
	import minigame.assets.*;
	import minigame.base.*;

	public class DancingArrow extends MinigameElementBase
	{
		public var angle:Number;
		private var arrow:Sprite;
		private var simpleArrow:Sprite;
		private var wrongArrow:MovieClip;
		private var rightArrow:MovieClip;
		private var callback:Function;

		private function onWrongEnterFrame(event:Event):void
		{
			if (wrongArrow.currentFrame == wrongArrow.totalFrames)
			{
				wrongArrow.removeEventListener(Event.ENTER_FRAME, onWrongEnterFrame);
				wrongArrow.stop();
				wrongArrow.visible = false;
				simpleArrow.visible = true;
				callback();
			}
		}

		private function onRightEnterFrame(event:Event):void
		{
			if (rightArrow.currentFrame == rightArrow.totalFrames)
			{
				rightArrow.removeEventListener(Event.ENTER_FRAME, onRightEnterFrame);
				rightArrow.stop();
				rightArrow.visible = false;
				simpleArrow.visible = true;
				callback();
			}
		}

		override public function showWrong(callback:Function):void
		{
			this.callback = callback;
			wrongArrow.gotoAndPlay(1);
			wrongArrow.visible = true;
			simpleArrow.visible = false;
			wrongArrow.addEventListener(Event.ENTER_FRAME, onWrongEnterFrame);
		}

		override public function showRight(callback:Function):void
		{
			this.callback = callback;
			rightArrow.gotoAndPlay(1);
			rightArrow.visible = true;
			simpleArrow.visible = false;
			rightArrow.addEventListener(Event.ENTER_FRAME, onRightEnterFrame);
		}

		override public function reset(value:Number=0):void
		{
			angle = value + Math.random() * 20;
		}

		override public function deviate():void
		{
			angle += 30;
		}

		override public function step(count:uint):void
		{
			rotation = angle + Math.sin(count * .5) * 10;
		}

		public function DancingArrow(index:int, angle:Number)
		{
			super(index);
			this.angle = angle;
			graphics.beginFill(0x00FF00, 0);
			graphics.drawRect(-6.25, -6.25, 12.5, 12.5);
			simpleArrow = new CompassArrow;
			wrongArrow = new CompassArrowWrong;
			wrongArrow.visible = false;
			wrongArrow.stop();
			rightArrow = new CompassArrowRight;
			rightArrow.visible = false;
			rightArrow.stop();
			arrow = new Sprite;
			arrow.addChild(simpleArrow);
			arrow.addChild(wrongArrow);
			arrow.addChild(rightArrow);
			addChild(arrow);
		}
	}
}
