package store.forge.wishBead
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   
   public class WishBeadItemCell extends BagCell
   {
       
      
      public function WishBeadItemCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      override protected function createChildren() : void{}
      
      override protected function initEvent() : void{}
      
      private function itemMoveHandler(param1:WishBeadEvent) : void{}
      
      private function itemMoveHandler2(param1:WishBeadEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      public function clearInfo() : void{}
   }
}
