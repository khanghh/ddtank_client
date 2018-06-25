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
      
      public function HorseAmuletEquipCell(index:int, info:ItemTemplateInfo = null)
      {
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.equipCellBg");
         super(index,info,bg);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         this.addEventListener("interactive_click",__onMouseClick);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         if(_info)
         {
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            i = 20;
            while(i < 167)
            {
               info = PlayerManager.Instance.Self.horseAmuletBag.getItemAt(i);
               if(info == null)
               {
                  SocketManager.Instance.out.sendAmuletMove(this.place,i);
                  return;
               }
               i++;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.amuletBagTips"));
         }
      }
      
      public function set openLevel(value:int) : void
      {
         _openLevel = value;
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
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         var type1:int = 0;
         var type2:int = 0;
         if(isOpen)
         {
            info = effect.data as InventoryItemInfo;
            if(!HorseAmuletManager.instance.getHorseAmuletVo(info.TemplateID).IsCanWash)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.notEquip"));
               return;
            }
            if(effect && effect.action == "move" && effect.source is HorseAmuletCell && !(effect.source is HorseAmuletEquipCell))
            {
               type1 = HorseAmuletManager.instance.getHorseAmuletVo(info.TemplateID).ExtendType1;
               type2 = !!this.info?HorseAmuletManager.instance.getHorseAmuletVo(this.info.TemplateID).ExtendType1:-1;
               if(type1 != type2 && !HorseAmuletManager.instance.canEquipAmulet(info.TemplateID))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.typeTips"));
                  return;
               }
            }
            if(effect.source is HorseAmuletCell || effect.source is HorseAmuletEquipCell)
            {
               SocketManager.Instance.out.sendAmuletMove((effect.source as HorseAmuletCell).place,this.place);
            }
            DragManager.acceptDrag(this,"move");
         }
         else
         {
            DragManager.acceptDrag(this,"none");
         }
      }
      
      private function __onMouseClick(e:InteractiveEvent) : void
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
