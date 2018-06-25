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
       
      
      public function WishBeadItemCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("wishBeadMainView.itemCell.countTxt");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         WishBeadManager.instance.addEventListener("wishBead_item_move",itemMoveHandler);
         WishBeadManager.instance.addEventListener("wishBead_item_move2",itemMoveHandler2);
      }
      
      private function itemMoveHandler(event:WishBeadEvent) : void
      {
         var event2:* = null;
         if(info == event.info)
         {
            return;
         }
         if(info)
         {
            event2 = new WishBeadEvent("wishBead_item_move2");
            event2.info = info as InventoryItemInfo;
            event2.moveType = 3;
            WishBeadManager.instance.dispatchEvent(event2);
         }
         info = event.info;
      }
      
      private function itemMoveHandler2(event:WishBeadEvent) : void
      {
         if(info != event.info || event.moveType != 2)
         {
            return;
         }
         info = null;
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!info)
         {
            return;
         }
         SoundManager.instance.play("008");
         var event:WishBeadEvent = new WishBeadEvent("wishBead_item_move2");
         event.info = info as InventoryItemInfo;
         event.moveType = 2;
         WishBeadManager.instance.dispatchEvent(event);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         WishBeadManager.instance.removeEventListener("wishBead_item_move",itemMoveHandler);
         WishBeadManager.instance.removeEventListener("wishBead_item_move2",itemMoveHandler2);
      }
      
      protected function __clickHandler(evt:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         dragStart();
      }
      
      public function clearInfo() : void
      {
         var event:* = null;
         if(info)
         {
            event = new WishBeadEvent("wishBead_item_move2");
            event.info = info as InventoryItemInfo;
            event.moveType = 2;
            WishBeadManager.instance.dispatchEvent(event);
         }
      }
   }
}
