package ru.marstefo.liss.net.commands 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.SmartFox;
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	/**
	 * ...
	 * @author liss
	 */
	public class SFSConnectCommand  extends AsyncCommand
	{
		private static const SFS_CONFIG_PATH:String = "config/sfs-config.xml";
		
		[Inject]
		public var sfs:SmartFox;
		
		public function SFSConnectCommand() 
		{
			super();	
		}
		
		override public function execute():void 
		{
			sfs.addEventListener(SFSEvent.CONNECTION, _onConnection);
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, _onConfigLoadSuccess);
            sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, _onConfigLoadFailure);
			sfs.loadConfig(SFS_CONFIG_PATH);
		}
		
		private function _onConfigLoadFailure(e:SFSEvent):void
        {
			_removeConfigListeners();
			_reportError("Config Load Failure. Check config file at: "+SFS_CONFIG_PATH);
        }
 
        private function _onConfigLoadSuccess(e:SFSEvent):void
        {
			_removeConfigListeners();
			_dTrace("Server settings: " + sfs.config.host + ":" + sfs.config.port)
        }
 
        private function _onConnection(e:SFSEvent):void
        {
			_removeConnectListeners();
            if (e.params.success)
            {
                _dTrace("Connection Success.")
				dispatchComplete(true);
            }
            else
            {
                _reportError("Connection Failure: " + e.params.errorMessage)
            }
        }
		
		private function _removeConnectListeners():void
		{
			sfs.removeEventListener(SFSEvent.CONNECTION, _onConnection);
		}
		
		private function _removeConfigListeners():void
		{
			sfs.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, _onConfigLoadSuccess);
            sfs.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, _onConfigLoadFailure);
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