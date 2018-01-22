package store.view.fusion
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
   import store.StoreCell;
   
   public class AccessoryItemCell extends StoreCell
   {
       
      
      public function AccessoryItemCell(param1:int)
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.GoodPanelSmall");
         _loc2_.addChild(_loc3_);
         super(_loc2_,param1);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_.BagType == 12 && info != null)
         {
            return;
         }
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc2_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.overdue"));
            }
            else if(_loc2_.FusionType == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.fusion"));
            }
            else
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,1);
               param1.action = "none";
               DragManager.acceptDrag(this);
            }
         }
      }
   }
}
