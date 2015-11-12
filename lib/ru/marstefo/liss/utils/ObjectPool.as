package ru.marstefo.liss.utils 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	/**
	 * Very simple object pool util
	 * @author liss
	 */
	public class ObjectPool 
	{
		private var _pool:Dictionary = new Dictionary();
		
		public static function create(c:Class):Object
		{
			if (_pool[c] && _pool[c].length > 0)
				return _pool[c].shift();
			
			return new c();
		}
		
		public static function recycle(obj:Object):void
		{
			var c:Class = Class(getDefinitionByName(getQualifiedClassName(obj)));
			if (!_pool[c])
				_pool[c] = new Array();
			
			_pool[c].push = obj;		
		}
	}
}