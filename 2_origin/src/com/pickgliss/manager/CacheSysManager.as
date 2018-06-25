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
      
      private static function getReleaseAction(actions:Array, delay:uint = 0) : IAction
      {
         var action:IAction = new TickOrderQueueAction(actions,100,delay);
         return action;
      }
      
      public static function lock(flag:String) : void
      {
         _lockDic[flag] = true;
      }
      
      public static function unlock(flag:String) : void
      {
      }
      
      public static function isLock(flag:String) : Boolean
      {
         return !!_lockDic[flag]?true:false;
      }
      
      public static function get lockDic() : Dictionary
      {
         var dic:Dictionary = new Dictionary();
         var _loc4_:int = 0;
         var _loc3_:* = _lockDic;
         for(var key in _lockDic)
         {
            dic[key] = _lockDic[key];
         }
         return dic;
      }
      
      public function cache(flag:String, action:IAction) : void
      {
         if(!_cacheDic[flag])
         {
            _cacheDic[flag] = [];
         }
         _cacheDic[flag].push(action);
      }
      
      public function release(flag:String, delay:uint = 0) : void
      {
         var action:* = null;
         if(_cacheDic[flag])
         {
            action = getReleaseAction(_cacheDic[flag] as Array,delay);
            action.act();
            delete _cacheDic[flag];
         }
      }
      
      public function singleRelease(flag:String) : void
      {
         var action:* = null;
         var actQueue:* = null;
         if(_cacheDic[flag])
         {
            actQueue = _cacheDic[flag];
            if(actQueue[0])
            {
               (actQueue[0] as IAction).act();
            }
            actQueue.shift();
         }
      }
      
      public function cacheFunction(flag:String, action:IAction) : void
      {
         if(!_cacheDic[flag])
         {
            _cacheDic[flag] = [];
         }
         _cacheDic[flag].push(action);
      }
   }
}
