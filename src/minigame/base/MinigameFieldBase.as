package minigame.base
{
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	import minigame.*;
	
	public class MinigameFieldBase extends Sprite
	{
		public var elements:Vector.<MinigameElementBase> = new Vector.<MinigameElementBase>;
		public var rightElement:int;
		public var accessories:Minigame;
		private var timer:Timer = new Timer(20);
		
		public function reset():void
		{
			accessories.show();
		}

		private function onTimer(event:TimerEvent):void
		{
			for (var i:int = 0; i < elements.length; i++) elements[i].step(timer.currentCount);
		}

		private function finishWin():void
		{
			accessories.finishWin();
		}

		public function onClick(event:MouseEvent):void
		{
			var element:MinigameElementBase = event.target as MinigameElementBase;
			if (element)
			{
				if (element.index == rightElement)
				{
					removeEventListener(MouseEvent.CLICK, onClick);
					dispatchEvent(new MinigameEvent(MinigameEvent.WIN));
					element.showRight(finishWin); 
				}
				else
				{
					accessories.decTrials();
					if (accessories.trials == 0) {
						removeEventListener(MouseEvent.CLICK, onClick);
						element.showWrong(accessories.finishLose);
					}
					else element.showWrong(function():void{});
				}
			}
		}

		public function MinigameFieldBase(accessories:Minigame)
		{
			this.accessories = accessories;
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			addEventListener(MouseEvent.CLICK, onClick);
			timer.start();	
		}
		
		public function die():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			this.accessories = null;
		}
	}
}
