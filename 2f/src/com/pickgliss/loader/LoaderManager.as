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
      
      public function LoaderManager(){super();}
      
      public static function get Instance() : LoaderManager{return null;}
      
      public function creatLoaderByType(param1:String, param2:int, param3:URLVariables, param4:String, param5:ApplicationDomain) : BaseLoader{return null;}
      
      public function getLoadMode() : int{return 0;}
      
      public function creatLoader(param1:String, param2:int, param3:URLVariables = null, param4:String = "GET", param5:ApplicationDomain = null) : *{return null;}
      
      public function creatLoaderOriginal(param1:String, param2:int, param3:URLVariables = null, param4:String = "GET") : *{return null;}
      
      public function creatAndStartLoad(param1:String, param2:int, param3:URLVariables = null) : BaseLoader{return null;}
      
      public function getLoaderByID(param1:int) : BaseLoader{return null;}
      
      public function clearLoader() : void{}
      
      public function getLoaderByURL(param1:String, param2:URLVariables) : BaseLoader{return null;}
      
      public function getNextLoaderID() : int{return 0;}
      
      public function saveFileToLocal(param1:BaseLoader) : void{}
      
      public function startLoad(param1:BaseLoader, param2:Boolean = false) : void{}
      
      private function __onLoadFinish(param1:LoaderEvent) : void{}
      
      private function initLoadMode() : void{}
      
      private function onExternalLoadStop(param1:int, param2:String) : void{}
      
      private function setFlashLoadExternal() : void{}
      
      public function setFlashLoadWeb() : void{}
      
      private function tryLoadWaiting() : void{}
      
      public function setup(param1:LoaderContext, param2:String) : void{}
      
      public function fixedVariablesURL(param1:String, param2:int, param3:URLVariables) : String{return null;}
      
      public function fixedNewVariablesURL(param1:String, param2:int, param3:URLVariables, param4:int) : String{return null;}
   }
}
