package mvc.mediators 
{
	import com.smartfoxserver.v2.SmartFox;
	import mvc.events.GameEvent;
	import mvc.models.SessionModel;
	import mx.collections.ArrayCollection;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import com.smartfoxserver.v2.entities.Room;
	import mvc.models.SessionEvent;
	import mvc.views.MapView;
	import flash.events.MouseEvent;
	import spark.components.supportClasses.ItemRenderer;
	import spark.components.ToggleButton;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
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
			eventMap.mapListener(view.scanBtn, MouseEvent.MOUSE_DOWN, _onScanRequest);
		}
		
		private function _onSessionReady(e:SessionEvent):void
		{
			var room:Room = sfs.lastJoinedRoom;
			//selectLayer("1");
			var a:*= (room.getVariable("layers").getSFSArrayValue() as SFSArray).toArray();
			var mapInfo:Object = room.getVariable("mapInfo").getSFSObjectValue().toObject();
			var w:int = mapInfo["width"];
			var h:int = mapInfo["height"];
			
			var arr:Array = new Array();
			for (var t:int = 0; t < w * h; t++)
			{
				arr.push(1);
			}
			view.tileList.dataProvider = new ArrayCollection(arr);
			
			view.layersList.dataProvider = new ArrayCollection(a);
			view.drawGrid(w,h);
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
		{	var room:Room = sfs.lastJoinedRoom;
			var tiles:Array = room.getVariable("mapData").getSFSObjectValue().getDoubleArray(id);
			view.tileList.dataProvider = new ArrayCollection(tiles);
			
		}
		
		private function _onScanRequest(e:MouseEvent):void
		{
			var ind:int = view.tileList.selectedIndex;
			var layerId:int = parseInt(view.layersList.selectedItem['id']);
			
			if (!layerId || ind < 0) return;
			
			var ge:GameEvent = new GameEvent(GameEvent.SCAN_REQUEST);
			ge.data = { x:ind % 32, y:Math.floor(ind / 32), layer_id:layerId };
			dispatch(ge);
		}
		
		private function _onRoomVarsUpdate(e:SFSEvent):void
		{
			trace(e.toString());
			var a:int = 1;
		}
	}
}