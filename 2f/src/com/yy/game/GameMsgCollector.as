package com.yy.game
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   public class GameMsgCollector
   {
      
      private static const SWF_LIB_URL:String = "http://client.garbage.game.yy.com/GameMsgCollectorLib.swf";
      
      private static const CONFIG_URL:String = "http://client.garbage.game.yy.com/v.xml";
      
      private static var _instance:GameMsgCollector;
      
      public static const VERSION:String = "3.0";
       
      
      private var libInstance:Object = null;
      
      private var toCallParamsMap:Object;
      
      private var isIniting:Boolean = false;
      
      public function GameMsgCollector(param1:PrivateClass){super();}
      
      public static function get instance() : GameMsgCollector{return null;}
      
      public function dispose() : void{}
      
      public function collectMessage(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Function = null) : void{}
      
      public function getReportable(param1:String, param2:String, param3:String, param4:String) : void{}
      
      public function reportGameProfile(param1:String, param2:int, param3:String, param4:String, param5:String, param6:int, param7:String, param8:GameProfileParams = null) : void{}
      
      private function initLib(param1:Function) : void{}
      
      private function loadLibSwf(param1:String, param2:Function) : void{}
      
      private function loadConfig(param1:Function) : void{}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
