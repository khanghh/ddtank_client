package com.pickgliss.loader
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class LoaderSavingManager extends EventDispatcher
   {
      
      private static const LOCAL_FILE:String = "7road/files";
      
      private static var _cacheFile:Boolean = false;
      
      private static var _version:int;
      
      private static var _files:Object;
      
      private static var _saveTimer:Timer;
      
      private static var _so:SharedObject;
      
      private static var _changed:Boolean;
      
      private static var _save:Array;
      
      private static const READ_ERROR_ID:int = 2030;
      
      public static var eventDispatcher:EventDispatcher = new EventDispatcher();
      
      public static var ReadShareError:Boolean = false;
      
      private static const _reg1:RegExp = /http:\/\/[\w|.|:]+\//i;
      
      private static const _reg2:RegExp = /[:|.|\/]/g;
      
      private static var _isSaving:Boolean = false;
      
      private static var _shape:Shape = new Shape();
      
      private static var _retryCount:int = 0;
       
      
      public function LoaderSavingManager()
      {
         super();
      }
      
      public static function get Version() : int
      {
         return _version;
      }
      
      public static function set Version(param1:int) : void
      {
         _version = param1;
      }
      
      public static function set cacheAble(param1:Boolean) : void
      {
         _cacheFile = param1;
      }
      
      public static function get cacheAble() : Boolean
      {
         return _cacheFile;
      }
      
      public static function setup() : void
      {
         _cacheFile = false;
         _save = [];
         loadFilesInLocal();
      }
      
      public static function applyUpdate(param1:int, param2:int, param3:Array) : void
      {
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc9_:* = null;
         if(param2 <= param1)
         {
            return;
         }
         if(_version < param2)
         {
            if(_version < param1)
            {
               _files = {};
               _so.data["data"] = {};
               LoadResourceManager.Instance.addDeleteRequest("*");
            }
            else
            {
               _loc7_ = [];
               var _loc11_:int = 0;
               var _loc10_:* = param3;
               for each(var _loc6_ in param3)
               {
                  _loc5_ = getPath(_loc6_);
                  _loc5_ = _loc5_.replace("*","\\w*");
                  _loc7_.push(new RegExp(_loc5_));
                  LoadResourceManager.Instance.addDeleteRequest(_loc6_);
               }
               _loc9_ = [];
               var _loc13_:int = 0;
               var _loc12_:* = _files;
               for(var _loc4_ in _files)
               {
                  _loc4_ = _loc4_.toLocaleLowerCase();
                  if(hasUpdate(_loc4_,_loc7_))
                  {
                     _loc9_.push(_loc4_);
                  }
               }
               var _loc15_:int = 0;
               var _loc14_:* = _loc9_;
               for each(var _loc8_ in _loc9_)
               {
                  delete _files[_loc8_];
               }
            }
            _version = param2;
            _files["version"] = param2;
            _changed = true;
         }
      }
      
      public static function clearFiles(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         if(_files)
         {
            _loc4_ = [];
            _loc3_ = getPath(param1);
            _loc3_ = _loc3_.replace("*","\\w*");
            _loc4_.push(new RegExp(_loc3_));
            _loc6_ = [];
            var _loc8_:int = 0;
            var _loc7_:* = _files;
            for(var _loc2_ in _files)
            {
               _loc2_ = _loc2_.toLocaleLowerCase();
               if(hasUpdate(_loc2_,_loc4_))
               {
                  _loc6_.push(_loc2_);
               }
            }
            var _loc10_:int = 0;
            var _loc9_:* = _loc6_;
            for each(var _loc5_ in _loc6_)
            {
               delete _files[_loc5_];
            }
            try
            {
               if(_cacheFile)
               {
                  _so.flush(20971520);
               }
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      public static function loadFilesInLocal() : void
      {
         try
         {
            _so = SharedObject.getLocal("7road/files","/");
            _so.addEventListener("netStatus",__netStatus);
            _files = _so.data["data"];
            if(_files == null)
            {
               _files = {};
               _so.data["data"] = _files;
               _version = -1;
               _files["version"] = -1;
               _cacheFile = false;
            }
            else
            {
               _version = _files["version"];
               _cacheFile = true;
            }
            return;
         }
         catch(e:Error)
         {
            if(e.errorID == 2030)
            {
               resetErrorVersion();
            }
            return;
         }
      }
      
      public static function resetErrorVersion() : void
      {
         _version = Math.random() * -777777;
         ReadShareError = true;
      }
      
      private static function getPath(param1:String) : String
      {
         param1 = LoaderNameFilter.getRealFilePath(param1);
         var _loc2_:int = param1.indexOf("?");
         if(_loc2_ != -1)
         {
            param1 = param1.substring(0,_loc2_);
         }
         param1 = param1.replace(_reg1,"");
         return param1.replace(_reg2,"-").toLocaleLowerCase();
      }
      
      public static function saveFilesToLocal() : void
      {
         try
         {
            if(_files && _changed && _cacheFile && !_isSaving)
            {
               _isSaving = true;
               _shape.addEventListener("enterFrame",save);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private static function save(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         try
         {
            _loc4_ = _so.flush(20971520);
            if(_loc4_ != "pending")
            {
               _loc2_ = getTimer();
               if(_save.length > 0)
               {
                  _loc5_ = _save[0];
                  _loc3_ = SharedObject.getLocal(_loc5_.p,"/");
                  _loc3_.data["data"] = _loc5_.d;
                  _loc3_.flush();
                  _files[_loc5_.p] = true;
                  _so.flush();
                  _save.shift();
                  trace("save local data spend:",getTimer() - _loc2_,"  left:",_save.length,"  file:",_loc5_.p);
               }
               if(_save.length == 0)
               {
                  _shape.removeEventListener("enterFrame",save);
                  _changed = false;
                  _isSaving = false;
               }
            }
            return;
         }
         catch(e:Error)
         {
            _shape.removeEventListener("enterFrame",save);
            return;
         }
      }
      
      private static function hasUpdate(param1:String, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = param2;
         for each(var _loc3_ in param2)
         {
            if(param1.match(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function loadCachedFile(param1:String, param2:Boolean) : ByteArray
      {
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(_files)
         {
            _loc6_ = getPath(param1);
            _loc4_ = getTimer();
            _loc3_ = findInSave(_loc6_);
            if(_loc3_ == null && _files[_loc6_])
            {
               _loc5_ = SharedObject.getLocal(_loc6_,"/");
               _loc3_ = ByteArray(_loc5_.data["data"]);
            }
            if(_loc3_)
            {
               trace("get{local:",getTimer() - _loc4_,"ms}",param1);
               return _loc3_;
            }
         }
         trace("get{network}",param1);
         return null;
      }
      
      private static function findInSave(param1:String) : ByteArray
      {
         var _loc4_:int = 0;
         var _loc3_:* = _save;
         for each(var _loc2_ in _save)
         {
            if(_loc2_.p == param1)
            {
               return ByteArray(_loc2_.d);
            }
         }
         return null;
      }
      
      public static function cacheFile(param1:String, param2:ByteArray, param3:Boolean) : void
      {
         var _loc4_:* = null;
         if(!LoadResourceManager.Instance.isMicroClient && _files)
         {
            _loc4_ = getPath(param1);
            _save.push({
               "p":_loc4_,
               "d":param2
            });
            _changed = true;
         }
      }
      
      private static function __netStatus(param1:NetStatusEvent) : void
      {
         trace(param1.info.code);
         var _loc2_:* = param1.info.code;
         if("SharedObject.Flush.Failed" !== _loc2_)
         {
            _retryCount = 0;
         }
         else if(_retryCount < 1)
         {
            _so.flush(20971520);
            _retryCount = Number(_retryCount) + 1;
         }
         else
         {
            cacheAble = false;
         }
      }
      
      public static function updateList(param1:XMLList) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            parseUpdate(_loc2_);
         }
         LoadResourceManager.Instance.addEventListener("delete",__deleteComplete);
         LoadResourceManager.Instance.startDelete();
      }
      
      protected static function __deleteComplete(param1:Event) : void
      {
         eventDispatcher.dispatchEvent(new Event("complete"));
      }
      
      public static function parseUpdate(param1:XML) : void
      {
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         try
         {
            _loc6_ = param1..version;
            var _loc13_:int = 0;
            var _loc12_:* = _loc6_;
            for each(var _loc3_ in _loc6_)
            {
               _loc2_ = _loc3_.@to;
               if(_version <= _loc2_)
               {
                  _loc8_ = _loc3_.@from;
                  _loc4_ = _loc3_..file;
                  _loc5_ = [];
                  var _loc11_:int = 0;
                  var _loc10_:* = _loc4_;
                  for each(var _loc7_ in _loc4_)
                  {
                     _loc5_.push(String(_loc7_.@value));
                  }
                  applyUpdate(_loc8_,_loc2_,_loc5_);
               }
            }
         }
         catch(e:Error)
         {
            _version = -1;
            if(_so)
            {
               _files = {};
               _so.data["data"] = {};
            }
            LoadResourceManager.Instance.addDeleteRequest("*");
            _changed = true;
         }
         saveFilesToLocal();
      }
      
      public static function get hasFileToSave() : Boolean
      {
         return _cacheFile && _changed;
      }
      
      public static function clearAllCache() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(LoadResourceManager.Instance.isMicroClient)
         {
            LoadResourceManager.Instance.deleteResource("*");
         }
         if(!_so)
         {
            return;
         }
         var _loc1_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _files;
         for(var _loc4_ in _files)
         {
            if(_loc4_ != "version")
            {
               _loc4_ = _loc4_.toLocaleLowerCase();
               _loc1_.push(_loc4_);
               delete _files[_loc4_];
            }
         }
         while(true)
         {
            _loc3_ = _loc1_.pop();
            if(!_loc1_.pop())
            {
               break;
            }
            _loc2_ = SharedObject.getLocal(_loc3_,"/");
            _loc2_.data["data"] = {};
            _loc2_.flush();
         }
         _version = -1;
         _files = {};
         _so.data["data"] = {};
         _so["version"] = -1;
         _so.flush();
      }
   }
}
