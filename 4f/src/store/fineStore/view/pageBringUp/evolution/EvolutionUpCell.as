package store.fineStore.view.pageBringUp.evolution
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   import store.FineEvolutionManager;
   import store.data.EvolutionData;
   import store.fineStore.view.pageBringUp.FineBringUpCell;
   
   public class EvolutionUpCell extends FineBringUpCell
   {
       
      
      public function EvolutionUpCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      override public function get tipStyle() : String{return null;}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function addEnchantMc() : void{}
   }
}
