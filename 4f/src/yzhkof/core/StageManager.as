package yzhkof.core{   import flash.display.DisplayObject;   import flash.display.Stage;   import flash.events.Event;   import yzhkof.util.WeakMap;      public class StageManager   {            private static var _stage:Stage;            private static const weakMap:WeakMap = new WeakMap();            private static var childCount:uint = 0;                   public function StageManager() { super(); }
            public static function init(stage:Stage) : void { }
            public static function get stage() : Stage { return null; }
            public static function addChildToStageUpperDisplayList(child:DisplayObject) : void { }
            private static function __onStageAdd(e:Event) : void { }
   }}