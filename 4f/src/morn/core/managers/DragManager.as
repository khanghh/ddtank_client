package morn.core.managers
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import morn.core.events.DragEvent;
   
   public class DragManager
   {
       
      
      private var _dragInitiator:DisplayObject;
      
      private var _dragImage:Sprite;
      
      private var _data;
      
      public function DragManager(){super();}
      
      public function doDrag(param1:Sprite, param2:Sprite = null, param3:* = null, param4:Point = null) : void{}
      
      private function onStageMouseMove(param1:MouseEvent) : void{}
      
      private function onStageMouseUp(param1:Event) : void{}
      
      private function getDropTarget(param1:DisplayObject) : DisplayObject{return null;}
   }
}
