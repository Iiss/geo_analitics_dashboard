package mvc.commands 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import mvc.models.SessionModel;
	import robotlegs.bender.bundles.mvcs.Command;
	/**
	 * ...
	 * @author liss
	 */
	public class UpdateRoomVarsCommand extends Command
	{
		[Inject]
		public var event:SFSEvent;
		
		[Inject]
		public var sessionModel:SessionModel;
		
		public function UpdateRoomVarsCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			super.execute();
			sessionModel.updateRoomVars(event.params.changedVars);
		}	
	}
}