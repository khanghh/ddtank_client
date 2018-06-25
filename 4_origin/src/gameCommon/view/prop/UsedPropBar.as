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
      
      public function setInfo(living:Living) : void
      {
         clearCells();
         var lv:Living = _living;
         _living = _living;
         addEventToLiving(_living);
         if(lv != null)
         {
            removeEventFromLiving(lv);
         }
      }
      
      private function addEventToLiving(living:Living) : void
      {
         living.addEventListener("usingItem",__usingItem);
      }
      
      private function __usingItem(evt:LivingEvent) : void
      {
      }
      
      private function removeEventFromLiving(living:Living) : void
      {
         living.removeEventListener("usingItem",__usingItem);
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
