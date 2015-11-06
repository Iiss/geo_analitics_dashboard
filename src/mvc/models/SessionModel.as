package mvc.models 
{
	import com.smartfoxserver.v2.entities.variables.RoomVariable;
	import flash.events.EventDispatcher;
	import org.osflash.signals.Signal;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.data.SFSArray;
	/**
	 * ...
	 * @author liss
	 */
	public class SessionModel extends EventDispatcher
	{
		public const LAYERS_DATA_VAR:String = "layers";
		public const SCAN_REQUESTS_DATA_VAR:String = "scanRequests";
		public const SCAN_DATA_VAR:String  = "scanData";
		public const MAP_INFO_DATA_VAR:String = "mapInfo";
		private var _room:Room;
		private var _layers:Array;
		private var _mapInfo:MapInfo;
		private var _cells:Array;
		private var _scanReq:Array;
		private var _curCell:CellModel;
		
		public function SessionModel() 
		{
			_mapInfo =  new MapInfo()
		}
		
		public function setup(room:Room):void
		{
			dispatchEvent(new SessionEvent(SessionEvent.LOAD));
			
			_room = room;
			_mapInfo.setup(room.getVariable("mapInfo").getSFSObjectValue().toObject());
			
			fillBlankData()
			attachScanRequests();
			attachScanResults();
			
			//temp functionality
			var t:Timer = new Timer(3000, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE,
			function():void { 
				dispatchEvent(new SessionEvent(SessionEvent.READY));
				trace("Session ready");
				} );
			t.start();
		}
		
		public function get cells():Array { return _cells; }
		public function get layers():Array { return _layers; }
		public function get mapInfo():MapInfo { return _mapInfo; }
		public function get room():Room { return _room; }
		public function get currentCell():CellModel { return _curCell; }
		public function set currentCell(value:CellModel):void
		{
			if (_curCell == value) return;
			_curCell = value;
			
			dispatchEvent(new SessionEvent(SessionEvent.CELL_SELECTED));
		}
		
		
		public function updateRoomVars(varsArr:Array):void
		{
			var mapUpdated:Boolean = false;
			
			for each (var roomVar:String in varsArr)
			{
				switch(roomVar)
				{
					case SCAN_REQUESTS_DATA_VAR:
						attachScanRequests();
						mapUpdated = true;
						break;
						
					case SCAN_DATA_VAR:
						attachScanResults();
						mapUpdated = true;
						break;
				}	
			}
			
			if (mapUpdated)
			{
				dispatchEvent(new SessionEvent(SessionEvent.MAP_UPDATE));
			}
		}
		
		
		private function fillBlankData():void
		{
			_layers = dumpToArray(LAYERS_DATA_VAR);
			if (_layers && _layers.length>0)
			{
				_cells = new Array();
				var cells_total:int = _mapInfo.width * _mapInfo.height;
				
				for (var i:int = 0; i < cells_total; i++)
				{
					_cells[i] = new CellModel(_layers);
					_cells[i].y = Math.floor(i / _mapInfo.width);
					_cells[i].x = i%_mapInfo.width;
				}
			}	
		}
		
		
		public function attachScanRequests():void
		{
			_scanReq = dumpToArray(SCAN_REQUESTS_DATA_VAR);
			if (_scanReq)
			{
				for each( var obj:* in _scanReq)
				{
					var c:CellModel = _cells[obj.cell_x  + obj.cell_y * _mapInfo.width] as CellModel;
					if (c)
					{
						c.addScanRequest(obj.layer_id)
					}
				}
			}
		}
		
		
		public function attachScanResults():void
		{
			var scanData:Array = dumpToArray(SCAN_DATA_VAR);
			if (scanData)
			{
				for each( var obj:* in scanData)
				{
					var c:CellModel = _cells[obj.cell_x + obj.cell_y * _mapInfo.width] as CellModel;
					if (c)
					{
						c.addValue(obj.layer_id,obj.value)
					}
				}
			}
		}
		
		
		private function dumpToArray(varName:String):Array
		{
			if (_room)
			{
				var roomVar:RoomVariable =  _room.getVariable(varName)
				if (roomVar)
				{
					var arr:SFSArray = roomVar.getSFSArrayValue() as SFSArray;
					if (arr)
					{
						return arr.toArray();
					}
				}
			}
			
			return null
		}
	}
}