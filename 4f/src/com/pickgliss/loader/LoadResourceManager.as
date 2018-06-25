package com.pickgliss.loader{   import com.pickgliss.events.LoaderResourceEvent;   import com.pickgliss.events.UIModuleEvent;   import flash.events.EventDispatcher;   import flash.net.URLVariables;   import flash.system.ApplicationDomain;   import flash.system.LoaderContext;   import flash.utils.Dictionary;      [Event(name="init complete",type="com.pickgliss.events.LoaderResourceEvent")]   [Event(name="complete",type="com.pickgliss.events.LoaderResourceEvent")]   [Event(name="delete",type="com.pickgliss.events.LoaderResourceEvent")]   [Event(name="loadError",type="com.pickgliss.events.LoaderResourceEvent")]   [Event(name="progress",type="com.pickgliss.events.LoaderResourceEvent")]   public class LoadResourceManager extends EventDispatcher   {            private static var _instance:LoadResourceManager;                   private var _infoSite:String = "";            private var _loadingUrl:String = "";            private var _clientType:int;            private var _loadDic:Dictionary;            private var _loadUrlDic:Dictionary;            private var _deleteList:Vector.<String>;            private var _currentDeletePath:String;            private var _isLoading:Boolean;            private var _progress:Number;            public function LoadResourceManager(single:Singleton) { super(); }
            public static function get Instance() : LoadResourceManager { return null; }
            public function init(infoSite:String = "") : void { }
            public function addMicroClientEvent() : void { }
            public function setLoginType(type:Number, loadingUrl:String = "", version:String = "-1") : void { }
            public function setup(context:LoaderContext, textLoaderKey:String) : void { }
            public function createLoader(filePath:String, type:int, args:URLVariables = null, requestMethod:String = "GET", domain:ApplicationDomain = null, useClient:Boolean = true, isIgnoreError:Boolean = false) : * { return null; }
            public function createOriginLoader(filePath:String, rootSite:String, type:int, args:URLVariables = null, requestMethod:String = "GET", domain:ApplicationDomain = null, useClient:Boolean = false, isIgnoreError:Boolean = false) : * { return null; }
            private function __onLoadComplete(event:LoaderEvent) : void { }
            public function __onLoadError(event:LoaderEvent) : void { }
            public function creatAndStartLoad(filePath:String, type:int, args:URLVariables = null) : BaseLoader { return null; }
            public function startLoad(loader:BaseLoader, loadImp:Boolean = false, useClient:Boolean = true) : void { }
            public function startLoadFromLoadingUrl(loader:BaseLoader, rootSite:String, loadImp:Boolean = false, useClient:Boolean = true) : void { }
            private function beginLoad(loader:BaseLoader, loadImp:Boolean = false) : void { }
            public function addDeleteRequest(filePath:String) : void { }
            public function startDelete() : void { }
            private function deleteNext() : void { }
            public function deleteResource(filePath:String) : void { }
            protected function __checkComplete(event:LoadInterfaceEvent) : void { }
            protected function __deleteComplete(event:LoadInterfaceEvent) : void { }
            protected function __flashGotoAndPlay(event:LoadInterfaceEvent) : void { }
            public function checkComplete(loaderID:String, bFlag:String, httpUrl:String, fileName:String) : void { }
            public function deleteComlete(bFlag:String, fileName:String) : void { }
            public function flashGotoAndPlay(loaderID:int, progress:Number) : void { }
            public function fixedVariablesURL(path:String, type:int, variables:URLVariables) : String { return null; }
            public function get isMicroClient() : Boolean { return false; }
            public function get clientType() : int { return 0; }
            public function get infoSite() : String { return null; }
            public function set infoSite(value:String) : void { }
            public function get loadingUrl() : String { return null; }
            public function get progress() : Number { return 0; }
            public function get isLoading() : Boolean { return false; }
   }}class Singleton{          function Singleton() { super(); }
}