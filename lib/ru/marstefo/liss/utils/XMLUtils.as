package ru.marstefo.liss.utils 
{
	public class XMLUtils 
	{
		public static function parseProperty(targetObject:*,node:XML,propKey:String=null):void
		{
			if (node)
			{
				if (!propKey) propKey = node.name().toString();
				
				var value:String = node.text().toString();
				switch (true)
				{
					case targetObject[propKey] is int:
						targetObject[propKey] = parseInt(value);
						break;
					
					case targetObject[propKey] is Number:
						targetObject[propKey] = parseFloat(value);
						break;
						
					case targetObject[propKey] is Boolean:
						targetObject[propKey] = !(value=='' || value.toLowerCase() == 'false' ||  value == '0');
						break;
						
					default:
						targetObject[propKey] = value;
						break;
				}
			}	
		}
		public static function shuffle(sourceList:XMLList,limit:int=0):XMLList  
		{
			var cnt:int = 0;
			var randomized:XMLList = new XMLList();
			
			while(sourceList.length()) 
			{
				var r:int = Math.floor(Math.random() * sourceList.length());
				randomized += sourceList[r];
				delete sourceList[r];
				
				if (limit > 0)
				{
					cnt++;
					if (cnt == limit) break;
				}
			}
			
			return randomized;
		}
	}
}