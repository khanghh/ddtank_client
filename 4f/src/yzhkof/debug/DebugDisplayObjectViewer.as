package yzhkof.debug
{
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.FileReference;
   import flash.sampler.getMemberNames;
   import flash.system.System;
   import flash.ui.ContextMenuItem;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import mx.graphics.codec.PNGEncoder;
   import yzhkof.KeyMy;
   import yzhkof.MyGC;
   import yzhkof.MyGraphy;
   import yzhkof.ToolBitmapData;
   import yzhkof.guxi.FocusViewer;
   import yzhkof.guxi.GraphicArea;
   import yzhkof.ui.ComponentBase;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.util.DebugUtil;
   import yzhkof.util.RightMenuUtil;
   import yzhkof.util.WeakMap;
   
   public class DebugDisplayObjectViewer extends ComponentBase
   {
      
      public static var SIMPLE:String = "simple";
      
      public static var DETAIL:String = "detail";
       
      
      private var container:TileContainer;
      
      private var btn_container:TileContainer;
      
      private var _currentLeaf:WeakMap;
      
      private var _latestLeaf:WeakMap;
      
      private var dictionary_viewer:DebugDisplayObjectDctionary;
      
      private var currentRefreshType:String = "simple";
      
      private var _drager:DebugDrag;
      
      private var _stage:Stage;
      
      private var _child_map:WeakMap;
      
      private var fold_btn:TextPanel;
      
      private var back_btn:TextPanel;
      
      private var stage_btn:TextPanel;
      
      private var mode_btn_a:TextPanel;
      
      private var mode_btn_b:TextPanel;
      
      private var text_btn:TextPanel;
      
      private var script_btn:TextPanel;
      
      private var refresh_btn:TextPanel;
      
      private var focus_btn:TextPanel;
      
      private var gc_btn:TextPanel;
      
      private var log_btn:TextPanel;
      
      private var weak_log_btn:TextPanel;
      
      private var focus_txt:TextPanel;
      
      private var x_btn:TextPanel;
      
      private var mode_container:Sprite;
      
      private var mask_background:Sprite;
      
      private var viewer:SnapshotDisplayViewer;
      
      private var watcher_btn:TextPanel;
      
      private var _fileReference:FileReference;
      
      private var reference_arr:Array;
      
      private var _locateGraph:GraphicArea;
      
      public function DebugDisplayObjectViewer(param1:Stage){super();}
      
      private function set currentLeaf(param1:*) : void{}
      
      private function get currentLeaf() : *{return null;}
      
      private function set latestLeaf(param1:*) : void{}
      
      private function get latestLeaf() : *{return null;}
      
      private function init() : void{}
      
      private function setMaskBackGround(param1:Sprite) : void{}
      
      private function initEvent() : void{}
      
      override protected function onDraw() : void{}
      
      private function __onStageClick(param1:MouseEvent) : void{}
      
      public function Goto(param1:*, param2:Boolean = false) : void{}
      
      public function view(param1:DisplayObject) : void{}
      
      public function savePNG(param1:DisplayObject) : void{}
      
      private function getTextPanel(param1:*) : TextPanel{return null;}
      
      private function refresh(param1:String = "") : void{}
      
      public function checkGC() : void{}
      
      public function getDebugTextButton(param1:*, param2:String) : TextPanel{return null;}
      
      private function addTextButtonRightMenu(param1:TextPanel, param2:*) : void{}
      
      private function __rightMenuClick(param1:ContextMenuEvent) : void{}
      
      private function __onItemOver(param1:MouseEvent) : void{}
      
      private function __onItemOut(param1:MouseEvent) : void{}
      
      private function __onItemClick(param1:MouseEvent) : void{}
      
      private function doTextButtonAction(param1:TextPanel, param2:String = "") : void{}
      
      public function get child_map() : WeakMap{return null;}
   }
}
