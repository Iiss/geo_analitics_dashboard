package mvc.commands 
{
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import mvc.models.SessionModel;
	
	/**
	 * ...
	 * @author liss
	 */
	public class SetupSessionCommand extends AsyncCommand 
	{
		[Inject]
		public var sessionModel:SessionModel;
		
		public function SetupSessionCommand() 
		{
			super();	
		}
		
		override public function execute():void 
		{	
			sessionModel.setup();
		}
		
	}

}