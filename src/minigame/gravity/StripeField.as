package minigame.gravity
{
	import flash.display.*;
	import flash.events.*;
	import minigame.*;
	import minigame.base.*;

	public class StripeField extends MinigameFieldBase
	{
		override public function reset():void
		{
			super.reset();
			for (var i:int = 0; i < elements.length; i++) elements[i].reset();
			rightElement = Math.floor(Math.random() * elements.length);
			elements[rightElement].deviate();
		}

		public function StripeField(gameState:*, accessories:Minigame)
		{
			super(accessories);
			for (var i:int = 0; i < 6; i++)
			{
				var element:Sprite = new MovingStripe(i);
				element.x = i * gameState.cellWidth * .5;
				element.x = i * 25 * .5;
				addChild(element);
				elements.push(element);
			}
		}
	}
}
