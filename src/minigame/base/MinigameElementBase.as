package minigame.base
{
	import flash.events.*;
	import flash.display.*;

	public class MinigameElementBase extends Sprite
	{
		public var index:int;

		public function showRight(callback:Function):void
		{
			// code...
		}

		public function showWrong(callback:Function):void
		{
			// code...
		}

		public function reset(value:Number=0):void
		{
			// code...
		}

		public function deviate():void
		{
			// code...
		}

		public function step(count:uint):void
		{
			// code...
		}

		public function MinigameElementBase(index:int)
		{
			this.index = index;
		}
	}
}
