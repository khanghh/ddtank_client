package com.pickgliss.loader
{
   import com.pickgliss.events.LoaderResourceEvent;
   import com.pickgliss.events.UIModuleEvent;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   [Event(name="init complete",type="com.pickgliss.events.LoaderResourceEvent")]
   [Event(name="complete",type="com.pickgliss.events.LoaderResourceEvent")]
   [Event(name="delete",type="com.pickgliss.events.LoaderResourceEvent")]
   [Event(name="loadError",type="com.pickgliss.events.LoaderResourceEvent")]
   [Event(name="progress",type="com.pickgliss.events.LoaderResourceEvent")]
   public class LoadResourceManager extends EventDispatcher
   {
      
      private static var _instance:LoadResourceManager;
       
      
      private var _infoSite:String = "";
      
      private var _loadingUrl:String = "";
      
      private var _clientType:int;
      
      private var _loadDic:Dictionary;
      
      private var _loadUrlDic:Dictionary;
      
      private var _deleteList:Vector.<String>;
      
      private var _currentDeletePath:String;
      
      private var _isLoading:Boolean;
      
      private var _progress:Number;
      
      public function LoadResourceManager(single:Singleton)
      {
         super();
         if(!single)
         {
            throw Error("单例无法实例化");
         }
      }
      
      public static function get Instance() : LoadResourceManager
      {
         return _instance || new LoadResourceManager(new Singleton());
      }
      
      public function init(infoSite:String = "") : void
      {
         _infoSite = infoSite;
         var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         LoaderManager.Instance.setup(loaderContext,String(Math.random()));
         addMicroClientEvent();
         LoadInterfaceManager.initAppInterface();
      }
      
      public function addMicroClientEvent() : void
      {
         LoadInterfaceManager.eventDispatcher.addEventListener("checkComplete",__checkComplete);
         LoadInterfaceManager.eventDispatcher.addEventListener("deleteComplete",__deleteComplete);
         LoadInterfaceManager.eventDispatcher.addEventListener("flashGotoAndPlay",__flashGotoAndPlay);
      }
      
      public function setLoginType(type:Number, loadingUrl:String = "", version:String = "-1") : void
      {
         _clientType = int(type);
         _loadingUrl = loadingUrl;
         LoaderSavingManager.Version = int(version);
      }
      
      public function setup(context:LoaderContext, textLoaderKey:String) : void
      {
         _loadDic = new Dictionary();
         _loadUrlDic = new Dictionary();
         _deleteList = new Vector.<String>();
      }
      
      public function createLoader(filePath:String, type:int, args:URLVariables = null, requestMethod:String = "GET", domain:ApplicationDomain = null, useClient:Boolean = true, isIgnoreError:Boolean = false) : *
      {
         return createOriginLoader(filePath,_infoSite,type,args,requestMethod,domain,useClient,isIgnoreError);
      }
      
      public function createOriginLoader(filePath:String, rootSite:String, type:int, args:URLVariables = null, requestMethod:String = "GET", domain:ApplicationDomain = null, useClient:Boolean = false, isIgnoreError:Boolean = false) : *
      {
         var loader:* = null;
         var index:int = 0;
         var path:* = null;
         if(useClient && _clientType == 1 && [2,5,6,7].indexOf(type) == -1)
         {
            filePath = fixedVariablesURL(filePath.toLowerCase(),type,args);
            index = rootSite.length;
            if(filePath.indexOf(rootSite) == -1)
            {
               LoadInterfaceManager.traceMsg("filePath = " + filePath + "路径有问题");
            }
            path = filePath.substring(index,filePath.length);
            loader = LoaderManager.Instance.creatLoaderByType(path,type,args,requestMethod,domain);
            _loadDic[loader.id] = loader;
            _loadUrlDic[loader.id] = filePath;
         }
         else
         {
            loader = LoaderManager.Instance.creatLoader(filePath,type,args,requestMethod,domain);
         }
         return loader;
      }
      
      private function __onLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__onLoadComplete);
         event.loader.removeEventListener("loadError",__onLoadError);
      }
      
      public function __onLoadError(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__onLoadComplete);
         event.loader.removeEventListener("loadError",__onLoadError);
         var resEvent:LoaderResourceEvent = new LoaderResourceEvent("loadError");
         resEvent.data = event.loader;
         dispatchEvent(resEvent);
      }
      
      public function creatAndStartLoad(filePath:String, type:int, args:URLVariables = null) : BaseLoader
      {
         var loader:BaseLoader = createLoader(filePath,type,args);
         startLoad(loader);
         return loader;
      }
      
      public function startLoad(loader:BaseLoader, loadImp:Boolean = false, useClient:Boolean = true) : void
      {
         startLoadFromLoadingUrl(loader,_infoSite,loadImp,useClient);
      }
      
      public function startLoadFromLoadingUrl(loader:BaseLoader, rootSite:String, loadImp:Boolean = false, useClient:Boolean = true) : void
      {
         var filePath:String = loader.url;
         filePath = filePath.replace(/\?.*/,"");
         if(useClient && _clientType == 1 && [2,5,6,7].indexOf(loader.type) == -1)
         {
            LoadInterfaceManager.checkResource(loader.id,rootSite,filePath,loadImp);
         }
         else
         {
            beginLoad(loader,loadImp);
         }
      }
      
      private function beginLoad(loader:BaseLoader, loadImp:Boolean = false) : void
      {
         LoaderManager.Instance.startLoad(loader,loadImp);
      }
      
      public function addDeleteRequest(filePath:String) : void
      {
         if(!_deleteList)
         {
            _deleteList = new Vector.<String>();
         }
         _deleteList.push(filePath);
      }
      
      public function startDelete() : void
      {
         if(_clientType != 1)
         {
            if(_deleteList)
            {
               _deleteList.length = 0;
            }
         }
         deleteNext();
      }
      
      private function deleteNext() : void
      {
         var evt:* = null;
         if(_deleteList)
         {
            if(_deleteList.length > 0)
            {
               _currentDeletePath = _deleteList.shift();
               deleteResource(_currentDeletePath);
            }
            else
            {
               evt = new LoaderResourceEvent("delete");
               dispatchEvent(evt);
            }
         }
      }
      
      public function deleteResource(filePath:String) : void
      {
         LoadInterfaceManager.deleteResource(filePath);
      }
      
      protected function __checkComplete(event:LoadInterfaceEvent) : void
      {
         checkComplete(event.paras[0],event.paras[1],event.paras[2],event.paras[3]);
      }
      
      protected function __deleteComplete(event:LoadInterfaceEvent) : void
      {
         if(_currentDeletePath == event.paras[1])
         {
            deleteComlete(event.paras[0],event.paras[1]);
         }
      }
      
      protected function __flashGotoAndPlay(event:LoadInterfaceEvent) : void
      {
         flashGotoAndPlay(int(event.paras[0]),event.paras[1]);
      }
      
      public function checkComplete(loaderID:String, bFlag:String, httpUrl:String, fileName:String) : void
      {
         var evt:* = null;
         if(!_loadDic)
         {
            return;
         }
         var loader:BaseLoader = _loadDic[int(loaderID)];
         if(loader)
         {
            LoaderManager.Instance.setFlashLoadWeb();
            if(bFlag == "true")
            {
               beginLoad(loader);
            }
            else
            {
               loader.url = _loadUrlDic[loader.id];
               beginLoad(loader);
            }
            if(_loadDic)
            {
               delete _loadDic[loader.id];
               delete _loadUrlDic[loader.id];
            }
            if(loader.url.indexOf("2.png") != -1)
            {
               _isLoading = false;
               _progress = 1;
            }
         }
         else
         {
            LoadInterfaceManager.traceMsg("loader为空：" + loaderID + "* " + fileName);
         }
      }
      
      public function deleteComlete(bFlag:String, fileName:String) : void
      {
         deleteNext();
      }
      
      public function flashGotoAndPlay(loaderID:int, progress:Number) : void
      {
         if(!_loadDic)
         {
            return;
         }
         var loader:BaseLoader = _loadDic[int(loaderID)];
         if(loader)
         {
            if(loader.url.indexOf("2.png") != -1)
            {
               _isLoading = true;
               _progress = progress * 0.01;
            }
            else
            {
               UIModuleLoader.Instance.dispatchEvent(new UIModuleEvent("uiMoudleProgress",loader));
            }
         }
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
      
      public function get isMicroClient() : Boolean
      {
         return _clientType == 1;
      }
      
      public function get clientType() : int
      {
         return _clientType;
      }
      
      public function get infoSite() : String
      {
         return _infoSite;
      }
      
      public function set infoSite(value:String) : void
      {
         _infoSite = value;
      }
      
      public function get loadingUrl() : String
      {
         return _loadingUrl;
      }
      
      public function get progress() : Number
      {
         return _progress;
      }
      
      public function get isLoading() : Boolean
      {
         return _isLoading;
      }
   }
}

class Singleton
{
    
   
   function Singleton()
   {
      super();
   }
}
