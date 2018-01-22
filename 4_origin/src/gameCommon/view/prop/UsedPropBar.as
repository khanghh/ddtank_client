package gameCommon.view.prop
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.events.LivingEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import gameCommon.model.Living;
   
   public class UsedPropBar extends Sprite implements Disposeable
   {
       
      
      private var _container:DisplayObjectContainer;
      
      private var _living:Living;
      
      private var _cells:Vector.<DisplayObject>;
      
      public function UsedPropBar()
      {
         super();
      }
      
      private function clearCells() : void
      {
      }
      
      public function setInfo(param1:Living) : void
      {
         clearCells();
         var _loc2_:Living = _living;
         _living = _living;
         addEventToLiving(_living);
         if(_loc2_ != null)
         {
            removeEventFromLiving(_loc2_);
         }
      }
      
      private function addEventToLiving(param1:Living) : void
      {
         param1.addEventListener("usingItem",__usingItem);
      }
      
      private function __usingItem(param1:LivingEvent) : void
      {
      }
      
      private function removeEventFromLiving(param1:Living) : void
      {
         param1.removeEventListener("usingItem",__usingItem);
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
