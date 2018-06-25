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
      
      public function BaseLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         super();
         checkUrl(url);
         _args = args;
         _id = id;
         _loader = new URLLoader();
         _requestMethod = requestMethod;
      }
      
      private function checkUrl(url:String) : void
      {
         var neglect:String = LoaderManager.NEGLECT_URL;
         var realUrl:* = url;
         if(neglect != "" && url.indexOf(neglect) != -1)
         {
            realUrl = url.toLocaleLowerCase();
         }
         _url = realUrl;
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
      
      public function set isComplete(value:Boolean) : void
      {
         _isComplete = value;
      }
      
      public function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
      
      public function loadFromExternal(path:String) : void
      {
         startLoad(path);
      }
      
      public function loadFromBytes(data:ByteArray) : void
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
      
      public function set url(value:String) : void
      {
         _url = value;
      }
      
      public function get isLoading() : Boolean
      {
         return _isLoading;
      }
      
      public function set isLoading(value:Boolean) : void
      {
         _isLoading = value;
      }
      
      protected function __onDataLoadComplete(event:Event) : void
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
      
      protected function __onIOError(event:IOErrorEvent) : void
      {
         LoadInterfaceManager.traceMsg("微端加载资源错误：" + event.text + " " + _currentLoadPath);
         onLoadError();
      }
      
      protected function __onProgress(event:ProgressEvent) : void
      {
         _progress = event.bytesLoaded / event.bytesTotal;
         if(loadProgressMessage)
         {
            loadProgressMessage = loadProgressMessage.replace("{progress}",String(Math.round(_progress * 100)));
         }
         dispatchEvent(new LoaderEvent("progress",this));
      }
      
      protected function __onStatus(event:HTTPStatusEvent) : void
      {
         if(event.status > 399)
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
      
      protected function startLoad(path:String) : void
      {
         if(_isLoading)
         {
            return;
         }
         addEvent();
         _currentLoadPath = path.toLocaleLowerCase();
         _loader.dataFormat = getLoadDataFormat();
         var _request:URLRequest = new URLRequest(_currentLoadPath);
         _request.method = _requestMethod;
         _request.data = _args;
         _isLoading = true;
         _loader.load(_request);
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
