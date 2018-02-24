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
      
      public function BaseLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET"){super();}
      
      private function checkUrl(param1:String) : void{}
      
      public function get args() : URLVariables{return null;}
      
      public function get content() : *{return null;}
      
      public function getFilePathFromExternal() : void{}
      
      public function get id() : int{return 0;}
      
      public function get isComplete() : Boolean{return false;}
      
      public function set isComplete(param1:Boolean) : void{}
      
      public function get isSuccess() : Boolean{return false;}
      
      public function loadFromExternal(param1:String) : void{}
      
      public function loadFromBytes(param1:ByteArray) : void{}
      
      public function loadFromWeb() : void{}
      
      public function get progress() : Number{return 0;}
      
      public function get type() : int{return 0;}
      
      public function get url() : String{return null;}
      
      public function set url(param1:String) : void{}
      
      public function get isLoading() : Boolean{return false;}
      
      public function set isLoading(param1:Boolean) : void{}
      
      protected function __onDataLoadComplete(param1:Event) : void{}
      
      protected function fireCompleteEvent() : void{}
      
      protected function __onIOError(param1:IOErrorEvent) : void{}
      
      protected function __onProgress(param1:ProgressEvent) : void{}
      
      protected function __onStatus(param1:HTTPStatusEvent) : void{}
      
      protected function addEvent() : void{}
      
      protected function getLoadDataFormat() : String{return null;}
      
      protected function onLoadError() : void{}
      
      protected function fireErrorEvent() : void{}
      
      protected function removeEvent() : void{}
      
      protected function startLoad(param1:String) : void{}
      
      public function unload() : void{}
      
      protected function get logInstance() : Object{return null;}
   }
}
