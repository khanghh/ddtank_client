package morn.core.managers{   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import morn.core.events.DragEvent;      public class DragManager   {                   private var _dragInitiator:DisplayObject;            private var _dragImage:Sprite;            private var _data;            public function DragManager() { super(); }
            public function doDrag(dragInitiator:Sprite, dragImage:Sprite = null, data:* = null, offset:Point = null) : void { }
            private function onStageMouseMove(e:MouseEvent) : void { }
            private function onStageMouseUp(e:Event) : void { }
            private function getDropTarget(value:DisplayObject) : DisplayObject { return null; }
   }}