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
       
      
      public function RetrieveBagcell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:Sprite = null)
      {
         super(index,info,showLoading,bg);
         _isShowIsUsedBitmap = true;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         var obj:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            effect.action = "none";
            super.dragStop(effect);
            return;
         }
         if(effect.data is InventoryItemInfo)
         {
            info = effect.data as InventoryItemInfo;
            if(locked)
            {
               if(info == this.info)
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
               if(_bagType == 11 || info.BagType == 11)
               {
                  if(effect.action == "split")
                  {
                     effect.action = "none";
                  }
                  else if(_bagType != 11)
                  {
                     SocketManager.Instance.out.sendMoveGoods(11,info.Place,_bagType,place,info.Count);
                     effect.action = "none";
                  }
                  else if(_bagType == info.BagType)
                  {
                     if(place >= PlayerManager.Instance.Self.consortiaInfo.StoreLevel * 10)
                     {
                        effect.action = "none";
                     }
                     else
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,info.Count);
                     }
                  }
                  else if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel < 1)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick"));
                     effect.action = "none";
                  }
                  else
                  {
                     SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,_bagType,place,info.Count);
                     effect.action = "none";
                  }
               }
               else if(info.BagType == _bagType)
               {
                  SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,info.BagType,place,-1);
                  effect.action = "none";
               }
               else if(info.BagType != _bagType)
               {
                  obj = RetrieveModel.Instance.getSaveCells(info.Place);
                  SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,obj.BagType,obj.Place,info.Count);
                  effect.action = "none";
               }
               DragManager.acceptDrag(this);
            }
         }
         else if(effect.data is SellGoodsBtn)
         {
            if(!locked && _info && this._bagType != 11)
            {
               locked = true;
               DragManager.acceptDrag(this);
            }
         }
         else if(effect.data is BreakGoodsBtn)
         {
            if(!locked && _info)
            {
               DragManager.acceptDrag(this);
            }
         }
         info = null;
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
