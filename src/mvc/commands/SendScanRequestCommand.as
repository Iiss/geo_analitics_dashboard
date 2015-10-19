package mvc.commands 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.Room;
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import mvc.events.GameEvent;
	import robotlegs.bender.bundles.mvcs.Command;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import ru.marstefo.liss.net.models.ConfigModel;
	/**
	 * ...
	 * @author liss
	 */
	public class SendScanRequestCommand extends AsyncCommand
	{
		private static const COMMAND:String = "game.scanRequest";
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var config:ConfigModel;
		
		[Inject]
		public var gameEvent:GameEvent;
		
		public function SendScanRequestCommand() 
		{
			super();
		}
		override public function execute():void 
		{
			var room:Room = sfs.getRoomByName(config.room);
			var obj:SFSObject = SFSObject.newFromObject(gameEvent.data);
			var req:ExtensionRequest = new ExtensionRequest(COMMAND, obj, room);
			_addListeners();
			sfs.send(req);
		}
		private function _onResponse(e:SFSEvent):void
		{
			_removeListeners()
		};
		
		private function _addListeners():void 
		{
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, _onResponse);
		}
		private function _removeListeners():void
		{
			sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, _onResponse);
		}	
	}
}