package com.pickgliss.loader{   import com.pickgliss.events.LoaderResourceEvent;   import flash.events.EventDispatcher;   import flash.external.ExternalInterface;   import flash.system.fscommand;      public class LoadInterfaceManager   {            private static var _eventDispatcher:EventDispatcher = new EventDispatcher();                   public function LoadInterfaceManager() { super(); }
            [Event(name="checkComplete",type="com.pickgliss.loader.LoadInterfaceEvent")]      [Event(name="deleteComplete",type="com.pickgliss.loader.LoadInterfaceEvent")]      [Event(name="flashGotoAndPlay",type="com.pickgliss.loader.LoadInterfaceEvent")]      [Event(name="setSound",type="com.pickgliss.loader.LoadInterfaceEvent")]      public static function get eventDispatcher() : EventDispatcher { return null; }
            public static function initAppInterface() : void { }
            private static function __checkHandler(... args) : void { }
            private static function __deleteHandler(... args) : void { }
            private static function __flashGotoAndPlayHandler(... args) : void { }
            private static function __setSoundHandler(... args) : void { }
            public static function setVersion(version:int) : void { }
            public static function checkResource(loaderID:int, infoSite:String, path:String, loadImp:Boolean = false) : void { }
            public static function deleteResource(path:String) : void { }
            public static function traceMsg(msg:String) : void { }
            public static function alertAndRestart(msg:String) : void { }
            public static function setDailyTask(value:String) : void { }
            public static function setDailyActivity(value:String) : void { }
            public static function setFatigue(value:String) : void { }
            public static function setSound(value:String) : void { }
   }}