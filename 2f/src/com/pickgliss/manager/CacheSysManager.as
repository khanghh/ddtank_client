package com.pickgliss.manager
{
   import com.pickgliss.action.IAction;
   import com.pickgliss.action.TickOrderQueueAction;
   import flash.utils.Dictionary;
   
   public class CacheSysManager
   {
      
      private static var instance:CacheSysManager;
      
      private static var _lockDic:Dictionary = new Dictionary();
       
      
      private var _cacheDic:Dictionary;
      
      public function CacheSysManager(){super();}
      
      public static function getInstance() : CacheSysManager{return null;}
      
      private static function getReleaseAction(param1:Array, param2:uint = 0) : IAction{return null;}
      
      public static function lock(param1:String) : void{}
      
      public static function unlock(param1:String) : void{}
      
      public static function isLock(param1:String) : Boolean{return false;}
      
      public static function get lockDic() : Dictionary{return null;}
      
      public function cache(param1:String, param2:IAction) : void{}
      
      public function release(param1:String, param2:uint = 0) : void{}
      
      public function singleRelease(param1:String) : void{}
      
      public function cacheFunction(param1:String, param2:IAction) : void{}
   }
}
