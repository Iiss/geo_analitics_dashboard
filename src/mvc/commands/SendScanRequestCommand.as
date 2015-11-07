package mvc.commands 
{
	import mvc.models.SessionModel;
	public class SendScanRequestCommand extends ExtensionCommand
	{
		public function SendScanRequestCommand() 
		{
			super("game.scanRequest");
		}
		
		override public function execute():void 
		{
			super.execute();
		}
	}
}