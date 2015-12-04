package minigame.magnetic
{
	import flash.events.*;
	import flash.display.*;
	import minigame.*;
	import minigame.base.*;

	public class ArrowField extends MinigameFieldBase
	{
		override public function reset():void
		{
			super.reset();
			var angle:Number = 360 * Math.random();
			for (var i:int = 0; i < elements.length; i++) elements[i].reset(angle);
			rightElement = Math.floor(Math.random() * elements.length);
			elements[rightElement].deviate();
		}

		public function ArrowField(gameState:*, accessories:Minigame)
		{
			super(accessories);
			for (var j:int = 0; j < 6; j++)
			{
				for (var i:int = 0; i < 6; i++)
				{
					var element:Sprite = new DancingArrow(elements.length, 0);
					element.x = (j + .5) * gameState.cellWidth/2;
					element.y = (i + .5) * gameState.cellHeight / 2;
					element.mouseChildren = false;
					addChild(element);
					elements.push(element);
				}
			}
		}
	}
}
