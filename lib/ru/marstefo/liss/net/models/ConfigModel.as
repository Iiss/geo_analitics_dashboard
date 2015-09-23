package ru.marstefo.liss.net.models
{
	import ru.marstefo.liss.utils.XMLUtils;
	/**
	 * Client configuration model
	 * @author liss
	 */
	public class ConfigModel 
	{
		public var login:String;
		public var room:String;
		
		public function parse(xmlData:XML):void
		{
			for each (var node:XML in xmlData.children())
			{
				XMLUtils.parseProperty(this, node);
			}
		}
	}
}