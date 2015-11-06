package mvc.models 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author liss
	 */
	public class ValueDictionary 
	{
		private static var _legend:Array;
		public static const VALUES:Object =
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
		
		public static const PALETTE:Object = {
			//radioscale
			16:0xFFFBBE,17:0xF7F07B,18:0xFDEF06,19:0xE4DB36,20:0xC7BC0A,
			//magnitoscale
			21:0xE3A9A8,22:0xD67C7C,23:0xE1696A,24:0xC83636,25:0xA30D0E,
			//graviscale
			26:0x99E1A2,27:0x6DBE79,28:0x3EA04B,29:0x1C8E2E,30:0x046812
		}
	/*	public static function get LEGEND():Object
		{
			//_legend
			//radioscale
			1: { 0:PALETTE[16], 10:PALETTE[17], 15:PALETTE[18], 40:PALETTE[19], 100:PALETTE[20] },
			//magnitoscale
			2: { 0:PALETTE[21], 25:PALETTE[22], 50:PALETTE[23], 75:PALETTE[24], 100:PALETTE[25] },
			//graviscale
			3:{0:PALETTE[26], 25:PALETTE[27], 50:PALETTE[28], 75:PALETTE[29], 100:PALETTE[31]}
		}*/
	}
}