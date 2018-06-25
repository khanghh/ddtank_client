package latentEnergy
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
   
   public class LatentEnergyItemCell extends BagCell
   {
       
      
      public function LatentEnergyItemCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
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
         _tbxCount = ComponentFactory.Instance.creat("latentEnergyFrame.itemCell.countTxt");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         LatentEnergyManager.instance.addEventListener("latentEnergy_item_move",itemMoveHandler);
         LatentEnergyManager.instance.addEventListener("latentEnergy_item_move2",itemMoveHandler2);
      }
      
      private function itemMoveHandler(event:LatentEnergyEvent) : void
      {
         var event2:* = null;
         if(info == event.info)
         {
            return;
         }
         if(info)
         {
            event2 = new LatentEnergyEvent("latentEnergy_item_move2");
            event2.info = info as InventoryItemInfo;
            event2.moveType = 3;
            LatentEnergyManager.instance.dispatchEvent(event2);
         }
         info = event.info;
      }
      
      private function itemMoveHandler2(event:LatentEnergyEvent) : void
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
         var event:LatentEnergyEvent = new LatentEnergyEvent("latentEnergy_item_move2");
         event.info = info as InventoryItemInfo;
         event.moveType = 2;
         LatentEnergyManager.instance.dispatchEvent(event);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_item_move",itemMoveHandler);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_item_move2",itemMoveHandler2);
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
            event = new LatentEnergyEvent("latentEnergy_item_move2");
            event.info = info as InventoryItemInfo;
            event.moveType = 2;
            LatentEnergyManager.instance.dispatchEvent(event);
         }
      }
   }
}
