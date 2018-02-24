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
      
      public function LoadResourceManager(param1:Singleton){super();}
      
      public static function get Instance() : LoadResourceManager{return null;}
      
      public function init(param1:String = "") : void{}
      
      public function addMicroClientEvent() : void{}
      
      public function setLoginType(param1:Number, param2:String = "", param3:String = "-1") : void{}
      
      public function setup(param1:LoaderContext, param2:String) : void{}
      
      public function createLoader(param1:String, param2:int, param3:URLVariables = null, param4:String = "GET", param5:ApplicationDomain = null, param6:Boolean = true, param7:Boolean = false) : *{return null;}
      
      public function createOriginLoader(param1:String, param2:String, param3:int, param4:URLVariables = null, param5:String = "GET", param6:ApplicationDomain = null, param7:Boolean = false, param8:Boolean = false) : *{return null;}
      
      private function __onLoadComplete(param1:LoaderEvent) : void{}
      
      public function __onLoadError(param1:LoaderEvent) : void{}
      
      public function creatAndStartLoad(param1:String, param2:int, param3:URLVariables = null) : BaseLoader{return null;}
      
      public function startLoad(param1:BaseLoader, param2:Boolean = false, param3:Boolean = true) : void{}
      
      public function startLoadFromLoadingUrl(param1:BaseLoader, param2:String, param3:Boolean = false, param4:Boolean = true) : void{}
      
      private function beginLoad(param1:BaseLoader, param2:Boolean = false) : void{}
      
      public function addDeleteRequest(param1:String) : void{}
      
      public function startDelete() : void{}
      
      private function deleteNext() : void{}
      
      public function deleteResource(param1:String) : void{}
      
      protected function __checkComplete(param1:LoadInterfaceEvent) : void{}
      
      protected function __deleteComplete(param1:LoadInterfaceEvent) : void{}
      
      protected function __flashGotoAndPlay(param1:LoadInterfaceEvent) : void{}
      
      public function checkComplete(param1:String, param2:String, param3:String, param4:String) : void{}
      
      public function deleteComlete(param1:String, param2:String) : void{}
      
      public function flashGotoAndPlay(param1:int, param2:Number) : void{}
      
      public function fixedVariablesURL(param1:String, param2:int, param3:URLVariables) : String{return null;}
      
      public function get isMicroClient() : Boolean{return false;}
      
      public function get clientType() : int{return 0;}
      
      public function get infoSite() : String{return null;}
      
      public function set infoSite(param1:String) : void{}
      
      public function get loadingUrl() : String{return null;}
      
      public function get progress() : Number{return 0;}
      
      public function get isLoading() : Boolean{return false;}
   }
}

class Singleton
{
    
   
   function Singleton(){super();}
}
