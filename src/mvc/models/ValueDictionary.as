package mvc.models 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author liss
	 */
	public class ValueDictionary 
	{
		public static const VALUES:Object = new Object
		{
			//Rocks
			1:"Bas", 2:"BasMagnitoMg", 3:"Peredot", 4:"PeredotPlCr",
			5:"PiroksenLiAl", 6:"Peshan", 7:"Peschan UV", 8:"Peshan IceH2O",
			9:"Glina Al",10:"Peschan Mag",11:"Peschan Au",12:"BasNiCu",13:"Gypsum",
			//radioscale
			16:"0",17:"10",18:"15",19:"40",20:"100",
			//magnitoscale
			21:"0",22:"25",23:"50",24:"75",25:"100",
			//graviscale
			26:"0",27:"25",28:"50",29:"75",30:"100"
		}
		
		public static const LEGEND:Object = new Object
		{
			//radioscale
			1: { 0:0xFFFBBE, 10:0xF7F07B, 15:0xFDEF06, 40:0xE4DB36, 100:0xC7BC0A },
			//magnitoscale
			2: { 0:0xE3A9A8, 25:0xD67C7C, 50:0xE1696A, 75:0xC83636, 100:0xA30D0E },
			//graviscale
			3:{0:0x99E1A2,25:0x6DBE79,50:0x3EA04B,75:0x1C8E2E,100:0x046812}
		}
	}
}