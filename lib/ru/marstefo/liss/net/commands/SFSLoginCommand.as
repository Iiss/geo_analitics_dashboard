package ru.marstefo.liss.net.commands 
{
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.SmartFox;
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import com.smartfoxserver.v2.core.SFSEvent;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.net.commands.SFSAbstractAsyncCommand;
	/**
	 * ...
	 * @author liss
	 */
	public class SFSLoginCommand  extends SFSAbstractAsyncCommand
	{
		private static const SFS_CONFIG_PATH:String = "config/sfs-config.xml";
		
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var config:ConfigModel;
		
		public function SFSLoginCommand() 
		{
			super();	
		}
		
		override public function execute():void 
		{
			sfs.addEventListener(SFSEvent.LOGIN, _onLogin);
            sfs.addEventListener(SFSEvent.LOGIN_ERROR, _onLoginError);
			
			var req:LoginRequest = new LoginRequest(config.login);
			sfs.send(req);
		}
		
		private function _onLogin(e:SFSEvent):void
        {
			_removeListeners();
            _dTrace("Login success: " + e.params.user.name);
			dispatchComplete(true);
        }
		
		private function _onLoginError(e:SFSEvent):void
        {
			_removeListeners();
           _reportError("Login failed: " + e.params.errorMessage);
        }
		
		private function _removeListeners():void
		{
			sfs.removeEventListener(SFSEvent.LOGIN, _onLogin);
            sfs.removeEventListener(SFSEvent.LOGIN_ERROR, _onLoginError);
		}
	}
}