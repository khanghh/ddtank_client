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
      
      private static function __checkHandler(... rest) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("checkComplete",rest));
      }
      
      private static function __deleteHandler(... rest) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("deleteComplete",rest));
      }
      
      private static function __flashGotoAndPlayHandler(... rest) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("flashGotoAndPlay",rest));
      }
      
      private static function __setSoundHandler(... rest) : void
      {
         _eventDispatcher.dispatchEvent(new LoadInterfaceEvent("setSound",rest));
      }
      
      public static function setVersion(param1:int) : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("setVersion",param1.toString());
            }
         }
      }
      
      public static function checkResource(param1:int, param2:String, param3:String, param4:Boolean = false) : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("checkResource",[param1,param2,param3,param4].join("|"));
            }
         }
      }
      
      public static function deleteResource(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("deleteResource",param1);
            }
         }
      }
      
      public static function traceMsg(param1:String) : void
      {
         trace(param1);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("printTest",param1);
            }
         }
      }
      
      public static function alertAndRestart(param1:String) : void
      {
         trace(param1);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               traceMsg("alertAndRestart:" + param1);
               fscommand("alertAndRestart",param1);
            }
         }
      }
      
      public static function setDailyTask(param1:String) : void
      {
         trace("setDailyTask:" + param1);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("setDailyTask",param1);
            }
         }
      }
      
      public static function setDailyActivity(param1:String) : void
      {
         trace("setDailyActivity:" + param1);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("setDailyActivity",param1);
            }
         }
      }
      
      public static function setFatigue(param1:String) : void
      {
         trace("setFatigue:" + param1);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               traceMsg("setFatigue:" + param1);
               fscommand("setFatigue",param1);
            }
         }
      }
      
      public static function setSound(param1:String) : void
      {
         trace("setSound:" + param1);
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               traceMsg("setSound:" + param1);
               fscommand("setSound",param1);
            }
         }
      }
   }
}
