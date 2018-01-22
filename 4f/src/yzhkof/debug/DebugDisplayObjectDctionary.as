package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import yzhkof.AddToStageSetter;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.util.WeakMap;
   
   public class DebugDisplayObjectDctionary extends TileContainer
   {
       
      
      var _dobj_map:WeakMap;
      
      private var viewer:DebugDisplayObjectViewer;
      
      public function DebugDisplayObjectDctionary(){super();}
      
      public function checkGC() : void{}
      
      public function setup(param1:DebugDisplayObjectViewer) : void{}
      
      public function Goto(param1:*) : void{}
      
      public function select(param1:Array) : void{}
      
      private function reset() : void{}
      
      private function get arrow() : TextPanel{return null;}
      
      public function get dobj_map() : WeakMap{return null;}
   }
}
