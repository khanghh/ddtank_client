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
      
      public function DragManager()
      {
         super();
      }
      
      public function doDrag(dragInitiator:Sprite, dragImage:Sprite = null, data:* = null, offset:Point = null) : void
      {
         var p:* = null;
         _dragInitiator = dragInitiator;
         _dragImage = !!dragImage?dragImage:dragInitiator;
         _data = data;
         if(_dragImage != _dragInitiator)
         {
            if(!_dragImage.parent)
            {
               App.stage.addChild(_dragImage);
            }
            offset = offset || new Point();
            p = _dragImage.globalToLocal(new Point(App.stage.mouseX,App.stage.mouseY));
            _dragImage.x = p.x - offset.x;
            _dragImage.y = p.y - offset.y;
            _dragImage.visible = false;
         }
         App.stage.addEventListener("mouseMove",onStageMouseMove);
         App.stage.addEventListener("mouseUp",onStageMouseUp);
      }
      
      private function onStageMouseMove(e:MouseEvent) : void
      {
         if(!_dragImage.visible)
         {
            _dragImage.visible = true;
            _dragImage.startDrag();
            _dragInitiator.dispatchEvent(new DragEvent("dragStart",_dragInitiator,_data));
         }
         if(e.stageX <= 0 || e.stageX >= App.stage.stageWidth || e.stageY <= 0 || e.stageY >= App.stage.stageHeight)
         {
            _dragImage.stopDrag();
         }
         else
         {
            _dragImage.startDrag();
         }
      }
      
      private function onStageMouseUp(e:Event) : void
      {
         App.stage.removeEventListener("mouseMove",onStageMouseMove);
         App.stage.removeEventListener("mouseUp",onStageMouseUp);
         _dragImage.stopDrag();
         var dropTarget:DisplayObject = getDropTarget(_dragImage.dropTarget);
         if(dropTarget)
         {
            dropTarget.dispatchEvent(new DragEvent("dragDrop",_dragInitiator,_data));
         }
         _dragInitiator.dispatchEvent(new DragEvent("dragComplete",_dragInitiator,_data));
         if(_dragInitiator != _dragImage && _dragImage.parent)
         {
            _dragImage.parent.removeChild(_dragImage);
         }
         _dragInitiator = null;
         _data = null;
         _dragImage = null;
      }
      
      private function getDropTarget(value:DisplayObject) : DisplayObject
      {
         while(value)
         {
            if(value.hasEventListener("dragDrop"))
            {
               return value;
            }
            value = value.parent;
         }
         return null;
      }
   }
}
