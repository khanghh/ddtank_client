package com.pickgliss.toplevel{   import com.pickgliss.layout.StageResizeUtils;   import flash.display.Stage;   import flash.events.Event;      public final class StageReferance   {            public static var defaultWidth:int = 1000;            public static var defaultHeight:int = 600;            public static var stageHeight:int = 1000;            public static var stageWidth:int = 600;            private static var _stage:Stage;                   public function StageReferance() { super(); }
            public static function setup($stage:Stage) : void { }
            private static function __onNextFrame(event:Event) : void { }
            private static function __onResize(event:Event) : void { }
            public static function isStageResize() : Boolean { return false; }
            public static function get stage() : Stage { return null; }
   }}