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
      
      public static function setLoadNameContent(param1:XML) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         _loadNameList = new Dictionary();
         _pathList = new Dictionary();
         var _loc6_:XMLList = param1..Item;
         var _loc5_:int = _loc6_.length();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc6_[_loc7_].@name;
            _loc4_ = _loc6_[_loc7_].@loadName;
            _loc3_ = (String(_loc6_[_loc7_].@path) + _loc2_).replace(/\\|\//g,"_");
            _loadNameList[_loc2_] = _loc4_;
            if(_loc3_ != "" && _pathList[_loc3_] == null)
            {
               _pathList[_loc3_] = true;
            }
            _loc7_++;
         }
      }
      
      private static function isFilter(param1:String) : Boolean
      {
         var _loc3_:String = param1.replace(/\\|\//g,"_").toLocaleLowerCase();
         var _loc5_:int = 0;
         var _loc4_:* = _pathList;
         for(var _loc2_ in _pathList)
         {
            if(_loc3_.indexOf(_loc2_.toLocaleLowerCase()) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getLoadFilePath(param1:String) : String
      {
         var _loc2_:* = null;
         if(_loadNameList == null || !isFilter(param1))
         {
            return param1;
         }
         var _loc3_:* = param1;
         var _loc6_:int = 0;
         var _loc5_:* = _loadNameList;
         for(var _loc4_ in _loadNameList)
         {
            _loc2_ = "/" + _loc4_;
            if(_loc3_.indexOf(_loc2_) != -1)
            {
               _loc3_ = _loc3_.replace(_loc4_,_loadNameList[_loc4_]);
               break;
            }
         }
         return _loc3_;
      }
      
      public static function getRealFilePath(param1:String) : String
      {
         if(_loadNameList == null)
         {
            return param1;
         }
         var _loc3_:* = param1;
         var _loc5_:int = 0;
         var _loc4_:* = _loadNameList;
         for(var _loc2_ in _loadNameList)
         {
            if(param1.indexOf(_loadNameList[_loc2_]) != -1)
            {
               _loc3_ = param1.replace(_loadNameList[_loc2_],_loc2_);
               break;
            }
         }
         return _loc3_;
      }
   }
}
