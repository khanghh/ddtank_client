package latentEnergy
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SoundManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.DisplayObject;
   
   public class LatentEnergyEquipCell extends BagCell
   {
       
      
      private var _latentEnergyItemId:int;
      
      public function LatentEnergyEquipCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
      }
      
      public function set latentEnergyItemId(value:int) : void
      {
         _latentEnergyItemId = value;
         if(_tipData && _tipData is GoodTipInfo)
         {
            (_tipData as GoodTipInfo).latentEnergyItemId = _latentEnergyItemId;
         }
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(_tipData && _tipData is GoodTipInfo)
         {
            (_tipData as GoodTipInfo).latentEnergyItemId = _latentEnergyItemId;
         }
      }
      
      override public function get tipStyle() : String
      {
         return "latentEnergy.LatentEnergyPreTip";
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         LatentEnergyManager.instance.addEventListener("latentEnergy_equip_move",equipMoveHandler);
         LatentEnergyManager.instance.addEventListener("latentEnergy_equip_move2",equipMoveHandler2);
      }
      
      private function equipMoveHandler(event:LatentEnergyEvent) : void
      {
         var event2:* = null;
         if(info == event.info)
         {
            return;
         }
         if(info)
         {
            event2 = new LatentEnergyEvent("latentEnergy_equip_move2");
            event2.info = info as InventoryItemInfo;
            event2.moveType = 3;
            LatentEnergyManager.instance.dispatchEvent(event2);
         }
         info = event.info;
      }
      
      private function equipMoveHandler2(event:LatentEnergyEvent) : void
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
         var event:LatentEnergyEvent = new LatentEnergyEvent("latentEnergy_equip_move2");
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
         LatentEnergyManager.instance.removeEventListener("latentEnergy_equip_move",equipMoveHandler);
         LatentEnergyManager.instance.removeEventListener("latentEnergy_equip_move2",equipMoveHandler2);
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
            event = new LatentEnergyEvent("latentEnergy_equip_move2");
            event.info = info as InventoryItemInfo;
            event.moveType = 2;
            LatentEnergyManager.instance.dispatchEvent(event);
         }
      }
   }
}
