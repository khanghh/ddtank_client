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
       
      
      public function EvolutionUpCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function get tipStyle() : String
      {
         EvolutionCellUpGradeTips;
         return "store.fineStore.view.pageBringUp.evolution.EvolutionCellUpGradeTips";
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(param1)
         {
            addEnchantMc();
         }
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(!FineBringUpController.getInstance().usingLock)
         {
            SoundManager.instance.play("008");
            dragStart();
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!info || FineBringUpController.getInstance().usingLock)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc2_:LatentEnergyEvent = new LatentEnergyEvent("latentEnergy_equip_move2");
         _loc2_.info = info as InventoryItemInfo;
         _loc2_.moveType = 2;
         FineBringUpController.getInstance().dispatchEvent(_loc2_);
      }
      
      override protected function addEnchantMc() : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(info is InventoryItemInfo)
         {
            _loc4_ = info as InventoryItemInfo;
            _loc2_ = FineEvolutionManager.Instance.GetEvolutionDataByExp(_loc4_.curExp);
            if(_loc2_)
            {
               _loc1_ = _loc2_.Level;
               if(_loc1_ > 0)
               {
                  if(_loc1_ <= 4)
                  {
                     _loc3_ = 1;
                  }
                  if(_loc1_ >= 5 && _loc1_ <= 9)
                  {
                     _loc3_ = 2;
                  }
                  if(_loc1_ >= 10 && _loc1_ <= 15)
                  {
                     _loc3_ = 3;
                  }
                  if(_loc1_ >= 16 && _loc1_ <= 20)
                  {
                     _loc3_ = 4;
                  }
                  _enchantMc = ComponentFactory.Instance.creat(_enchantMcName + _loc3_);
                  var _loc5_:* = 1.48;
                  _enchantMc.scaleY = _loc5_;
                  _enchantMc.scaleX = _loc5_;
                  _enchantMc.x = -1;
                  _enchantMc.y = -1;
                  addChild(_enchantMc);
               }
            }
         }
      }
   }
}
