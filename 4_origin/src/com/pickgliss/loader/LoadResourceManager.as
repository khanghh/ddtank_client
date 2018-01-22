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
      
      public function LoadResourceManager(param1:Singleton)
      {
         super();
         if(!param1)
         {
            throw Error("单例无法实例化");
         }
      }
      
      public static function get Instance() : LoadResourceManager
      {
         return _instance || new LoadResourceManager(new Singleton());
      }
      
      public function init(param1:String = "") : void
      {
         _infoSite = param1;
         var _loc2_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         LoaderManager.Instance.setup(_loc2_,String(Math.random()));
         addMicroClientEvent();
         LoadInterfaceManager.initAppInterface();
      }
      
      public function addMicroClientEvent() : void
      {
         LoadInterfaceManager.eventDispatcher.addEventListener("checkComplete",__checkComplete);
         LoadInterfaceManager.eventDispatcher.addEventListener("deleteComplete",__deleteComplete);
         LoadInterfaceManager.eventDispatcher.addEventListener("flashGotoAndPlay",__flashGotoAndPlay);
      }
      
      public function setLoginType(param1:Number, param2:String = "", param3:String = "-1") : void
      {
         _clientType = int(param1);
         _loadingUrl = param2;
         LoaderSavingManager.Version = int(param3);
      }
      
      public function setup(param1:LoaderContext, param2:String) : void
      {
         _loadDic = new Dictionary();
         _loadUrlDic = new Dictionary();
         _deleteList = new Vector.<String>();
      }
      
      public function createLoader(param1:String, param2:int, param3:URLVariables = null, param4:String = "GET", param5:ApplicationDomain = null, param6:Boolean = true, param7:Boolean = false) : *
      {
         return createOriginLoader(param1,_infoSite,param2,param3,param4,param5,param6,param7);
      }
      
      public function createOriginLoader(param1:String, param2:String, param3:int, param4:URLVariables = null, param5:String = "GET", param6:ApplicationDomain = null, param7:Boolean = false, param8:Boolean = false) : *
      {
         var _loc10_:* = null;
         var _loc9_:int = 0;
         var _loc11_:* = null;
         if(param7 && _clientType == 1 && [2,5,6,7].indexOf(param3) == -1)
         {
            param1 = fixedVariablesURL(param1.toLowerCase(),param3,param4);
            _loc9_ = param2.length;
            if(param1.indexOf(param2) == -1)
            {
               LoadInterfaceManager.traceMsg("filePath = " + param1 + "路径有问题");
            }
            _loc11_ = param1.substring(_loc9_,param1.length);
            _loc10_ = LoaderManager.Instance.creatLoaderByType(_loc11_,param3,param4,param5,param6);
            _loadDic[_loc10_.id] = _loc10_;
            _loadUrlDic[_loc10_.id] = param1;
         }
         else
         {
            _loc10_ = LoaderManager.Instance.creatLoader(param1,param3,param4,param5,param6);
         }
         return _loc10_;
      }
      
      private function __onLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onLoadComplete);
         param1.loader.removeEventListener("loadError",__onLoadError);
      }
      
      public function __onLoadError(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onLoadComplete);
         param1.loader.removeEventListener("loadError",__onLoadError);
         var _loc2_:LoaderResourceEvent = new LoaderResourceEvent("loadError");
         _loc2_.data = param1.loader;
         dispatchEvent(_loc2_);
      }
      
      public function creatAndStartLoad(param1:String, param2:int, param3:URLVariables = null) : BaseLoader
      {
         var _loc4_:BaseLoader = createLoader(param1,param2,param3);
         startLoad(_loc4_);
         return _loc4_;
      }
      
      public function startLoad(param1:BaseLoader, param2:Boolean = false, param3:Boolean = true) : void
      {
         startLoadFromLoadingUrl(param1,_infoSite,param2,param3);
      }
      
      public function startLoadFromLoadingUrl(param1:BaseLoader, param2:String, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc5_:String = param1.url;
         _loc5_ = _loc5_.replace(/\?.*/,"");
         if(param4 && _clientType == 1 && [2,5,6,7].indexOf(param1.type) == -1)
         {
            LoadInterfaceManager.checkResource(param1.id,param2,_loc5_,param3);
         }
         else
         {
            beginLoad(param1,param3);
         }
      }
      
      private function beginLoad(param1:BaseLoader, param2:Boolean = false) : void
      {
         LoaderManager.Instance.startLoad(param1,param2);
      }
      
      public function addDeleteRequest(param1:String) : void
      {
         if(!_deleteList)
         {
            _deleteList = new Vector.<String>();
         }
         _deleteList.push(param1);
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
         var _loc1_:* = null;
         if(_deleteList)
         {
            if(_deleteList.length > 0)
            {
               _currentDeletePath = _deleteList.shift();
               deleteResource(_currentDeletePath);
            }
            else
            {
               _loc1_ = new LoaderResourceEvent("delete");
               dispatchEvent(_loc1_);
            }
         }
      }
      
      public function deleteResource(param1:String) : void
      {
         LoadInterfaceManager.deleteResource(param1);
      }
      
      protected function __checkComplete(param1:LoadInterfaceEvent) : void
      {
         checkComplete(param1.paras[0],param1.paras[1],param1.paras[2],param1.paras[3]);
      }
      
      protected function __deleteComplete(param1:LoadInterfaceEvent) : void
      {
         if(_currentDeletePath == param1.paras[1])
         {
            deleteComlete(param1.paras[0],param1.paras[1]);
         }
      }
      
      protected function __flashGotoAndPlay(param1:LoadInterfaceEvent) : void
      {
         flashGotoAndPlay(int(param1.paras[0]),param1.paras[1]);
      }
      
      public function checkComplete(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc6_:* = null;
         if(!_loadDic)
         {
            return;
         }
         var _loc5_:BaseLoader = _loadDic[int(param1)];
         if(_loc5_)
         {
            LoaderManager.Instance.setFlashLoadWeb();
            if(param2 == "true")
            {
               beginLoad(_loc5_);
            }
            else
            {
               _loc5_.url = _loadUrlDic[_loc5_.id];
               beginLoad(_loc5_);
            }
            if(_loadDic)
            {
               delete _loadDic[_loc5_.id];
               delete _loadUrlDic[_loc5_.id];
            }
            if(_loc5_.url.indexOf("2.png") != -1)
            {
               _isLoading = false;
               _progress = 1;
            }
         }
         else
         {
            LoadInterfaceManager.traceMsg("loader为空：" + param1 + "* " + param4);
         }
      }
      
      public function deleteComlete(param1:String, param2:String) : void
      {
         deleteNext();
      }
      
      public function flashGotoAndPlay(param1:int, param2:Number) : void
      {
         if(!_loadDic)
         {
            return;
         }
         var _loc3_:BaseLoader = _loadDic[int(param1)];
         if(_loc3_)
         {
            if(_loc3_.url.indexOf("2.png") != -1)
            {
               _isLoading = true;
               _progress = param2 * 0.01;
            }
            else
            {
               UIModuleLoader.Instance.dispatchEvent(new UIModuleEvent("uiMoudleProgress",_loc3_));
            }
         }
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
      
      public function set infoSite(param1:String) : void
      {
         _infoSite = param1;
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
