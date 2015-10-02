package ru.marstefo.liss.net.commands 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.SmartFox;
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import ru.marstefo.liss.net.models.ConfigModel;
	/**
	 * ...
	 * @author liss
	 */
	public class SFSJoinRoomCommand extends AsyncCommand
	{
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var config:ConfigModel;
		
		public function SFSJoinRoomCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{	
			sfs.addEventListener(SFSEvent.ROOM_JOIN, _onJoinRoom);
			sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, _onJoinRoomError);
			
			var req:JoinRoomRequest = new JoinRoomRequest(config.room);
			sfs.send(req);
		}
		
		private function _onJoinRoom(e:SFSEvent):void
		{
			_dTrace("Joined the room: " + sfs.lastJoinedRoom);
			dispatchComplete(true);
		}
		
		private function _onJoinRoomError(e:SFSEvent):void
		{
			_reportError("Join room failed: " + e.params.errorMessage);
		}
		
		private function _removeListeners():void
		{
			sfs.removeEventListener(SFSEvent.ROOM_JOIN, _onJoinRoom);
			sfs.removeEventListener(SFSEvent.ROOM_JOIN_ERROR, _onJoinRoomError);
		}
		
		// TODO: refactor this
		private function _reportError(e:*):void
		{
			//ErrorReportService.reportError(e);
			trace(e.toString());
			dispatchComplete(false);
		}
		
		private function _dTrace(msg:*):void
		{
			if (!msg) return;
			trace(msg.toString());
		}
	}
}