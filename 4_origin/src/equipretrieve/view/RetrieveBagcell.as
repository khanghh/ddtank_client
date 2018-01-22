package equipretrieve.view
{
   import bagAndInfo.bag.BreakGoodsBtn;
   import bagAndInfo.bag.SellGoodsBtn;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import equipretrieve.RetrieveModel;
   import flash.display.Sprite;
   
   public class RetrieveBagcell extends BagCell
   {
       
      
      public function RetrieveBagcell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Sprite = null)
      {
         super(param1,param2,param3,param4);
         _isShowIsUsedBitmap = true;
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            param1.action = "none";
            super.dragStop(param1);
            return;
         }
         if(param1.data is InventoryItemInfo)
         {
            _loc3_ = param1.data as InventoryItemInfo;
            if(locked)
            {
               if(_loc3_ == this.info)
               {
                  this.locked = false;
                  DragManager.acceptDrag(this);
               }
               else
               {
                  DragManager.acceptDrag(this,"none");
               }
            }
            else
            {
               if(_bagType == 11 || _loc3_.BagType == 11)
               {
                  if(param1.action == "split")
                  {
                     param1.action = "none";
                  }
                  else if(_bagType != 11)
                  {
                     SocketManager.Instance.out.sendMoveGoods(11,_loc3_.Place,_bagType,place,_loc3_.Count);
                     param1.action = "none";
                  }
                  else if(_bagType == _loc3_.BagType)
                  {
                     if(place >= PlayerManager.Instance.Self.consortiaInfo.StoreLevel * 10)
                     {
                        param1.action = "none";
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,_loc3_.BagType,place,_loc3_.Count);
                     }
                  }
                  else if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel < 1)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick"));
                     param1.action = "none";
                  }
                  else
                  {
                     SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,_bagType,place,_loc3_.Count);
                     param1.action = "none";
                  }
               }
               else if(_loc3_.BagType == _bagType)
               {
                  SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,_loc3_.BagType,place,-1);
                  param1.action = "none";
               }
               else if(_loc3_.BagType != _bagType)
               {
                  _loc2_ = RetrieveModel.Instance.getSaveCells(_loc3_.Place);
                  SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,_loc2_.BagType,_loc2_.Place,_loc3_.Count);
                  param1.action = "none";
               }
               DragManager.acceptDrag(this);
            }
         }
         else if(param1.data is SellGoodsBtn)
         {
            if(!locked && _info && this._bagType != 11)
            {
               locked = true;
               DragManager.acceptDrag(this);
            }
         }
         else if(param1.data is BreakGoodsBtn)
         {
            if(!locked && _info)
            {
               DragManager.acceptDrag(this);
            }
         }
         _loc3_ = null;
      }
      
      private function get itemBagType() : int
      {
         if(info && (info.CategoryID == 10 || info.CategoryID == 11 || info.CategoryID == 12))
         {
            return 1;
         }
         return 0;
      }
   }
}
