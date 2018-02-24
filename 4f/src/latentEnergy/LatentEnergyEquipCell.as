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
      
      public function LatentEnergyEquipCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      public function set latentEnergyItemId(param1:int) : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function get tipStyle() : String{return null;}
      
      override protected function initEvent() : void{}
      
      private function equipMoveHandler(param1:LatentEnergyEvent) : void{}
      
      private function equipMoveHandler2(param1:LatentEnergyEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function removeEvent() : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      public function clearInfo() : void{}
   }
}
