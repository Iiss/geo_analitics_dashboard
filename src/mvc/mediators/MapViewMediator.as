package mvc.mediators 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.MouseEvent;
	import mvc.events.GameEvent;
	import mvc.models.SessionEvent;
	import mvc.models.SessionModel;
	import mvc.views.MapView;
	import mx.collections.ArrayCollection;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import spark.components.supportClasses.ItemRenderer;
	import spark.components.ToggleButton;
	/**
	 * ...
	 * @author liss
	 */
	public class MapViewMediator extends Mediator 
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var session:SessionModel;
		
		[Inject]
		public var view:MapView;
		
		public function MapViewMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(session, SessionEvent.READY, _onSessionReady);
			eventMap.mapListener(sfs, SFSEvent.ROOM_VARIABLES_UPDATE, _onRoomVarsUpdate);
			//ui
			eventMap.mapListener(view.layersList, MouseEvent.MOUSE_DOWN, _invalidateLayerSelection);
			eventMap.mapListener(view.clickArea, MouseEvent.MOUSE_DOWN, _onMapClick);
			eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanRequest);
		}
		
		private function _onMapClick(e:MouseEvent):void
		{
			var cw:Number = view.clickArea.width / session.mapInfo.width;
			var rh:Number = view.clickArea.height / session.mapInfo.height;
			
			var x:Number = Math.floor(e.localX/cw);
			var y:Number = Math.floor(e.localY/rh);
			
			trace('select x=' + x + ', y=' + y);
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			view.tileList.dataProvider = new ArrayCollection(session.cells);
			view.layersList.dataProvider = new ArrayCollection(session.layers);
			view.drawGrid(session.mapInfo.width, session.mapInfo.height);
			
			var a:int = 1;
			//selectLayer("1");
		}
		
		private function _invalidateLayerSelection(e:MouseEvent):void
		{
			var selection:ToggleButton  = e.target as ToggleButton;
			if (!selection)
			{
				return;
			}
			var selected_id:String = view.layersList.selectedItem["id"];
			
			for (var i:int = 0; i < selection.parent.parent.numChildren; i++)
			{
				var item:ItemRenderer =  selection.parent.parent.getChildAt(i) as ItemRenderer;
				if (item)
				{
					var tBtn:ToggleButton = item.getChildAt(0) as ToggleButton;
					if (tBtn != selection)
					{
						tBtn.selected = false;
					}
				}
			}
			
			selectLayer(selected_id);
		}
		
		private function selectLayer(id:String):void
		{
			/*var room:Room = sfs.lastJoinedRoom;
			var tiles:Array = room.getVariable("mapData").getSFSObjectValue().getDoubleArray(id);
			view.tileList.dataProvider = new ArrayCollection(tiles);
			*/
		}
		
		private function _onScanRequest(e:MouseEvent):void
		{
			var w:int = session.mapInfo.width;
			var ind:int = view.tileList.selectedIndex;
			var layerId:int = parseInt(view.layersList.selectedItem['id']);
			
			if (!layerId || ind < 0) return;
			
			var ge:GameEvent = new GameEvent(GameEvent.SCAN_REQUEST);
			ge.data = { x:ind % w, y:Math.floor(ind / w), layer_id:layerId };
			dispatch(ge);
		}
		
		private function _onRoomVarsUpdate(e:SFSEvent):void
		{
			trace(e.toString());
			var a:int = 1;
		}
	}
}