package minigame 
{
	import com.greensock.TweenNano;
	import flash.geom.Point;
	import minigame.Minigame;
	import minigame.MinigameEvent;
	import minigame.MinigameView;
	import mvc.events.GameEvent;
	import mvc.models.CellModel;
	import mvc.models.ScanType;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class MinigameViewMediator extends Mediator
	{
		[Inject]
		public var session:SessionModel;
		
		[Inject]
		public var view:MinigameView;
		
		private var game:Minigame = new Minigame();
		private var _curLayer:int;
		
		public function MinigameViewMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(session, SessionEvent.CELL_SELECTED, _onCellSelected);
			eventMap.mapListener(session, SessionEvent.LAYER_SELECTED, _onLayerSelected);
			eventMap.mapListener(game, MinigameEvent.WIN, _onWin);
		}
		
		private function _onLayerSelected(e:SessionEvent):void
		{
			if (_curLayer == session.currentLayer.id) return;
			_curLayer = session.currentLayer.id;
			_clear();
		}
		
		private function _onCellSelected(e:SessionEvent):void
		{
			if (session.currentLayer.id != 2 && session.currentLayer.id != 3) return;
			if (session.currentLayer.limit == 0) return;
			
			var cell:CellModel = session.currentCell;
			var cellW:int = 25;
			var cellH:int = 25;
			
			game.x = session.currentCell.x * cellW;
			game.y = session.currentCell.y * cellH;
		
			if(!game.parent) view.addElement(game);
			
			var newPos:Point = new Point(game.x,game.y);
			
			// X-coord calculations
			if (cell.x == 0) newPos.x = 1 * cellW;
			if (cell.x > session.mapInfo.width - 3)
			{
				newPos.x = game.x = (session.currentCell.x+1) * cellW;
				game.scaleX = -1;
				if(cell.x > session.mapInfo.width - 2)
					newPos.x = game.x - cellW;
			}
			else
			{
				game.scaleX = 1;
			}
			
			// Y-coord calculations
			if (cell.y == 0) newPos.y = 1 * cellH;
			if (cell.y == session.mapInfo.height - 1)
			{
				 newPos.y = (session.mapInfo.height - 2) * cellH;
			}
			
			var scanType:String;
			switch(session.currentLayer.id)
			{
				case 2: scanType = ScanType.MAGNET ;break
				case 3: scanType = ScanType.GRAVI ;break
			}
			
			game.setup(scanType);
		
			if ((game.x !=newPos.x) ||(game.y!= newPos.y))
			{
				game.highlight();
				TweenNano.to(game, .3, { x:newPos.x, y:newPos.y, onComplete:game.show } );
			}
			else
			{
				game.show();
			}
		}
		
		private function _clear():void
		{
			if (view.numElements)
			{
				view.removeElement(game);
				game.die();
			}
		}
		
		private function _onWin(e:MinigameEvent):void
		{
			var ge:GameEvent = new GameEvent(GameEvent.SCAN_RESULT);
			ge.data = 
			{
				x: session.currentCell.x,
				y: session.currentCell.y,
				layer_id: session.currentLayer.id
			};
			dispatch(ge);
		}
	}
}