package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   [Event(name="complete",type="com.pickgliss.loader.LoaderEvent")]
   [Event(name="loadError",type="com.pickgliss.loader.LoaderEvent")]
   [Event(name="progress",type="com.pickgliss.loader.LoaderEvent")]
   public class BaseLoader extends EventDispatcher
   {
      
      public static const BITMAP_LOADER:int = 0;
      
      public static const BYTE_LOADER:int = 3;
      
      public static const DISPLAY_LOADER:int = 1;
      
      public static const TEXT_LOADER:int = 2;
      
      public static const MODULE_LOADER:int = 4;
      
      public static const COMPRESS_TEXT_LOADER:int = 5;
      
      public static const REQUEST_LOADER:int = 6;
      
      public static const COMPRESS_REQUEST_LOADER:int = 7;
      
      public static const TRY_LOAD_TIMES:int = 3;
      
      public static const MORNUI_DATA_LOADER:int = 8;
      
      public static const CODE_MODULE_LOADER:int = 9;
      
      public static const BONES_LOADER:int = 10;
       
      
      public var loadCompleteMessage:String;
      
      public var loadErrorMessage:String;
      
      public var loadProgressMessage:String;
      
      protected var _args:URLVariables;
      
      protected var _id:int;
      
      protected var _isComplete:Boolean;
      
      protected var _isSuccess:Boolean;
      
      protected var _loader:URLLoader;
      
      protected var _progress:Number = 0;
      
      protected var _url:String;
      
      protected var _isLoading:Boolean;
      
      protected var _requestMethod:String;
      
      protected var _currentLoadPath:String;
      
      private var _currentTryTime:int = 0;
      
      protected var _starTime:int;
      
      public var analyzer:DataAnalyzer;
      
      public var domain:ApplicationDomain;
      
      public function BaseLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET")
      {
         super();
         checkUrl(param2);
         _args = param3;
         _id = param1;
         _loader = new URLLoader();
         _requestMethod = param4;
      }
      
      private function checkUrl(param1:String) : void
      {
         var _loc2_:String = LoaderManager.NEGLECT_URL;
         var _loc3_:* = param1;
         if(_loc2_ != "" && param1.indexOf(_loc2_) != -1)
         {
            _loc3_ = param1.toLocaleLowerCase();
         }
         _url = _loc3_;
      }
      
      public function get args() : URLVariables
      {
         return _args;
      }
      
      public function get content() : *
      {
         return _loader.data;
      }
      
      public function getFilePathFromExternal() : void
      {
         ExternalInterface.call("ExternalLoadStart",_id,_url);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
      
      public function set isComplete(param1:Boolean) : void
      {
         _isComplete = param1;
      }
      
      public function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
      
      public function loadFromExternal(param1:String) : void
      {
         startLoad(param1);
      }
      
      public function loadFromBytes(param1:ByteArray) : void
      {
         _starTime = getTimer();
      }
      
      public function loadFromWeb() : void
      {
         startLoad(_url);
      }
      
      public function get progress() : Number
      {
         return _progress;
      }
      
      public function get type() : int
      {
         return 3;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(param1:String) : void
      {
         _url = param1;
      }
      
      public function get isLoading() : Boolean
      {
         return _isLoading;
      }
      
      public function set isLoading(param1:Boolean) : void
      {
         _isLoading = param1;
      }
      
      protected function __onDataLoadComplete(param1:Event) : void
      {
         removeEvent();
         _loader.close();
         fireCompleteEvent();
      }
      
      protected function fireCompleteEvent() : void
      {
         _progress = 1;
         dispatchEvent(new LoaderEvent("progress",this));
         _isSuccess = true;
         _isComplete = true;
         _isLoading = false;
         domain = null;
         dispatchEvent(new LoaderEvent("complete",this));
      }
      
      protected function __onIOError(param1:IOErrorEvent) : void
      {
         LoadInterfaceManager.traceMsg("微端加载资源错误：" + param1.text + " " + _currentLoadPath);
         onLoadError();
      }
      
      protected function __onProgress(param1:ProgressEvent) : void
      {
         _progress = param1.bytesLoaded / param1.bytesTotal;
         if(loadProgressMessage)
         {
            loadProgressMessage = loadProgressMessage.replace("{progress}",String(Math.round(_progress * 100)));
         }
         dispatchEvent(new LoaderEvent("progress",this));
      }
      
      protected function __onStatus(param1:HTTPStatusEvent) : void
      {
         if(param1.status > 399)
         {
         }
      }
      
      protected function addEvent() : void
      {
         _loader.addEventListener("complete",__onDataLoadComplete);
         _loader.addEventListener("progress",__onProgress);
         _loader.addEventListener("ioError",__onIOError);
      }
      
      protected function getLoadDataFormat() : String
      {
         return "binary";
      }
      
      protected function onLoadError() : void
      {
         removeEvent();
         if(_currentTryTime < 3)
         {
            _currentTryTime = Number(_currentTryTime) + 1;
            _isLoading = false;
            if(logInstance != null)
            {
               logInstance.log.debug("路径_" + _currentLoadPath + "#_加载异常次数_" + _currentTryTime);
            }
            startLoad(_currentLoadPath);
         }
         else
         {
            _loader.close();
            _isComplete = true;
            _isLoading = false;
            _isSuccess = false;
            dispatchEvent(new LoaderEvent("loadError",this));
            dispatchEvent(new LoaderEvent("complete",this));
         }
      }
      
      protected function fireErrorEvent() : void
      {
         dispatchEvent(new LoaderEvent("loadError",this));
      }
      
      protected function removeEvent() : void
      {
         _loader.removeEventListener("complete",__onDataLoadComplete);
         _loader.removeEventListener("progress",__onProgress);
         _loader.removeEventListener("ioError",__onIOError);
      }
      
      protected function startLoad(param1:String) : void
      {
         if(_isLoading)
         {
            return;
         }
         addEvent();
         _currentLoadPath = param1.toLocaleLowerCase();
         _loader.dataFormat = getLoadDataFormat();
         var _loc2_:URLRequest = new URLRequest(_currentLoadPath);
         _loc2_.method = _requestMethod;
         _loc2_.data = _args;
         _isLoading = true;
         _loader.load(_loc2_);
         _starTime = getTimer();
      }
      
      public function unload() : void
      {
         try
         {
            _loader.close();
            return;
         }
         catch(error:Error)
         {
            trace(error.message);
            return;
         }
      }
      
      protected function get logInstance() : Object
      {
         return null;
      }
   }
}
