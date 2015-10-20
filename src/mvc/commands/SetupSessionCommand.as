package mvc.commands 
{
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.SmartFox;
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import mvc.models.SessionModel;
	import ru.marstefo.liss.net.models.ConfigModel;
	import ru.marstefo.liss.utils.LogService;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SetupSessionCommand extends AsyncCommand 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		[Inject]
		public var sfs:SmartFox;
		
		[Inject]
		public var config:ConfigModel;
		
		[Inject]
		public var logger:LogService;
		
		public function SetupSessionCommand() 
		{
			super();	
		}
		
		override public function execute():void 
		{	
			try
			{
				logger.log("Start session setup...");
				var room:Room = sfs.getRoomByName(config.room);
				sessionModel.setup(room);
			}
			catch (e:Error)
			{
				logger.error(e.toString());
			}
		}
	}

}