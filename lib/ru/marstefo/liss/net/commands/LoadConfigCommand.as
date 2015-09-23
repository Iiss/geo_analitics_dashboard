package ru.marstefo.liss.net.commands 
{
	import ru.marstefo.liss.net.commands.LoadCommandBase;
	import ru.marstefo.liss.net.models.ConfigModel;
	/**
	 * ...
	 * @author liss
	 */
	public class LoadConfigCommand extends LoadCommandBase 
	{
		private static const CONFIG_PATH:String = "config/client-config.xml";
		
		[Inject]
		public var configModel:ConfigModel;
		
		public function LoadConfigCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			load(CONFIG_PATH);
		}
		
		override protected function onComplete(result:*):void 
		{
			var data:XML = new XML(result);
			configModel.parse(data);
		}	
	}
}