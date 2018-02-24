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
       
      
      public function LatentEnergyItemCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      override protected function createChildren() : void{}
      
      override protected function initEvent() : void{}
      
      private function itemMoveHandler(param1:LatentEnergyEvent) : void{}
      
      private function itemMoveHandler2(param1:LatentEnergyEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      public function clearInfo() : void{}
   }
}
