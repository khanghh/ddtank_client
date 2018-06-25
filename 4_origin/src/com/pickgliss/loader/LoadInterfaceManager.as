package com.pickgliss.loader
{
   import com.pickgliss.events.LoaderResourceEvent;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.system.fscommand;
   
   public class LoadInterfaceManager
   {
      
      private static var _eventDispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function LoadInterfaceManager()
      {
         super();
      }
      
      [Event(name="checkComplete",type="com.pickgliss.loader.LoadInterfaceEvent")]
      [Event(name="deleteComplete",type="com.pickgliss.loader.LoadInterfaceEvent")]
      [Event(name="flashGotoAndPlay",type="com.pickgliss.loader.LoadInterfaceEvent")]
      [Event(name="setSound",type="com.pickgliss.loader.LoadInterfaceEvent")]
      public static function get eventDispatcher() : EventDispatcher
      {
         return _eventDispatcher;
      }
      
      public static function initAppInterface() : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               ExternalInterface.addCallback("setLoginType",LoadResourceManager.Instance.setLoginType);
               ExternalInterface.addCallback("checkComplete",__checkHandler);
               ExternalInterface.addCallback("deleteComplete",__deleteHandler);
               ExternalInterface.addCallback("flashGotoAndPlay",__flashGotoAndPlayHandler);
               ExternalInterface.addCallback("setSound",__setSoundHandler);
            }
         }
         LoadResourceManager.Instance.dispatchEvent(new LoaderResourceEvent("init complete"));
      }
      
      private static function __checkHandler(... args) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("checkComplete",args));
      }
      
      private static function __deleteHandler(... args) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("deleteComplete",args));
      }
      
      private static function __flashGotoAndPlayHandler(... args) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("flashGotoAndPlay",args));
      }
      
      private static function __setSoundHandler(... args) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("setSound",args));
      }
      
      public static function setVersion(version:int) : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("setVersion",version.toString());
            }
         }
      }
      
      public static function checkResource(loaderID:int, infoSite:String, path:String, loadImp:Boolean = false) : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("checkResource",[loaderID,infoSite,path,loadImp].join("|"));
            }
         }
      }
      
      public static function deleteResource(path:String) : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("deleteResource",path);
            }
         }
      }
      
      public static function traceMsg(msg:String) : void
      {
         trace(msg);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("printTest",msg);
            }
         }
      }
      
      public static function alertAndRestart(msg:String) : void
      {
         trace(msg);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               traceMsg("alertAndRestart:" + msg);
               fscommand("alertAndRestart",msg);
            }
         }
      }
      
      public static function setDailyTask(value:String) : void
      {
         trace("setDailyTask:" + value);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("setDailyTask",value);
            }
         }
      }
      
      public static function setDailyActivity(value:String) : void
      {
         trace("setDailyActivity:" + value);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("setDailyActivity",value);
            }
         }
      }
      
      public static function setFatigue(value:String) : void
      {
         trace("setFatigue:" + value);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               traceMsg("setFatigue:" + value);
               fscommand("setFatigue",value);
            }
         }
      }
      
      public static function setSound(value:String) : void
      {
         trace("setSound:" + value);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               traceMsg("setSound:" + value);
               fscommand("setSound",value);
            }
         }
      }
   }
}
