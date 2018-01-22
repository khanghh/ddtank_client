package com.pickgliss.loader
{
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class LoaderManager extends EventDispatcher
   {
      
      public static const ALLOW_MUTI_LOAD_COUNT:int = 8;
      
      public static const LOAD_FROM_LOCAL:int = 2;
      
      public static const LOAD_FROM_WEB:int = 1;
      
      public static const LOAD_NOT_SET:int = 0;
      
      public static var NEGLECT_URL:String = "";
      
      private static var _instance:LoaderManager;
       
      
      private var _loadMode:int = 0;
      
      private var _loaderIdCounter:int = 0;
      
      private var _loaderSaveByID:Dictionary;
      
      private var _loaderSaveByPath:Dictionary;
      
      private var _loadingLoaderList:Vector.<BaseLoader>;
      
      private var _waitingLoaderList:Vector.<BaseLoader>;
      
      public function LoaderManager()
      {
         super();
         _loaderSaveByID = new Dictionary();
         _loaderSaveByPath = new Dictionary();
         _loadingLoaderList = new Vector.<BaseLoader>();
         _waitingLoaderList = new Vector.<BaseLoader>();
         initLoadMode();
      }
      
      public static function get Instance() : LoaderManager
      {
         if(_instance == null)
         {
            _instance = new LoaderManager();
         }
         return _instance;
      }
      
      public function creatLoaderByType(param1:String, param2:int, param3:URLVariables, param4:String, param5:ApplicationDomain) : BaseLoader
      {
         var _loc6_:* = null;
         switch(int(param2))
         {
            case 0:
               _loc6_ = new BitmapLoader(getNextLoaderID(),param1);
               break;
            case 1:
               _loc6_ = new DisplayLoader(getNextLoaderID(),param1);
               break;
            case 2:
               _loc6_ = new TextLoader(getNextLoaderID(),param1,param3);
               break;
            case 3:
               _loc6_ = new BaseLoader(getNextLoaderID(),param1);
               break;
            case 4:
               _loc6_ = new ModuleLoader(getNextLoaderID(),param1,param5);
               break;
            case 5:
               _loc6_ = new CompressTextLoader(getNextLoaderID(),param1,param3);
               break;
            case 6:
               _loc6_ = new RequestLoader(getNextLoaderID(),param1,param3,param4);
               break;
            case 7:
               _loc6_ = new CompressRequestLoader(getNextLoaderID(),param1,param3,param4);
               break;
            case 8:
               _loc6_ = new MornUIDataLoader(getNextLoaderID(),param1,param3,param4);
               break;
            case 9:
               _loc6_ = new CodeModuleLoader(getNextLoaderID(),param1,param5);
               break;
            case 10:
               _loc6_ = new BonesLoader(getNextLoaderID(),param1);
         }
         return _loc6_;
      }
      
      public function getLoadMode() : int
      {
         return _loadMode;
      }
      
      public function creatLoader(param1:String, param2:int, param3:URLVariables = null, param4:String = "GET", param5:ApplicationDomain = null) : *
      {
         var _loc6_:* = null;
         param1 = LoaderNameFilter.getLoadFilePath(param1);
         var _loc7_:String = fixedVariablesURL(param1,param2,param3);
         _loc6_ = getLoaderByURL(_loc7_,param3);
         if(_loc6_ == null)
         {
            _loc6_ = creatLoaderByType(_loc7_,param2,param3,param4,param5);
         }
         else
         {
            _loc6_.domain = param5;
         }
         if(param2 != 6 && param2 != 7 && param2 != 0)
         {
            _loaderSaveByID[_loc6_.id] = _loc6_;
            _loaderSaveByPath[_loc6_.url] = _loc6_;
         }
         return _loc6_;
      }
      
      public function creatLoaderOriginal(param1:String, param2:int, param3:URLVariables = null, param4:String = "GET") : *
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         _loc6_ = _loc6_(param1,param2,param3);
         _loc5_ = getLoaderByURL(_loc6_,param3);
         if(_loc5_ == null)
         {
            _loc5_ = creatLoaderByType(_loc6_,param2,param3,param4,null);
         }
         if(param2 != 6 && param2 != 7 && param2 != 0)
         {
            _loaderSaveByID[_loc5_.id] = _loc5_;
            _loaderSaveByPath[_loc5_.url] = _loc5_;
         }
         return _loc5_;
      }
      
      public function creatAndStartLoad(param1:String, param2:int, param3:URLVariables = null) : BaseLoader
      {
         var _loc4_:BaseLoader = creatLoader(param1,param2,param3);
         startLoad(_loc4_);
         return _loc4_;
      }
      
      public function getLoaderByID(param1:int) : BaseLoader
      {
         return _loaderSaveByID[param1];
      }
      
      public function clearLoader() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _loaderSaveByID;
         for(var _loc1_ in _loaderSaveByID)
         {
            _loaderSaveByID[_loc1_].unload();
         }
      }
      
      public function getLoaderByURL(param1:String, param2:URLVariables) : BaseLoader
      {
         var _loc3_:BaseLoader = _loaderSaveByPath[param1];
         return _loc3_;
      }
      
      public function getNextLoaderID() : int
      {
         _loaderIdCounter = Number(_loaderIdCounter) + 1;
         return Number(_loaderIdCounter);
      }
      
      public function saveFileToLocal(param1:BaseLoader) : void
      {
      }
      
      public function startLoad(param1:BaseLoader, param2:Boolean = false) : void
      {
         if(param1)
         {
            param1.addEventListener("complete",__onLoadFinish);
         }
         if(param1.isComplete)
         {
            param1.dispatchEvent(new LoaderEvent("complete",param1));
            return;
         }
         var _loc3_:ByteArray = LoaderSavingManager.loadCachedFile(param1.url,true);
         if(_loc3_)
         {
            param1.loadFromBytes(_loc3_);
            return;
         }
         if(!LoadResourceManager.Instance.isMicroClient && (_loadingLoaderList.length >= 8 && !param2 || getLoadMode() == 0))
         {
            if(_waitingLoaderList.indexOf(param1) == -1)
            {
               _waitingLoaderList.push(param1);
            }
         }
         else
         {
            if(_loadingLoaderList.indexOf(param1) == -1)
            {
               _loadingLoaderList.push(param1);
            }
            if(getLoadMode() == 1 || param1.type == 2)
            {
               param1.loadFromWeb();
            }
            else if(getLoadMode() == 2)
            {
               param1.getFilePathFromExternal();
            }
         }
      }
      
      private function __onLoadFinish(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onLoadFinish);
         _loadingLoaderList.splice(_loadingLoaderList.indexOf(param1.loader),1);
         tryLoadWaiting();
      }
      
      private function initLoadMode() : void
      {
         if(!ExternalInterface.available)
         {
            setFlashLoadWeb();
            return;
         }
         ExternalInterface.addCallback("SetFlashLoadExternal",setFlashLoadExternal);
         return;
         §§push(setTimeout(setFlashLoadWeb,200));
      }
      
      private function onExternalLoadStop(param1:int, param2:String) : void
      {
         var _loc3_:BaseLoader = getLoaderByID(param1);
         _loc3_.loadFromExternal(param2);
      }
      
      private function setFlashLoadExternal() : void
      {
         _loadMode = 2;
         ExternalInterface.addCallback("ExternalLoadStop",onExternalLoadStop);
         tryLoadWaiting();
      }
      
      public function setFlashLoadWeb() : void
      {
         _loadMode = 1;
         tryLoadWaiting();
      }
      
      private function tryLoadWaiting() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _waitingLoaderList.length)
         {
            if(_loadingLoaderList.length < 8)
            {
               _loc1_ = _waitingLoaderList.shift();
               startLoad(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function setup(param1:LoaderContext, param2:String) : void
      {
         DisplayLoader.Context = param1;
         TextLoader.TextLoaderKey = param2;
         LoaderSavingManager.setup();
      }
      
      public function fixedVariablesURL(param1:String, param2:int, param3:URLVariables) : String
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param2 != 6 && param2 != 7)
         {
            _loc5_ = "";
            if(param3 == null)
            {
               param3 = new URLVariables();
            }
            if(param2 == 3 || param2 == 1 || param2 == 0 || param2 == 8 || param2 == 10)
            {
               if(!param3["lv"])
               {
                  param3["lv"] = LoaderSavingManager.Version;
               }
            }
            else if(param2 == 5 || param2 == 2)
            {
               if(!param3["rnd"])
               {
                  param3["rnd"] = TextLoader.TextLoaderKey;
               }
            }
            else if(param2 == 4 || param2 == 9)
            {
               if(!param3["lv"])
               {
                  param3["lv"] = LoaderSavingManager.Version;
               }
               if(!param3["rnd"])
               {
                  param3["rnd"] = TextLoader.TextLoaderKey;
               }
            }
            _loc6_ = 0;
            var _loc8_:int = 0;
            var _loc7_:* = param3;
            for(var _loc4_ in param3)
            {
               if(_loc6_ >= 1)
               {
                  _loc5_ = _loc5_ + ("&" + _loc4_ + "=" + param3[_loc4_]);
               }
               else
               {
                  _loc5_ = _loc5_ + (_loc4_ + "=" + param3[_loc4_]);
               }
               _loc6_++;
            }
            return param1 + "?" + _loc5_;
         }
         return param1;
      }
      
      public function fixedNewVariablesURL(param1:String, param2:int, param3:URLVariables, param4:int) : String
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(param2 != 6 && param2 != 7)
         {
            _loc6_ = "";
            if(param3 == null)
            {
               param3 = new URLVariables();
            }
            if(param2 == 3 || param2 == 1 || param2 == 0 || param2 == 4 || param2 == 8 || param2 == 9)
            {
               param3["lv"] = LoaderSavingManager.Version + param4;
            }
            else if(param2 == 5 || param2 == 2)
            {
               param3["rnd"] = TextLoader.TextLoaderKey + param4.toString();
            }
            _loc7_ = 0;
            var _loc9_:int = 0;
            var _loc8_:* = param3;
            for(var _loc5_ in param3)
            {
               if(_loc7_ >= 1)
               {
                  _loc6_ = _loc6_ + ("&" + _loc5_ + "=" + param3[_loc5_]);
               }
               else
               {
                  _loc6_ = _loc6_ + (_loc5_ + "=" + param3[_loc5_]);
               }
               _loc7_++;
            }
            return param1 + "?" + _loc6_;
         }
         return param1;
      }
   }
}
