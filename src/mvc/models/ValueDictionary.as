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
		public static const LEGEND:Object =
		{
			//_legend
			//radioscale
			1: [ 
			{value:0, color:PALETTE[16]},
			{value:10, color:PALETTE[17]}, 
			{value:15, color:PALETTE[18]}, 
			{value:40, color:PALETTE[19]}, 
			{value:100, color:PALETTE[20]} 
			],
			//magnitoscale
			2: [ 
			{value:0, color:PALETTE[21]}, 
			{value:25, color:PALETTE[22]}, 
			{value:50, color:PALETTE[23]}, 
			{value:75, color:PALETTE[24]}, 
			{value:100, color:PALETTE[25]}
			],
			//graviscale
			3:[
			{value:0, color:PALETTE[26]}, 
			{value:25, color:PALETTE[27]}, 
			{value:50, color:PALETTE[28]}, 
			{value:75, color:PALETTE[29]}, 
			{value:100, color:PALETTE[31]}
			]
		}
	}
}