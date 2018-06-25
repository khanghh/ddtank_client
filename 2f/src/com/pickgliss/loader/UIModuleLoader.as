package com.pickgliss.loader{   import com.pickgliss.events.LoaderResourceEvent;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import deng.fzip.FZip;   import deng.fzip.FZipFile;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.external.ExternalInterface;   import flash.utils.ByteArray;      [Event(name="uiModuleComplete",type="com.pickgliss.events.UIModuleEvent")]   [Event(name="uiModuleError",type="com.pickgliss.events.UIModuleEvent")]   [Event(name="uiMoudleProgress",type="com.pickgliss.events.UIModuleEvent")]   public class UIModuleLoader extends EventDispatcher   {            public static const XMLPNG:String = "xml.png";            public static const CONFIG_ZIP:String = "configZip";            public static const CONFIG_XML:String = "configXml";            private static var _baseUrl:String = "";            private static var _instance:UIModuleLoader;                   private var _uiModuleLoadMode:String = "configXml";            private var _loadingLoaders:Vector.<BaseLoader>;            private var _queue:Vector.<String>;            private var _backupUrl:String = "";            private var _zipPath:String = "";            private var _zipLoadComplete:Boolean = true;            private var _zipLoader:BaseLoader;            private var _isSecondLoad:Boolean = false;            public function UIModuleLoader() { super(); }
            public static function get Instance() : UIModuleLoader { return null; }
            public function addUIModlue(module:String) : void { }
            public function addUIModuleImp(module:String, state:String = null) : void { }
            public function setup(baseUrl:String = "", backupUrl:String = "") : void { }
            public function get baseUrl() : String { return null; }
            private function loadZipConfig() : void { }
            private function __onLoadZipComplete(event:LoaderEvent) : void { }
            public function analyMd5(content:ByteArray) : void { }
            private function compareMD5(temp:ByteArray) : Boolean { return false; }
            private function hasHead(temp:ByteArray) : Boolean { return false; }
            private function zipLoad(content:ByteArray) : void { }
            private function __onZipParaComplete(event:Event) : void { }
            public function get isLoading() : Boolean { return false; }
            private function __onConfigLoadComplete(event:LoaderEvent) : void { }
            private function __onLoadError(event:LoaderEvent) : void { }
            private function __onResourceComplete(event:LoaderEvent) : void { }
            private function removeLastLoader(loader:BaseLoader) : void { }
            private function __onResourceProgress(event:LoaderEvent) : void { }
            private function loadNextModule() : void { }
            private function isLoadingModule(module:String) : Boolean { return false; }
            private function loadModuleConfig(module:String, state:String = "") : void { }
            private function loadModuleUI(uipath:String, module:String = "", state:String = "") : void { }
   }}