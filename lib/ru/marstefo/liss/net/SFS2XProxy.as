package ru.marstefo.liss.net
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.EventDispatcher;
	
	public class SFS2XProxy extends EventDispatcher
	{
		private var _configPath:String = 'config/sfs-config.xml'
		private var _startRoom:String;
		private var _sfs:SmartFox;
		
		public function SFS2XProxy(startRoom:String, configPath:String = null, debugMode:Boolean = false) 
		{
			if (configPath) _configPath = configPath;
			_startRoom = startRoom;
			
			dTrace('=== Initialize SFS2XProxy ===');
			dTrace('debugMode: ' + debugMode);
			
			_sfs = new SmartFox(debugMode);
            _sfs.addEventListener(SFSEvent.CONNECTION, _onConnection);
            _sfs.addEventListener(SFSEvent.CONNECTION_LOST, _onConnectionLost);
			_sfs.addEventListener(SFSEvent.CONNECTION_RETRY, _onConnectionRetry);
			_sfs.addEventListener(SFSEvent.CONNECTION_RESUME, _onConnectionResume);
			
			_addConfigListeners();
            _sfs.loadConfig(_configPath);
		}
		
		private function _onConfigLoadFailure(e:SFSEvent):void
        {
			_removeConfigListeners();
			dTrace("Config Load Failure. Check config file at: "+_configPath);
        }
 
        private function _onConfigLoadSuccess(e:SFSEvent):void
        {
			_removeConfigListeners();
			dTrace("Server settings: " + _sfs.config.host + ":" + _sfs.config.port)
        }
 
        private function _onConnectionLost(e:SFSEvent):void
        {
			dTrace("Connection lost. Try to reconnect")
        }
		
		private function _onConnectionRetry(e:SFSEvent):void 
		{ 
			dTrace("Connection temporary lost. Try to reconnect."); 
		}
		
		private function _onConnectionResume(e:SFSEvent):void 
		{ 
			dTrace("Connection resumed."); 
		}
		
        private function _onConnection(e:SFSEvent):void
        {
            if (e.params.success)
            {
                dTrace("Connection Success.")
            }
            else
            {
                dTrace("Connection Failure: " + e.params.errorMessage)
            }
 
			_addLoginListeners();
            _sfs.send(new LoginRequest("user"+(new Date()).getTime(),"", _sfs.config.zone));
        }
 
        private function _onLogin(e:SFSEvent):void
        {
			_removeLoginListeners();
            dTrace("Login success: " + e.params.user.name);
			
			var req:JoinRoomRequest = new JoinRoomRequest(_startRoom);
			_sfs.addEventListener(SFSEvent.ROOM_JOIN, _onJoinRoom);
			_sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, _onJoinRoomError);
			_sfs.send(req);
        }
		
		private function _onLoginError(e:SFSEvent):void
        {
			_removeLoginListeners();
           dTrace("Login failed: " + e.params.errorMessage);
        }
		
		private function _onJoinRoom(e:SFSEvent):void
		{
			dTrace("Joined the room: " + _sfs.lastJoinedRoom);
		}
		
		private function _onJoinRoomError(e:SFSEvent):void
		{
			dTrace("Join room failed: " + e.params.errorMessage);
		}
		
		//
		// Event listeners management 
		//
		private function _addLoginListeners():void
		{
			_sfs.addEventListener(SFSEvent.LOGIN, _onLogin);
            _sfs.addEventListener(SFSEvent.LOGIN_ERROR, _onLoginError);
		}
		
		private function _removeLoginListeners():void
		{
			_sfs.removeEventListener(SFSEvent.LOGIN, _onLogin);
            _sfs.removeEventListener(SFSEvent.LOGIN_ERROR, _onLoginError);
		}
		
		private function _addConfigListeners():void
		{
			_sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, _onConfigLoadSuccess);
            _sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, _onConfigLoadFailure);
		}
		
		private function _removeConfigListeners():void
		{
			_sfs.removeEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, _onConfigLoadSuccess);
            _sfs.removeEventListener(SFSEvent.CONFIG_LOAD_FAILURE, _onConfigLoadFailure);
		}
		
		protected function onReady():void
		{
			
		}
		
		//
		// Events output
		//
		protected function dTrace(msg:*):void
		{
			if (!msg) return;
			trace(msg.toString());
			var e:SFS2XProxyEvent = new SFS2XProxyEvent(SFS2XProxyEvent.CONSOLE_MESSAGE);
			e.data = msg.toString();
			dispatchEvent(e);
		}
	}

}