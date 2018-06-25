package com.pickgliss.loader
{
   import flash.utils.Dictionary;
   
   public class LoaderNameFilter
   {
      
      private static var _loadNameList:Dictionary = null;
      
      private static var _pathList:Dictionary;
       
      
      public function LoaderNameFilter()
      {
         super();
      }
      
      public static function setLoadNameContent(xml:XML) : void
      {
         var i:int = 0;
         var name:* = null;
         var loadName:* = null;
         var path:* = null;
         _loadNameList = new Dictionary();
         _pathList = new Dictionary();
         var xmlList:XMLList = xml..Item;
         var len:int = xmlList.length();
         for(i = 0; i < len; )
         {
            name = xmlList[i].@name;
            loadName = xmlList[i].@loadName;
            path = (String(xmlList[i].@path) + name).replace(/\\|\//g,"_");
            _loadNameList[name] = loadName;
            if(path != "" && _pathList[path] == null)
            {
               _pathList[path] = true;
            }
            i++;
         }
      }
      
      private static function isFilter(value:String) : Boolean
      {
         var filterPath:String = value.replace(/\\|\//g,"_").toLocaleLowerCase();
         var _loc5_:int = 0;
         var _loc4_:* = _pathList;
         for(var path in _pathList)
         {
            if(filterPath.indexOf(path.toLocaleLowerCase()) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getLoadFilePath(path:String) : String
      {
         var real:* = null;
         if(_loadNameList == null || !isFilter(path))
         {
            return path;
         }
         var loadPath:* = path;
         var _loc6_:int = 0;
         var _loc5_:* = _loadNameList;
         for(var realName in _loadNameList)
         {
            real = "/" + realName;
            if(loadPath.indexOf(real) != -1)
            {
               loadPath = loadPath.replace(realName,_loadNameList[realName]);
               break;
            }
         }
         return loadPath;
      }
      
      public static function getRealFilePath(path:String) : String
      {
         if(_loadNameList == null)
         {
            return path;
         }
         var realPath:* = path;
         var _loc5_:int = 0;
         var _loc4_:* = _loadNameList;
         for(var realName in _loadNameList)
         {
            if(path.indexOf(_loadNameList[realName]) != -1)
            {
               realPath = path.replace(_loadNameList[realName],realName);
               break;
            }
         }
         return realPath;
      }
   }
}
