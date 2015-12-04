package minigame.gravity
{
	import flash.display.*;
	import flash.events.*;
	import minigame.assets.*;
	import minigame.base.*;

	public class MovingStripe extends MinigameElementBase
	{
		private var bar:Sprite;
		private var barSimple:Sprite;
		private var barWrong:MovieClip;
		private var barRight:MovieClip;
		private var barSize:int = 20;
		private var delta:Number;
		private var callback:Function;

		private function onWrongEnterFrame(event:Event):void
		{
			if (barWrong.currentFrame == barWrong.totalFrames)
			{
				barWrong.removeEventListener(Event.ENTER_FRAME, onWrongEnterFrame);
				barWrong.stop();
				barWrong.visible = false;
				barSimple.visible = true;
				callback();
			}
		}

		private function onRightEnterFrame(event:Event):void
		{
			if (barRight.currentFrame == barRight.totalFrames)
			{
				barRight.removeEventListener(Event.ENTER_FRAME, onRightEnterFrame);
				barRight.stop();
				barRight.visible = false;
				barSimple.visible = true;
				callback();
			}
		}

		override public function showWrong(callback:Function):void
		{
			this.callback = callback;
			barSimple.visible = false;
			barWrong.visible = true;
			barWrong.gotoAndPlay(1);
			barWrong.addEventListener(Event.ENTER_FRAME, onWrongEnterFrame);
		}

		override public function showRight(callback:Function):void
		{
			this.callback = callback;
			barSimple.visible = false;
			barRight.visible = true;
			barRight.gotoAndPlay(1);
			barRight.addEventListener(Event.ENTER_FRAME, onRightEnterFrame);
		}

		override public function reset(value:Number=0):void
		{
			delta = 2 + Math.random() * .1;
			bar.y = Math.random() * (75 - barSize);
		}

		override public function deviate():void
		{
			delta += 2;
		}

		override public function step(count:uint):void
		{
			bar.y += delta * (bar.y * .1 + .1);
			if (bar.y > 75 - barSize)
			{
				bar.y = 75 - barSize;
				delta *= -1;
			}
			if (bar.y < 0)
			{
				bar.y = 0;
				delta *= -1;
			}
		}

		public function MovingStripe(index:int)
		{
			super(index);

			graphics.lineStyle(0, 0xFFFFFF, .3);
			graphics.beginFill(0x00FF00, 0);
			graphics.drawRect(0, 0, 12.5, 75);
			graphics.endFill();
			
			bar = new Sprite;
			barSimple = new GravityStripeBar;
			barWrong = new GravityStripeBarWrong;
			barRight = new GravityStripeBarRight;
			barSimple.y = barWrong.y = barRight.y = -75;
			barRight.visible = barWrong.visible = false;
			barWrong.stop();
			barRight.stop();
			bar.addChild(barSimple);
			bar.addChild(barWrong);
			bar.addChild(barRight);
			addChild(bar);
			var barmask:Sprite = new Sprite;
			barmask.graphics.beginFill(0x0000FF, 0);
			barmask.graphics.drawRect(0, 0, 12.5, 75);
			addChild(barmask);
			bar.mask = barmask;
			reset();
			
			mouseChildren = false;
		}
	}
}
