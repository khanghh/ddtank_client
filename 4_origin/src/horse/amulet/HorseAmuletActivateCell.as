package horse.amulet
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletActivateCell extends HorseAmuletCell
   {
       
      
      private var _bag:BagInfo;
      
      public function HorseAmuletActivateCell()
      {
         super(19,null,createBg());
         init();
      }
      
      private function init() : void
      {
         _bag = PlayerManager.Instance.Self.getBag(42);
         this.info = _bag.getItemAt(19);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         _bag.addEventListener("update",__updateGoods);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1 && param1.action == "move" && param1.data)
         {
            _loc3_ = param1.data as InventoryItemInfo;
            if(param1.source is HorseAmuletCell)
            {
               _loc2_ = HorseAmuletManager.instance.getHorseAmuletVo((param1.source as HorseAmuletCell).itemInfo.TemplateID);
               if(_loc2_.IsCanWash)
               {
                  SocketManager.Instance.out.sendAmuletMove((param1.source as HorseAmuletCell).place,this.place);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateFail"));
                  DragManager.acceptDrag(null,"none");
                  return;
               }
            }
            DragManager.acceptDrag(this,"move");
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         DragManager.acceptDrag(this,"none");
      }
      
      private function __updateGoods(param1:BagEvent) : void
      {
         var _loc3_:Dictionary = param1.changedSlots;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.Place == 19)
            {
               this.info = _bag.getItemAt(_loc2_.Place);
            }
         }
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(_info)
         {
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            clearCell();
         }
      }
      
      public function clearCell() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(this.info == null)
         {
            return;
         }
         _loc2_ = 20;
         while(_loc2_ < 167)
         {
            _loc1_ = PlayerManager.Instance.Self.horseAmuletBag.getItemAt(_loc2_);
            if(_loc1_ == null)
            {
               SocketManager.Instance.out.sendAmuletMove(19,_loc2_);
               return;
            }
            _loc2_++;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.amuletBagTips"));
      }
      
      private function createBg() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,75,75);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         this.removeEventListener("interactive_double_click",__doubleClickHandler);
         _bag.removeEventListener("update",__updateGoods);
         _bag = null;
         DoubleClickManager.Instance.disableDoubleClick(this);
         super.dispose();
      }
   }
}
