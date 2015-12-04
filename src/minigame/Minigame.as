package minigame
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import minigame.assets.*;
	import minigame.base.*;
	import minigame.gravity.StripeField;
	import minigame.magnetic.ArrowField;
	import mvc.models.ScanType;
	import mx.core.UIComponent;
	
	public class Minigame extends UIComponent
	{
		private var gameState:*;
		private var grow:MinigameFieldGrow1to3;
		private var grid:MovieClip;
		private var timer:Timer;
		private var closeButton:Sprite;
		private var closeTimer:MovieClip;
		private var closeTrials:MovieClip;
		private var closeGroup:Sprite;
		private var shutdownLose:MovieClip;
		private var shutdownWin:MovieClip;
		private var shutdownClose:MovieClip;
		private var grid3to6:MinigameFieldGrid3to6 = new MinigameFieldGrid3to6;
		private var grid6to6:MinigameFieldGrid3to6Stripes = new MinigameFieldGrid3to6Stripes;
		private var content:DisplayObjectContainer = new Sprite;
		
		public function get trials():int { return closeTrials.totalFrames - closeTrials.currentFrame; }

		public function decTrials():void
		{
			closeTrials.nextFrame();
		}

		private function onShutdownEnterFrame(event:Event):void
		{
			var shutdown:MovieClip = event.currentTarget as MovieClip;
			if (shutdown.currentFrame == shutdown.totalFrames)
			{
				shutdown.removeEventListener(Event.ENTER_FRAME, onShutdownEnterFrame);
				shutdown.stop();
				shutdown.visible = false;
			}
		}

		private function onTimer(event:TimerEvent):void
		{
			if (timer.currentCount % 15 == 0)
			{
				if (closeTimer.currentFrame == closeTimer.totalFrames) finishLose();
				closeTimer.nextFrame();
			}
		}

		private function onGridEnterFrame(event:Event):void
		{
			if (grid.currentFrame == grid.totalFrames)
			{
				grid.removeEventListener(Event.ENTER_FRAME, onGridEnterFrame);
				grid.stop();
				closeGroup.visible = true;
				content.visible = true;
				timer.start();
			}
		}

		private function onGrowEnterFrame(event:Event):void
		{
			if (grow.currentFrame == grow.totalFrames)
			{
				grow.removeEventListener(Event.ENTER_FRAME, onGrowEnterFrame);
				grow.stop();
				grow.visible = false;
				grid.visible = true;
				grid.gotoAndPlay(1);
				grid.addEventListener(Event.ENTER_FRAME, onGridEnterFrame);
				closeTimer.gotoAndStop(1);
			}
		}

		private function resetClips():void
		{
			timer.stop();
			closeGroup.visible = false;
			grid.visible = false;
			content.visible = false;
			grow.visible = true;
			grow.gotoAndPlay(1);
			grid.stop();
			closeTrials.gotoAndStop(1);
			grow.addEventListener(Event.ENTER_FRAME, onGrowEnterFrame);
		}

		public function show():void
		{
			resetClips();
		}

		private function shutdownGame():void
		{
			timer.stop();
			content.visible = false;
			closeGroup.visible = false;
			grid.visible = false;
		}

		private function playShutdownAnimation(clip:MovieClip):void
		{
			clip.visible = true;
			clip.gotoAndPlay(1);
			clip.addEventListener(Event.ENTER_FRAME, onShutdownEnterFrame);
		}
		public function highlight():void
		{
			grow.gotoAndStop(1);
			grow.visible = true;
		}
		
		public function die():void
		{
			shutdownGame();
			grid.removeEventListener(Event.ENTER_FRAME, onGridEnterFrame);
			grow.removeEventListener(Event.ENTER_FRAME, onGrowEnterFrame);
			shutdownWin.removeEventListener(Event.ENTER_FRAME, onShutdownEnterFrame);
			shutdownLose.removeEventListener(Event.ENTER_FRAME, onShutdownEnterFrame);
			shutdownClose.removeEventListener(Event.ENTER_FRAME, onShutdownEnterFrame);
			
			shutdownLose.visible = false;
			shutdownLose.stop();
			
			shutdownWin.visible = false;
			shutdownWin.stop();
			
			shutdownClose.visible = false;
			shutdownClose.stop();
		}
		
		public function finishWin():void
		{
			shutdownGame();
			playShutdownAnimation(shutdownWin);
		}

		public function finishLose():void
		{
			shutdownGame();
			playShutdownAnimation(shutdownLose);
		}

		private function finishClose():void
		{
			shutdownGame();
			playShutdownAnimation(shutdownClose);
		}
		
		private function onCloseButtonClick(event:MouseEvent):void
		{
			finishClose();
		}

		public function Minigame()
		{
			this.gameState = 
			{ 
				cellWidth:25, 
				cellHeight:25
			};
			
			grow = new MinigameFieldGrow1to3;
			grow.stop();
			
			closeButton = new MinigameCloseButton;
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			closeTimer = new MinigameTimer;
			closeTrials = new MinigameTrials;
			closeTrials.stop();
			closeGroup = new Sprite;
			closeGroup.addChild(closeButton);
			closeGroup.addChild(closeTimer);
			closeGroup.addChild(closeTrials);
			closeGroup.x = gameState.cellWidth * 2;
			closeGroup.y = -gameState.cellHeight;
			closeGroup.visible = false;
			shutdownLose = new MinigameLose;
			shutdownLose.visible = false;
			shutdownLose.stop();
			shutdownLose.x = -gameState.cellWidth;
			shutdownLose.y = -gameState.cellHeight;
			shutdownWin = new MinigameWin;
			shutdownWin.visible = false;
			shutdownWin.stop();
			shutdownWin.x = -gameState.cellWidth;
			shutdownWin.y = -gameState.cellHeight;
			shutdownClose = new MinigameClose;
			shutdownClose.visible = false;
			shutdownClose.stop();
			shutdownClose.x = -gameState.cellWidth;
			shutdownClose.y = -gameState.cellHeight;
			content.visible = false;
			content.x = -gameState.cellWidth;
			content.y = -gameState.cellHeight;
			addChild(grow);
			addChild(closeGroup);
			addChild(shutdownLose);
			addChild(shutdownWin);
			addChild(shutdownClose);
			addChild(content);
			timer = new Timer(20);
			
			
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public function setup(scanType:String):void
		{
			if (grid) removeChild(grid);
			if (content.numChildren) content.removeChildAt(0);
			
			var g:MinigameFieldBase
			switch (scanType)
			{
				case ScanType.MAGNET:
					grid = grid6to6;
					g = new ArrowField(gameState, this);
					break;
					
				case ScanType.GRAVI:
					g = new StripeField(gameState, this);
					grid = grid3to6; 
					break;
			}
			
			die();
			if (!g) return;
			
			grid.gotoAndStop(1);
			grid.x = -gameState.cellWidth;
			grid.y = -gameState.cellHeight;
			
			addChildAt(grid,1);
			
			if (content.numChildren) _clearContent();
			if (g)
			{
				g.addEventListener(MinigameEvent.WIN, _dispatchWin);
				g.reset();
				content.addChild(g);
			}
		}
		
		private function _clearContent():void
		{
			for (var i:int = numChildren - 1; i >= 0; i--)
			{
				var el:MinigameFieldBase = removeChildAt(i) as MinigameFieldBase;
				if (el) {
					el.removeEventListener(MinigameEvent.WIN, _dispatchWin);
					el.die();
					content.removeChildAt(i);
				}
			}
		}
		
		private function _dispatchWin(e:MinigameEvent):void
		{
			dispatchEvent(e);
		}
	}
}
