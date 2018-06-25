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
       
      
      public function EvolutionUpCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
      }
      
      override public function get tipStyle() : String
      {
         EvolutionCellUpGradeTips;
         return "store.fineStore.view.pageBringUp.evolution.EvolutionCellUpGradeTips";
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(value)
         {
            addEnchantMc();
         }
      }
      
      override protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if(!FineBringUpController.getInstance().usingLock)
         {
            SoundManager.instance.play("008");
            dragStart();
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!info || FineBringUpController.getInstance().usingLock)
         {
            return;
         }
         SoundManager.instance.play("008");
         var event:LatentEnergyEvent = new LatentEnergyEvent("latentEnergy_equip_move2");
         event.info = info as InventoryItemInfo;
         event.moveType = 2;
         FineBringUpController.getInstance().dispatchEvent(event);
      }
      
      override protected function addEnchantMc() : void
      {
         var _info:* = null;
         var data:* = null;
         var mcLevel:int = 0;
         var _lv:int = 0;
         if(info is InventoryItemInfo)
         {
            _info = info as InventoryItemInfo;
            data = FineEvolutionManager.Instance.GetEvolutionDataByExp(_info.curExp);
            if(data)
            {
               mcLevel = data.Level;
               if(mcLevel > 0)
               {
                  if(mcLevel <= 4)
                  {
                     _lv = 1;
                  }
                  if(mcLevel >= 5 && mcLevel <= 9)
                  {
                     _lv = 2;
                  }
                  if(mcLevel >= 10 && mcLevel <= 15)
                  {
                     _lv = 3;
                  }
                  if(mcLevel >= 16 && mcLevel <= 20)
                  {
                     _lv = 4;
                  }
                  _enchantMc = ComponentFactory.Instance.creat(_enchantMcName + _lv);
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
