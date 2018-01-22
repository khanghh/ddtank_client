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
       
      
      public function GhostItemCell(param1:int)
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         _loc2_.addChild(_loc3_);
         super(_loc2_,param1);
         setContentSize(68,68);
         PicPos = new Point(-3,0);
      }
      
      override protected function addEnchantMc() : void
      {
         _enchantMcName = "asset.enchant.equip.level";
         _enchantMcPosStr = "enchant.compose.equip.levelMcPos";
         super.addEnchantMc();
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc5_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc5_ && param1.action != "split")
         {
            _loc4_ = [1,5,7];
            if(_loc4_.indexOf(_loc5_.CategoryID) == -1)
            {
               param1.action = "none";
               return;
            }
            _loc3_ = PlayerManager.Instance.Self.getGhostDataByCategoryID(_loc5_.CategoryID);
            if(_loc3_)
            {
               _loc2_ = _loc3_.level >= EquipGhostManager.getInstance().model.topLvDic[_loc3_.categoryID];
               if(_loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.upLevel"));
                  param1.action = "none";
                  return;
               }
            }
            EquipGhostManager.getInstance().chooseEquip(_loc5_);
            SocketManager.Instance.out.sendMoveGoods(_loc5_.BagType,_loc5_.Place,12,index,1);
            param1.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((param1.currentTarget as BagCell).info != null)
         {
            _loc2_ = EquipGhostManager.getInstance().model.getGhostData(info.CategoryID,1);
            if(_loc2_ != null)
            {
               SocketManager.Instance.out.sendMoveGoods(12,index,_loc2_.bagType,_loc2_.place,1);
            }
            EquipGhostManager.getInstance().clearEquip();
            if(!mouseSilenced)
            {
               SoundManager.instance.play("008");
            }
         }
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         tipStyle = "ddtstore.GhostTips";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
