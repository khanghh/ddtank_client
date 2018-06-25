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
      
      public function creatLoaderByType(filePath:String, type:int, args:URLVariables, requestMethod:String, domain:ApplicationDomain) : BaseLoader
      {
         var loader:* = null;
         switch(int(type))
         {
            case 0:
               loader = new BitmapLoader(getNextLoaderID(),filePath);
               break;
            case 1:
               loader = new DisplayLoader(getNextLoaderID(),filePath);
               break;
            case 2:
               loader = new TextLoader(getNextLoaderID(),filePath,args);
               break;
            case 3:
               loader = new BaseLoader(getNextLoaderID(),filePath);
               break;
            case 4:
               loader = new ModuleLoader(getNextLoaderID(),filePath,domain);
               break;
            case 5:
               loader = new CompressTextLoader(getNextLoaderID(),filePath,args);
               break;
            case 6:
               loader = new RequestLoader(getNextLoaderID(),filePath,args,requestMethod);
               break;
            case 7:
               loader = new CompressRequestLoader(getNextLoaderID(),filePath,args,requestMethod);
               break;
            case 8:
               loader = new MornUIDataLoader(getNextLoaderID(),filePath,args,requestMethod);
               break;
            case 9:
               loader = new CodeModuleLoader(getNextLoaderID(),filePath,domain);
               break;
            case 10:
               loader = new BonesLoader(getNextLoaderID(),filePath);
         }
         return loader;
      }
      
      public function getLoadMode() : int
      {
         return _loadMode;
      }
      
      public function creatLoader(filePath:String, type:int, args:URLVariables = null, requestMethod:String = "GET", domain:ApplicationDomain = null) : *
      {
         var loader:* = null;
         filePath = LoaderNameFilter.getLoadFilePath(filePath);
         var fixedVariablesURLString:String = fixedVariablesURL(filePath,type,args);
         loader = getLoaderByURL(fixedVariablesURLString,args);
         if(loader == null)
         {
            loader = creatLoaderByType(fixedVariablesURLString,type,args,requestMethod,domain);
         }
         else
         {
            loader.domain = domain;
         }
         if(type != 6 && type != 7 && type != 0)
         {
            _loaderSaveByID[loader.id] = loader;
            _loaderSaveByPath[loader.url] = loader;
         }
         return loader;
      }
      
      public function creatLoaderOriginal(filePath:String, type:int, args:URLVariables = null, requestMethod:String = "GET") : *
      {
         var loader:* = null;
         var fixedVariablesURL:* = null;
         fixedVariablesURL = fixedVariablesURL(filePath,type,args);
         loader = getLoaderByURL(fixedVariablesURL,args);
         if(loader == null)
         {
            loader = creatLoaderByType(fixedVariablesURL,type,args,requestMethod,null);
         }
         if(type != 6 && type != 7 && type != 0)
         {
            _loaderSaveByID[loader.id] = loader;
            _loaderSaveByPath[loader.url] = loader;
         }
         return loader;
      }
      
      public function creatAndStartLoad(filePath:String, type:int, args:URLVariables = null) : BaseLoader
      {
         var loader:BaseLoader = creatLoader(filePath,type,args);
         startLoad(loader);
         return loader;
      }
      
      public function getLoaderByID(id:int) : BaseLoader
      {
         return _loaderSaveByID[id];
      }
      
      public function clearLoader() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _loaderSaveByID;
         for(var id in _loaderSaveByID)
         {
            _loaderSaveByID[id].unload();
         }
      }
      
      public function getLoaderByURL(url:String, args:URLVariables) : BaseLoader
      {
         var loader:BaseLoader = _loaderSaveByPath[url];
         return loader;
      }
      
      public function getNextLoaderID() : int
      {
         _loaderIdCounter = Number(_loaderIdCounter) + 1;
         return Number(_loaderIdCounter);
      }
      
      public function saveFileToLocal(loader:BaseLoader) : void
      {
      }
      
      public function startLoad(loader:BaseLoader, loadImp:Boolean = false) : void
      {
         if(loader)
         {
            loader.addEventListener("complete",__onLoadFinish);
         }
         if(loader.isComplete)
         {
            loader.dispatchEvent(new LoaderEvent("complete",loader));
            return;
         }
         var ba:ByteArray = LoaderSavingManager.loadCachedFile(loader.url,true);
         if(ba)
         {
            loader.loadFromBytes(ba);
            return;
         }
         if(!LoadResourceManager.Instance.isMicroClient && (_loadingLoaderList.length >= 8 && !loadImp || getLoadMode() == 0))
         {
            if(_waitingLoaderList.indexOf(loader) == -1)
            {
               _waitingLoaderList.push(loader);
            }
         }
         else
         {
            if(_loadingLoaderList.indexOf(loader) == -1)
            {
               _loadingLoaderList.push(loader);
            }
            if(getLoadMode() == 1 || loader.type == 2)
            {
               loader.loadFromWeb();
            }
            else if(getLoadMode() == 2)
            {
               loader.getFilePathFromExternal();
            }
         }
      }
      
      private function __onLoadFinish(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__onLoadFinish);
         _loadingLoaderList.splice(_loadingLoaderList.indexOf(event.loader),1);
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
      
      private function onExternalLoadStop(id:int, path:String) : void
      {
         var loader:BaseLoader = getLoaderByID(id);
         loader.loadFromExternal(path);
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
         var i:int = 0;
         var loader:* = null;
         for(i = 0; i < _waitingLoaderList.length; )
         {
            if(_loadingLoaderList.length < 8)
            {
               loader = _waitingLoaderList.shift();
               startLoad(loader);
            }
            i++;
         }
      }
      
      public function setup(context:LoaderContext, textLoaderKey:String) : void
      {
         DisplayLoader.Context = context;
         TextLoader.TextLoaderKey = textLoaderKey;
         LoaderSavingManager.setup();
      }
      
      public function fixedVariablesURL(path:String, type:int, variables:URLVariables) : String
      {
         var variableString:* = null;
         var i:int = 0;
         if(type != 6 && type != 7)
         {
            variableString = "";
            if(variables == null)
            {
               variables = new URLVariables();
            }
            if(type == 3 || type == 1 || type == 0 || type == 8 || type == 10)
            {
               if(!variables["lv"])
               {
                  variables["lv"] = LoaderSavingManager.Version;
               }
            }
            else if(type == 5 || type == 2)
            {
               if(!variables["rnd"])
               {
                  variables["rnd"] = TextLoader.TextLoaderKey;
               }
            }
            else if(type == 4 || type == 9)
            {
               if(!variables["lv"])
               {
                  variables["lv"] = LoaderSavingManager.Version;
               }
               if(!variables["rnd"])
               {
                  variables["rnd"] = TextLoader.TextLoaderKey;
               }
            }
            i = 0;
            var _loc8_:int = 0;
            var _loc7_:* = variables;
            for(var p in variables)
            {
               if(i >= 1)
               {
                  variableString = variableString + ("&" + p + "=" + variables[p]);
               }
               else
               {
                  variableString = variableString + (p + "=" + variables[p]);
               }
               i++;
            }
            return path + "?" + variableString;
         }
         return path;
      }
      
      public function fixedNewVariablesURL(path:String, type:int, variables:URLVariables, argsCount:int) : String
      {
         var variableString:* = null;
         var i:int = 0;
         if(type != 6 && type != 7)
         {
            variableString = "";
            if(variables == null)
            {
               variables = new URLVariables();
            }
            if(type == 3 || type == 1 || type == 0 || type == 4 || type == 8 || type == 9)
            {
               variables["lv"] = LoaderSavingManager.Version + argsCount;
            }
            else if(type == 5 || type == 2)
            {
               variables["rnd"] = TextLoader.TextLoaderKey + argsCount.toString();
            }
            i = 0;
            var _loc9_:int = 0;
            var _loc8_:* = variables;
            for(var p in variables)
            {
               if(i >= 1)
               {
                  variableString = variableString + ("&" + p + "=" + variables[p]);
               }
               else
               {
                  variableString = variableString + (p + "=" + variables[p]);
               }
               i++;
            }
            return path + "?" + variableString;
         }
         return path;
      }
   }
}
