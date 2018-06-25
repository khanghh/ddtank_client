package yzhkof.debug{   import flash.desktop.Clipboard;   import flash.desktop.ClipboardFormats;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.Sprite;   import flash.display.Stage;   import flash.events.ContextMenuEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.net.FileReference;   import flash.sampler.getMemberNames;   import flash.system.System;   import flash.ui.ContextMenuItem;   import flash.utils.ByteArray;   import flash.utils.getDefinitionByName;   import flash.utils.getQualifiedClassName;   import flash.utils.getQualifiedSuperclassName;   import mx.graphics.codec.PNGEncoder;   import yzhkof.KeyMy;   import yzhkof.MyGC;   import yzhkof.MyGraphy;   import yzhkof.ToolBitmapData;   import yzhkof.guxi.FocusViewer;   import yzhkof.guxi.GraphicArea;   import yzhkof.ui.ComponentBase;   import yzhkof.ui.TextPanel;   import yzhkof.ui.TileContainer;   import yzhkof.util.DebugUtil;   import yzhkof.util.RightMenuUtil;   import yzhkof.util.WeakMap;      public class DebugDisplayObjectViewer extends ComponentBase   {            public static var SIMPLE:String = "simple";            public static var DETAIL:String = "detail";                   private var container:TileContainer;            private var btn_container:TileContainer;            private var _currentLeaf:WeakMap;            private var _latestLeaf:WeakMap;            private var dictionary_viewer:DebugDisplayObjectDctionary;            private var currentRefreshType:String = "simple";            private var _drager:DebugDrag;            private var _stage:Stage;            private var _child_map:WeakMap;            private var fold_btn:TextPanel;            private var back_btn:TextPanel;            private var stage_btn:TextPanel;            private var mode_btn_a:TextPanel;            private var mode_btn_b:TextPanel;            private var text_btn:TextPanel;            private var script_btn:TextPanel;            private var refresh_btn:TextPanel;            private var focus_btn:TextPanel;            private var gc_btn:TextPanel;            private var log_btn:TextPanel;            private var weak_log_btn:TextPanel;            private var focus_txt:TextPanel;            private var x_btn:TextPanel;            private var mode_container:Sprite;            private var mask_background:Sprite;            private var viewer:SnapshotDisplayViewer;            private var watcher_btn:TextPanel;            private var _fileReference:FileReference;            private var reference_arr:Array;            private var _locateGraph:GraphicArea;            public function DebugDisplayObjectViewer(_stage:Stage) { super(); }
            private function set currentLeaf(value:*) : void { }
            private function get currentLeaf() : * { return null; }
            private function set latestLeaf(value:*) : void { }
            private function get latestLeaf() : * { return null; }
            private function init() : void { }
            private function setMaskBackGround(dobj:Sprite) : void { }
            private function initEvent() : void { }
            override protected function onDraw() : void { }
            private function __onStageClick(e:MouseEvent) : void { }
            public function Goto(obj:*, select:Boolean = false) : void { }
            public function view(dobj:DisplayObject) : void { }
            public function savePNG(dobj:DisplayObject) : void { }
            private function getTextPanel(obj:*) : TextPanel { return null; }
            private function refresh(type:String = "") : void { }
            public function checkGC() : void { }
            public function getDebugTextButton(obj:*, text:String) : TextPanel { return null; }
            private function addTextButtonRightMenu(text_panel:TextPanel, obj:*) : void { }
            private function __rightMenuClick(event:ContextMenuEvent) : void { }
            private function __onItemOver(e:MouseEvent) : void { }
            private function __onItemOut(event:MouseEvent) : void { }
            private function __onItemClick(e:MouseEvent) : void { }
            private function doTextButtonAction(target:TextPanel, rightMenuName:String = "") : void { }
            public function get child_map() : WeakMap { return null; }
   }}