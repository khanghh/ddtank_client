package store.view.transfer
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class TransferItemCell extends StoreCell
   {
       
      
      private var _categoryID:Number = -1;
      
      private var _isComposeStrength:Boolean;
      
      private var _refinery:int = -1;
      
      public function TransferItemCell(i:int)
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         bg.addChild(bgBit);
         super(bg,i);
         _isComposeStrength = false;
         setContentSize(68,68);
         PicPos = new Point(-3,0);
      }
      
      override protected function addEnchantMc() : void
      {
         _enchantMcName = "asset.enchant.equip.level";
         _enchantMcPosStr = "enchant.transfer.equip.levelMcPos";
         super.addEnchantMc();
      }
      
      public function set Refinery(value:int) : void
      {
         _refinery = value;
      }
      
      public function get Refinery() : int
      {
         return _refinery;
      }
      
      public function set isComposeStrength(b:Boolean) : void
      {
         this._isComposeStrength = b;
      }
      
      public function set categoryId(i:Number) : void
      {
         this._categoryID = i;
      }
      
      private function checkComposeStrengthen() : Boolean
      {
         if(itemInfo.StrengthenLevel > 0)
         {
            return true;
         }
         if(itemInfo.AttackCompose > 0)
         {
            return true;
         }
         if(itemInfo.DefendCompose > 0)
         {
            return true;
         }
         if(itemInfo.LuckCompose > 0)
         {
            return true;
         }
         if(itemInfo.AgilityCompose > 0)
         {
            return true;
         }
         return false;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            effect.action = "none";
            if(!info.CanCompose && !info.CanStrengthen && !info.isCanLatentEnergy && info.CategoryID != 70)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.object"));
               return;
            }
            if(info.Level != 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.object"));
               return;
            }
            if(_isComposeStrength)
            {
               if(!checkComposeStrengthen())
               {
                  return;
               }
            }
            if(_categoryID > 0)
            {
               if(info.CategoryID != this._categoryID)
               {
                  if(info.CanEquip == 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.current"));
                     return;
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.put"));
                  return;
               }
            }
            if(info.CanEquip)
            {
               SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,index,1);
               DragManager.acceptDrag(this,"none");
               return;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.current"));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
