package store.fineStore.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.EquipGhostData;
   import store.equipGhost.data.GhostData;
   
   public class GhostItemCell extends StoreCell
   {
       
      
      public function GhostItemCell($index:int)
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         bg.addChild(bgBit);
         super(bg,$index);
         setContentSize(68,68);
         PicPos = new Point(-3,0);
      }
      
      override protected function addEnchantMc() : void
      {
         _enchantMcName = "asset.enchant.equip.level";
         _enchantMcPosStr = "enchant.compose.equip.levelMcPos";
         super.addEnchantMc();
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var equipIDs:* = null;
         var ghost:* = null;
         var isUp:* = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            equipIDs = [1,5,7];
            if(equipIDs.indexOf(info.CategoryID) == -1)
            {
               effect.action = "none";
               return;
            }
            ghost = PlayerManager.Instance.Self.getGhostDataByCategoryID(info.CategoryID);
            if(ghost)
            {
               isUp = ghost.level >= EquipGhostManager.getInstance().model.topLvDic[ghost.categoryID];
               if(isUp)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.upLevel"));
                  effect.action = "none";
                  return;
               }
            }
            EquipGhostManager.getInstance().chooseEquip(info);
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,index,1);
            effect.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         var data:* = null;
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((evt.currentTarget as BagCell).info != null)
         {
            data = EquipGhostManager.getInstance().model.getGhostData(info.CategoryID,1);
            if(data != null)
            {
               SocketManager.Instance.out.sendMoveGoods(12,index,data.bagType,data.place,1);
            }
            EquipGhostManager.getInstance().clearEquip();
            if(!mouseSilenced)
            {
               SoundManager.instance.play("008");
            }
         }
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         tipStyle = "ddtstore.GhostTips";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
