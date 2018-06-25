package com.pickgliss.loader{   import flash.events.EventDispatcher;   import flash.external.ExternalInterface;   import flash.net.URLVariables;   import flash.system.ApplicationDomain;   import flash.system.LoaderContext;   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import flash.utils.setTimeout;      public class LoaderManager extends EventDispatcher   {            public static const ALLOW_MUTI_LOAD_COUNT:int = 8;            public static const LOAD_FROM_LOCAL:int = 2;            public static const LOAD_FROM_WEB:int = 1;            public static const LOAD_NOT_SET:int = 0;            public static var NEGLECT_URL:String = "";            private static var _instance:LoaderManager;                   private var _loadMode:int = 0;            private var _loaderIdCounter:int = 0;            private var _loaderSaveByID:Dictionary;            private var _loaderSaveByPath:Dictionary;            private var _loadingLoaderList:Vector.<BaseLoader>;            private var _waitingLoaderList:Vector.<BaseLoader>;            public function LoaderManager() { super(); }
            public static function get Instance() : LoaderManager { return null; }
            public function creatLoaderByType(filePath:String, type:int, args:URLVariables, requestMethod:String, domain:ApplicationDomain) : BaseLoader { return null; }
            public function getLoadMode() : int { return 0; }
            public function creatLoader(filePath:String, type:int, args:URLVariables = null, requestMethod:String = "GET", domain:ApplicationDomain = null) : * { return null; }
            public function creatLoaderOriginal(filePath:String, type:int, args:URLVariables = null, requestMethod:String = "GET") : * { return null; }
            public function creatAndStartLoad(filePath:String, type:int, args:URLVariables = null) : BaseLoader { return null; }
            public function getLoaderByID(id:int) : BaseLoader { return null; }
            public function clearLoader() : void { }
            public function getLoaderByURL(url:String, args:URLVariables) : BaseLoader { return null; }
            public function getNextLoaderID() : int { return 0; }
            public function saveFileToLocal(loader:BaseLoader) : void { }
            public function startLoad(loader:BaseLoader, loadImp:Boolean = false) : void { }
            private function __onLoadFinish(event:LoaderEvent) : void { }
            private function initLoadMode() : void { }
            private function onExternalLoadStop(id:int, path:String) : void { }
            private function setFlashLoadExternal() : void { }
            public function setFlashLoadWeb() : void { }
            private function tryLoadWaiting() : void { }
            public function setup(context:LoaderContext, textLoaderKey:String) : void { }
            public function fixedVariablesURL(path:String, type:int, variables:URLVariables) : String { return null; }
            public function fixedNewVariablesURL(path:String, type:int, variables:URLVariables, argsCount:int) : String { return null; }
   }}