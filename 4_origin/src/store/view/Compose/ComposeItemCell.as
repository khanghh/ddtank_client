package store.view.Compose
{
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
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
   
   public class ComposeItemCell extends StoreCell
   {
      
      public static const COMPOSE_TOP:int = 50;
       
      
      public function ComposeItemCell($index:int)
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
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(!info.CanCompose)
         {
            return;
         }
         if(info && effect.action != "split")
         {
            effect.action = "none";
            if(info.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
            }
            else
            {
               if(info.AgilityCompose == 50 && info.DefendCompose == 50 && info.AttackCompose == 50 && info.LuckCompose == 50)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.ComposeItemCell.up"));
                  return;
               }
               SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,index,1);
               effect.action = "none";
               DragManager.acceptDrag(this);
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
