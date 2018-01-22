package horse.amulet
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import horse.HorseAmuletManager;
   import horse.HorseManager;
   
   public class HorseAmuletEquipCell extends HorseAmuletCell
   {
       
      
      private var _openLevel:int;
      
      private var _lockBg:Bitmap;
      
      public function HorseAmuletEquipCell(param1:int, param2:ItemTemplateInfo = null)
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.equipCellBg");
         super(param1,param2,_loc3_);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         this.addEventListener("interactive_click",__onMouseClick);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_info)
         {
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc3_ = 20;
            while(_loc3_ < 167)
            {
               _loc2_ = PlayerManager.Instance.Self.horseAmuletBag.getItemAt(_loc3_);
               if(_loc2_ == null)
               {
                  SocketManager.Instance.out.sendAmuletMove(this.place,_loc3_);
                  return;
               }
               _loc3_++;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.amuletBagTips"));
         }
      }
      
      public function set openLevel(param1:int) : void
      {
         _openLevel = param1;
         if(isOpen == false)
         {
            if(_lockBg == null)
            {
               _lockBg = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.cellLock");
               addChild(_lockBg);
            }
            _lockBg.visible = true;
            tipStyle = "ddt.view.tips.OneLineTip";
            tipData = LanguageMgr.GetTranslation("tank.horseAmulet.levelTips",_openLevel);
         }
         else
         {
            this.tipData = null;
            this.tipStyle = null;
            if(_lockBg)
            {
               _lockBg.visible = false;
            }
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _openLevel <= HorseManager.instance.curLevel;
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(isOpen)
         {
            _loc4_ = param1.data as InventoryItemInfo;
            if(!HorseAmuletManager.instance.getHorseAmuletVo(_loc4_.TemplateID).IsCanWash)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.notEquip"));
               return;
            }
            if(param1 && param1.action == "move" && param1.source is HorseAmuletCell && !(param1.source is HorseAmuletEquipCell))
            {
               _loc2_ = HorseAmuletManager.instance.getHorseAmuletVo(_loc4_.TemplateID).ExtendType1;
               _loc3_ = !!this.info?HorseAmuletManager.instance.getHorseAmuletVo(this.info.TemplateID).ExtendType1:-1;
               if(_loc2_ != _loc3_ && !HorseAmuletManager.instance.canEquipAmulet(_loc4_.TemplateID))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.typeTips"));
                  return;
               }
            }
            if(param1.source is HorseAmuletCell || param1.source is HorseAmuletEquipCell)
            {
               SocketManager.Instance.out.sendAmuletMove((param1.source as HorseAmuletCell).place,this.place);
            }
            DragManager.acceptDrag(this,"move");
         }
         else
         {
            DragManager.acceptDrag(this,"none");
         }
      }
      
      private function __onMouseClick(param1:InteractiveEvent) : void
      {
         if(isOpen)
         {
            this.dragStart();
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         this.removeEventListener("interactive_click",__onMouseClick);
         this.removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_lockBg);
         super.dispose();
         _lockBg = null;
      }
   }
}
