package com.pickgliss.manager{   import com.pickgliss.action.IAction;   import com.pickgliss.action.TickOrderQueueAction;   import flash.utils.Dictionary;      public class CacheSysManager   {            private static var instance:CacheSysManager;            private static var _lockDic:Dictionary = new Dictionary();                   private var _cacheDic:Dictionary;            public function CacheSysManager() { super(); }
            public static function getInstance() : CacheSysManager { return null; }
            private static function getReleaseAction(actions:Array, delay:uint = 0) : IAction { return null; }
            public static function lock(flag:String) : void { }
            public static function unlock(flag:String) : void { }
            public static function isLock(flag:String) : Boolean { return false; }
            public static function get lockDic() : Dictionary { return null; }
            public function cache(flag:String, action:IAction) : void { }
            public function release(flag:String, delay:uint = 0) : void { }
            public function singleRelease(flag:String) : void { }
            public function cacheFunction(flag:String, action:IAction) : void { }
   }}