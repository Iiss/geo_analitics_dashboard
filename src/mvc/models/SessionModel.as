package mvc.models 
{
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
		public const MAP_INFO_DATA_VAR:String = "mapInfo";
		private var _room:Room;
		private var _layers:Array;
		private var _mapInfo:MapInfo;
		private var _cells:Array;
		
		public function SessionModel() 
		{
			_mapInfo =  new MapInfo()
		}
		
		public function setup(room:Room):void
		{
			dispatchEvent(new SessionEvent(SessionEvent.LOAD));
			
			_room = room;
			_layers = (room.getVariable(LAYERS_DATA_VAR).getSFSArrayValue() as SFSArray).toArray();
			_mapInfo.setup(room.getVariable("mapInfo").getSFSObjectValue().toObject());
			
			_cells = new Array();
			for (var i:int = 0; i < _mapInfo.width * _mapInfo.height; i++)
			{
				_cells.push(1);
			}
			
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
	}
}