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
      
      public function GameMsgCollector(param1:PrivateClass)
      {
         this.toCallParamsMap = {};
         super();
         if(param1 == null)
         {
            throw new ArgumentError("本类是单例实现，请通过instance静态getter获取实例！");
         }
      }
      
      public static function get instance() : GameMsgCollector
      {
         if(_instance == null)
         {
            _instance = new GameMsgCollector(new PrivateClass());
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         _instance = null;
      }
      
      public function collectMessage(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Function = null) : void
      {
         var paramsList:Array = null;
         var content:String = param1;
         var toUserRoleName:String = param2;
         var fromUserRoleName:String = param3;
         var msgType:String = param4;
         var gameSceneId:String = param5;
         var serverId:String = param6;
         var gameId:String = param7;
         var onSend:Function = param8;
         if(this.libInstance)
         {
            this.libInstance["collectMessage"].apply(this.libInstance,arguments);
            return;
         }
         paramsList = this.toCallParamsMap["collectMessage"] || [];
         this.toCallParamsMap["collectMessage"] = paramsList;
         paramsList.push(arguments);
         this.initLib(function():void
         {
            while(paramsList.length)
            {
               libInstance["collectMessage"].apply(libInstance,paramsList.shift());
            }
         });
      }
      
      public function getReportable(param1:String, param2:String, param3:String, param4:String) : void
      {
         var paramsList:Array = null;
         var toUserRoleName:String = param1;
         var gameSceneId:String = param2;
         var serverId:String = param3;
         var gameId:String = param4;
         if(this.libInstance)
         {
            this.libInstance["getReportable"].apply(this.libInstance,arguments);
            return;
         }
         paramsList = this.toCallParamsMap["getReportable"] || [];
         this.toCallParamsMap["getReportable"] = paramsList;
         paramsList.push(arguments);
         this.initLib(function():void
         {
            while(paramsList.length)
            {
               libInstance["getReportable"].apply(libInstance,paramsList.shift());
            }
         });
      }
      
      public function reportGameProfile(param1:String, param2:int, param3:String, param4:String, param5:String, param6:int, param7:String, param8:GameProfileParams = null) : void
      {
         var paramsList:Array = null;
         var passport:String = param1;
         var udbid:int = param2;
         var game:String = param3;
         var gameServer:String = param4;
         var roleName:String = param5;
         var roleLevel:int = param6;
         var gameEvent:String = param7;
         var otherParams:GameProfileParams = param8;
         if(this.libInstance)
         {
            this.libInstance["reportGameProfile"].apply(this.libInstance,arguments);
            return;
         }
         paramsList = this.toCallParamsMap["reportGameProfile"] || [];
         this.toCallParamsMap["reportGameProfile"] = paramsList;
         paramsList.push(arguments);
         this.initLib(function():void
         {
            while(paramsList.length)
            {
               libInstance["reportGameProfile"].apply(libInstance,paramsList.shift());
            }
         });
      }
      
      private function initLib(param1:Function) : void
      {
         var onInited:Function = param1;
         if(this.isIniting)
         {
            return;
         }
         this.isIniting = true;
         this.loadConfig(function(param1:String):void
         {
            var version:String = param1;
            if(version == null)
            {
               isIniting = false;
               return;
            }
            loadLibSwf(version,function(param1:Object):void
            {
               libInstance = param1;
               if(libInstance)
               {
                  onInited();
               }
               isIniting = false;
            });
         });
      }
      
      private function loadLibSwf(param1:String, param2:Function) : void
      {
         var loader:Loader = null;
         var onComplete:Function = null;
         var onIOError:Function = null;
         var onSecurityError:Function = null;
         var version:String = param1;
         var onLoaded:Function = param2;
         onComplete = function(param1:Event):void
         {
            removeAllEvents();
         };
         onIOError = function(param1:IOErrorEvent):void
         {
            removeAllEvents();
            trace("加载GameMsgCollectorLib出错，请与yy游戏相关人员联系");
         };
         onSecurityError = function(param1:SecurityErrorEvent):void
         {
            removeAllEvents();
            trace("加载GameMsgCollectorLib出错，请与yy游戏相关人员联系");
         };
         var removeAllEvents:Function = function():void
         {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
            loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         };
         loader = new Loader();
         var request:URLRequest = new URLRequest();
         request.url = SWF_LIB_URL;
         var variables:URLVariables = new URLVariables();
         variables.v = version;
         request.data = variables;
         request.method = URLRequestMethod.GET;
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,SecurityDomain.currentDomain);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         loader.load(request,context);
      }
      
      private function loadConfig(param1:Function) : void
      {
         var loader:URLLoader = null;
         var onComplete:Function = null;
         var onIOError:Function = null;
         var onLoaded:Function = param1;
         onComplete = function(param1:Event):void
         {
            removeAllEvents();
            var _loc2_:XML = new XML(loader.data);
         };
         onIOError = function(param1:IOErrorEvent):void
         {
            removeAllEvents();
            trace("加载GameMsgCollectorLib配置文件出错，请与yy游戏相关人员联系");
         };
         var removeAllEvents:Function = function():void
         {
            loader.removeEventListener(Event.COMPLETE,onComplete);
            loader.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         };
         loader = new URLLoader();
         var request:URLRequest = new URLRequest();
         request.url = CONFIG_URL;
         var variables:URLVariables = new URLVariables();
         variables.v = new Date().getTime().toString();
         request.data = variables;
         request.method = URLRequestMethod.GET;
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,onComplete);
         loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         loader.load(request);
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
