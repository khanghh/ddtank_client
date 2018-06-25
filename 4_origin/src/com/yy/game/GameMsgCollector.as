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
      
      public function GameMsgCollector(privateClass:PrivateClass)
      {
         this.toCallParamsMap = {};
         super();
         if(privateClass == null)
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
      
      public function collectMessage(content:String, toUserRoleName:String, fromUserRoleName:String, msgType:String, gameSceneId:String, serverId:String, gameId:String, onSend:Function = null) : void
      {
         var paramsList:Array = null;
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
      
      public function getReportable(toUserRoleName:String, gameSceneId:String, serverId:String, gameId:String) : void
      {
         var paramsList:Array = null;
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
      
      public function reportGameProfile(passport:String, udbid:int, game:String, gameServer:String, roleName:String, roleLevel:int, gameEvent:String, otherParams:GameProfileParams = null) : void
      {
         var paramsList:Array = null;
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
      
      private function initLib(onInited:Function) : void
      {
         if(this.isIniting)
         {
            return;
         }
         this.isIniting = true;
         this.loadConfig(function(version:String):void
         {
            if(version == null)
            {
               isIniting = false;
               return;
            }
            loadLibSwf(version,function(content:Object):void
            {
               libInstance = content;
               if(libInstance)
               {
                  onInited();
               }
               isIniting = false;
            });
         });
      }
      
      private function loadLibSwf(version:String, onLoaded:Function) : void
      {
         var loader:Loader = null;
         var onComplete:Function = null;
         var onIOError:Function = null;
         var onSecurityError:Function = null;
         onComplete = function(e:Event):void
         {
            removeAllEvents();
            onLoaded(Object(loader.content)["instance"]);
         };
         onIOError = function(e:IOErrorEvent):void
         {
            removeAllEvents();
            trace("加载GameMsgCollectorLib出错，请与yy游戏相关人员联系");
            onLoaded(null);
         };
         onSecurityError = function(e:SecurityErrorEvent):void
         {
            removeAllEvents();
            trace("加载GameMsgCollectorLib出错，请与yy游戏相关人员联系");
            onLoaded(null);
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
      
      private function loadConfig(onLoaded:Function) : void
      {
         var loader:URLLoader = null;
         var onComplete:Function = null;
         var onIOError:Function = null;
         onComplete = function(e:Event):void
         {
            removeAllEvents();
            var xml:XML = new XML(loader.data);
            onLoaded(xml.v);
         };
         onIOError = function(e:IOErrorEvent):void
         {
            removeAllEvents();
            trace("加载GameMsgCollectorLib配置文件出错，请与yy游戏相关人员联系");
            onLoaded(null);
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
