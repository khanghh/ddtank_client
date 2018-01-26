package com.pickgliss.loader
{
   import com.pickgliss.events.LoaderResourceEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   
   [Event(name="uiModuleComplete",type="com.pickgliss.events.UIModuleEvent")]
   [Event(name="uiModuleError",type="com.pickgliss.events.UIModuleEvent")]
   [Event(name="uiMoudleProgress",type="com.pickgliss.events.UIModuleEvent")]
   public class UIModuleLoader extends EventDispatcher
   {
      
      public static const XMLPNG:String = "xml.png";
      
      public static const CONFIG_ZIP:String = "configZip";
      
      public static const CONFIG_XML:String = "configXml";
      
      private static var _baseUrl:String = "";
      
      private static var _instance:UIModuleLoader;
       
      
      private var _uiModuleLoadMode:String = "configXml";
      
      private var _loadingLoaders:Vector.<BaseLoader>;
      
      private var _queue:Vector.<String>;
      
      private var _backupUrl:String = "";
      
      private var _zipPath:String = "";
      
      private var _zipLoadComplete:Boolean = true;
      
      private var _zipLoader:BaseLoader;
      
      private var _isSecondLoad:Boolean = false;
      
      public function UIModuleLoader(){super();}
      
      public static function get Instance() : UIModuleLoader{return null;}
      
      public function addUIModlue(param1:String) : void{}
      
      public function addUIModuleImp(param1:String, param2:String = null) : void{}
      
      public function setup(param1:String = "", param2:String = "") : void{}
      
      public function get baseUrl() : String{return null;}
      
      private function loadZipConfig() : void{}
      
      private function __onLoadZipComplete(param1:LoaderEvent) : void{}
      
      public function analyMd5(param1:ByteArray) : void{}
      
      private function compareMD5(param1:ByteArray) : Boolean{return false;}
      
      private function hasHead(param1:ByteArray) : Boolean{return false;}
      
      private function zipLoad(param1:ByteArray) : void{}
      
      private function __onZipParaComplete(param1:Event) : void{}
      
      public function get isLoading() : Boolean{return false;}
      
      private function __onConfigLoadComplete(param1:LoaderEvent) : void{}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __onResourceComplete(param1:LoaderEvent) : void{}
      
      private function removeLastLoader(param1:BaseLoader) : void{}
      
      private function __onResourceProgress(param1:LoaderEvent) : void{}
      
      private function loadNextModule() : void{}
      
      private function isLoadingModule(param1:String) : Boolean{return false;}
      
      private function loadModuleConfig(param1:String, param2:String = "") : void{}
      
      private function loadModuleUI(param1:String, param2:String = "", param3:String = "") : void{}
   }
}
