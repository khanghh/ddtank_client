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
      
      public function CacheSysManager()
      {
         super();
         _cacheDic = new Dictionary();
         _lockDic = new Dictionary();
      }
      
      public static function getInstance() : CacheSysManager
      {
         if(instance == null)
         {
            instance = new CacheSysManager();
         }
         return instance;
      }
      
      private static function getReleaseAction(param1:Array, param2:uint = 0) : IAction
      {
         var _loc3_:IAction = new TickOrderQueueAction(param1,100,param2);
         return _loc3_;
      }
      
      public static function lock(param1:String) : void
      {
         _lockDic[param1] = true;
      }
      
      public static function unlock(param1:String) : void
      {
      }
      
      public static function isLock(param1:String) : Boolean
      {
         return !!_lockDic[param1]?true:false;
      }
      
      public static function get lockDic() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc4_:int = 0;
         var _loc3_:* = _lockDic;
         for(var _loc2_ in _lockDic)
         {
            _loc1_[_loc2_] = _lockDic[_loc2_];
         }
         return _loc1_;
      }
      
      public function cache(param1:String, param2:IAction) : void
      {
         if(!_cacheDic[param1])
         {
            _cacheDic[param1] = [];
         }
         _cacheDic[param1].push(param2);
      }
      
      public function release(param1:String, param2:uint = 0) : void
      {
         var _loc3_:* = null;
         if(_cacheDic[param1])
         {
            _loc3_ = getReleaseAction(_cacheDic[param1] as Array,param2);
            _loc3_.act();
            delete _cacheDic[param1];
         }
      }
      
      public function singleRelease(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_cacheDic[param1])
         {
            _loc2_ = _cacheDic[param1];
            if(_loc2_[0])
            {
               (_loc2_[0] as IAction).act();
            }
            _loc2_.shift();
         }
      }
      
      public function cacheFunction(param1:String, param2:IAction) : void
      {
         if(!_cacheDic[param1])
         {
            _cacheDic[param1] = [];
         }
         _cacheDic[param1].push(param2);
      }
   }
}
