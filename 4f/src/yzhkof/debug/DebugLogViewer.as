package yzhkof.debug
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import yzhkof.ui.DragPanel;
   import yzhkof.ui.ScrollPanel;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.ui.event.ComponentEvent;
   import yzhkof.util.WeakMap;
   
   public class DebugLogViewer extends DragPanel
   {
       
      
      private var _logArr:Array;
      
      private var _logMap:Dictionary;
      
      private var _logWeakMap:WeakMap;
      
      private var log_max_count:uint = 2000;
      
      private var scrollPanel:ScrollPanel;
      
      private var tileContainer:TileContainer;
      
      private var btn_Container:TileContainer;
      
      private var clean_btn:TextPanel;
      
      private var start_btn:TextPanel;
      
      private var stop_btn:TextPanel;
      
      private var start_stop_container:Sprite;
      
      private var isStart:Boolean = true;
      
      private var _weak:Boolean = false;
      
      public function DebugLogViewer(param1:Boolean = false){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __createComplete(param1:Event) : void{}
      
      public function addLog(param1:*, param2:String = "") : void{}
      
      function addLogDirectly(param1:*, param2:String = "") : void{}
      
      private function addLoged(param1:*, param2:String = "") : void{}
      
      public function cleanLog() : void{}
      
      private function addItem(param1:Object, param2:Object) : void{}
      
      private function getItem(param1:*) : *{return null;}
      
      public function checkGC() : void{}
      
      private function removeItem(param1:*) : void{}
      
      function get logMap() : Dictionary{return null;}
      
      function get weakMap() : WeakMap{return null;}
   }
}
