package com.pickgliss.loader
{
   import com.pickgliss.events.LoaderResourceEvent;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.system.fscommand;
   
   public class LoadInterfaceManager
   {
      
      private static var _eventDispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function LoadInterfaceManager(){super();}
      
      [Event(name="checkComplete",type="com.pickgliss.loader.LoadInterfaceEvent")]
      [Event(name="deleteComplete",type="com.pickgliss.loader.LoadInterfaceEvent")]
      [Event(name="flashGotoAndPlay",type="com.pickgliss.loader.LoadInterfaceEvent")]
      [Event(name="setSound",type="com.pickgliss.loader.LoadInterfaceEvent")]
      public static function get eventDispatcher() : EventDispatcher{return null;}
      
      public static function initAppInterface() : void{}
      
      private static function __checkHandler(... rest) : void{}
      
      private static function __deleteHandler(... rest) : void{}
      
      private static function __flashGotoAndPlayHandler(... rest) : void{}
      
      private static function __setSoundHandler(... rest) : void{}
      
      public static function setVersion(param1:int) : void{}
      
      public static function checkResource(param1:int, param2:String, param3:String, param4:Boolean = false) : void{}
      
      public static function deleteResource(param1:String) : void{}
      
      public static function traceMsg(param1:String) : void{}
      
      public static function alertAndRestart(param1:String) : void{}
      
      public static function setDailyTask(param1:String) : void{}
      
      public static function setDailyActivity(param1:String) : void{}
      
      public static function setFatigue(param1:String) : void{}
      
      public static function setSound(param1:String) : void{}
   }
}
