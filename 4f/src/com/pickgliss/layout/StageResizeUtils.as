package com.pickgliss.layout{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import flash.display.DisplayObject;   import flash.events.Event;      public class StageResizeUtils   {            private static var _instance:StageResizeUtils;                   private var _autoResizeDic:Array;            private var isOpen:Boolean = true;            private var stageWidth:Number;            private var stageHeight:Number;            public function StageResizeUtils() { super(); }
            public static function get Instance() : StageResizeUtils { return null; }
            public function setup() : void { }
            private function __onResize(event:Event) : void { }
            public function addAutoResize($target:DisplayObject, $isPStage:Boolean = true) : void { }
            public function addAutoResizeByStyle($target:DisplayObject, $customStyleName:String, $isPStage:Boolean = true) : void { }
            public function autoCenterResizeByStyle($target:DisplayObject, $isPStage:Boolean = true) : void { }
            private function removeAutoResize($key:String) : void { }
            private function autoResize() : void { }
            private function resizeTarget(objInfo:ResizeObjInfo) : void { }
            private function convertPercent(numStr:String, parentNum:Number) : Number { return 0; }
            private function autoResizeClear() : void { }
            private function addResizeObjInfo(objInfo:ResizeObjInfo) : void { }
            private function getIndex() : int { return 0; }
            private function targetKey($target:DisplayObject) : String { return null; }
            public function removeResizeObj($target:DisplayObject) : void { }
   }}import flash.display.DisplayObject;class ResizeObjInfo{          public var target:DisplayObject;      public var customStyleName:String;      public var isPercent:Boolean;      public var xPercent:Number = 1;      public var yPercent:Number = 1;      public var isPStage:Boolean;      public var targetWidth:Number = 0;      public var targetHeight:Number = 0;      function ResizeObjInfo() { super(); }
}