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
      
      public static function set Version(value:int) : void
      {
         _version = value;
      }
      
      public static function set cacheAble(value:Boolean) : void
      {
         _cacheFile = value;
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
      
      public static function applyUpdate(fromv:int, tov:int, updatelist:Array) : void
      {
         var updated:* = null;
         var t:* = null;
         var temp:* = null;
         if(tov <= fromv)
         {
            return;
         }
         if(_version < tov)
         {
            if(_version < fromv)
            {
               _files = {};
               _so.data["data"] = {};
               LoadResourceManager.Instance.addDeleteRequest("*");
            }
            else
            {
               updated = [];
               var _loc11_:int = 0;
               var _loc10_:* = updatelist;
               for each(var s in updatelist)
               {
                  t = getPath(s);
                  t = t.replace("*","\\w*");
                  updated.push(new RegExp(t));
                  LoadResourceManager.Instance.addDeleteRequest(s);
               }
               temp = [];
               var _loc13_:int = 0;
               var _loc12_:* = _files;
               for(var f in _files)
               {
                  f = f.toLocaleLowerCase();
                  if(hasUpdate(f,updated))
                  {
                     temp.push(f);
                  }
               }
               var _loc15_:int = 0;
               var _loc14_:* = temp;
               for each(var n in temp)
               {
                  delete _files[n];
               }
            }
            _version = tov;
            _files["version"] = tov;
            _changed = true;
         }
      }
      
      public static function clearFiles(filter:String) : void
      {
         var updated:* = null;
         var t:* = null;
         var temp:* = null;
         if(_files)
         {
            updated = [];
            t = getPath(filter);
            t = t.replace("*","\\w*");
            updated.push(new RegExp(t));
            temp = [];
            var _loc8_:int = 0;
            var _loc7_:* = _files;
            for(var f in _files)
            {
               f = f.toLocaleLowerCase();
               if(hasUpdate(f,updated))
               {
                  temp.push(f);
               }
            }
            var _loc10_:int = 0;
            var _loc9_:* = temp;
            for each(var n in temp)
            {
               delete _files[n];
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
      
      private static function getPath(path:String) : String
      {
         path = LoaderNameFilter.getRealFilePath(path);
         var index:int = path.indexOf("?");
         if(index != -1)
         {
            path = path.substring(0,index);
         }
         path = path.replace(_reg1,"");
         return path.replace(_reg2,"-").toLocaleLowerCase();
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
      
      private static function save(event:Event) : void
      {
         var state:* = null;
         var tick:int = 0;
         var obj:* = null;
         var so:* = null;
         try
         {
            state = _so.flush(20971520);
            if(state != "pending")
            {
               tick = getTimer();
               if(_save.length > 0)
               {
                  obj = _save[0];
                  so = SharedObject.getLocal(obj.p,"/");
                  so.data["data"] = obj.d;
                  so.flush();
                  _files[obj.p] = true;
                  _so.flush();
                  _save.shift();
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
      
      private static function hasUpdate(path:String, updateList:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = updateList;
         for each(var s in updateList)
         {
            if(path.match(s))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function loadCachedFile(path:String, cacheInMem:Boolean) : ByteArray
      {
         var p:* = null;
         var tick:int = 0;
         var f:* = null;
         var so:* = null;
         if(_files)
         {
            p = getPath(path);
            tick = getTimer();
            f = findInSave(p);
            if(f == null && _files[p])
            {
               so = SharedObject.getLocal(p,"/");
               f = ByteArray(so.data["data"]);
            }
            if(f)
            {
               trace("get{local:",getTimer() - tick,"ms}",path);
               return f;
            }
         }
         trace("get{network}",path);
         return null;
      }
      
      private static function findInSave(path:String) : ByteArray
      {
         var _loc4_:int = 0;
         var _loc3_:* = _save;
         for each(var cache in _save)
         {
            if(cache.p == path)
            {
               return ByteArray(cache.d);
            }
         }
         return null;
      }
      
      public static function cacheFile(path:String, data:ByteArray, cacheInMem:Boolean) : void
      {
         var p:* = null;
         if(!LoadResourceManager.Instance.isMicroClient && _files)
         {
            p = getPath(path);
            _save.push({
               "p":p,
               "d":data
            });
            _changed = true;
         }
      }
      
      private static function __netStatus(event:NetStatusEvent) : void
      {
         trace(event.info.code);
         var _loc2_:* = event.info.code;
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
      
      public static function updateList(list:XMLList) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(var node in list)
         {
            parseUpdate(node);
         }
         LoadResourceManager.Instance.addEventListener("delete",__deleteComplete);
         LoadResourceManager.Instance.startDelete();
      }
      
      protected static function __deleteComplete(event:Event) : void
      {
         eventDispatcher.dispatchEvent(new Event("complete"));
      }
      
      public static function parseUpdate(config:XML) : void
      {
         var vs:* = null;
         var tov:int = 0;
         var fromv:int = 0;
         var fs:* = null;
         var updatelist:* = null;
         try
         {
            vs = config..version;
            var _loc13_:int = 0;
            var _loc12_:* = vs;
            for each(var unode in vs)
            {
               tov = unode.@to;
               if(_version <= tov)
               {
                  fromv = unode.@from;
                  fs = unode..file;
                  updatelist = [];
                  var _loc11_:int = 0;
                  var _loc10_:* = fs;
                  for each(var fn in fs)
                  {
                     updatelist.push(String(fn.@value));
                  }
                  applyUpdate(fromv,tov,updatelist);
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
         var file:* = null;
         var fileSO:* = null;
         if(LoadResourceManager.Instance.isMicroClient)
         {
            LoadResourceManager.Instance.deleteResource("*");
         }
         if(!_so)
         {
            return;
         }
         var fileList:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _files;
         for(var a in _files)
         {
            if(a != "version")
            {
               a = a.toLocaleLowerCase();
               fileList.push(a);
               delete _files[a];
            }
         }
         while(true)
         {
            file = fileList.pop();
            if(!fileList.pop())
            {
               break;
            }
            fileSO = SharedObject.getLocal(file,"/");
            fileSO.data["data"] = {};
            fileSO.flush();
         }
         _version = -1;
         _files = {};
         _so.data["data"] = {};
         _so["version"] = -1;
         _so.flush();
      }
   }
}
