package email.view
{
   import auctionHouse.event.AuctionSellEvent;
   import auctionHouse.view.AuctionSellLeftAler;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.events.MouseEvent;
   import mark.data.MarkChipData;
   
   public class EmaillBagCell extends LinkedBagCell
   {
       
      
      private var _temporaryCount:int;
      
      private var _temporaryInfo:InventoryItemInfo;
      
      private var _goodsCount:int;
      
      private var _markInfo:MarkChipData;
      
      public function EmaillBagCell()
      {
         super(null);
         _goodsCount = 1;
         _bg.alpha = 0;
      }
      
      public function set markInfo(param1:MarkChipData) : void
      {
         _markInfo = param1;
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc3_ && param1.action == "move")
         {
            param1.action = "none";
            if(_loc3_.CategoryID == 74)
            {
               _goodsCount = 1;
               bagCell = param1.source as BagCell;
               param1.action = "link";
            }
            else if(_loc3_.IsBinds)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.EmaillIIBagCell.isBinds"));
            }
            else if(_loc3_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.EmaillIIBagCell.RemainDate"));
            }
            else
            {
               _goodsCount = 1;
               bagCell = param1.source as BagCell;
               param1.action = "link";
               _temporaryCount = bagCell.itemInfo.Count;
               _temporaryInfo = bagCell.itemInfo;
               if(bagCell.locked == false)
               {
                  bagCell.locked = true;
                  return;
               }
               if(bagCell.itemInfo.Count > 1)
               {
                  _loc2_ = ComponentFactory.Instance.creat("auctionHouse.AuctionSellLeftAler");
                  _loc2_.titleText = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagBreak");
                  _loc2_.show(_temporaryInfo.Count);
                  _loc2_.addEventListener("sell",_alerSell);
                  _loc2_.addEventListener("notsell",_alerNotSell);
               }
            }
            DragManager.acceptDrag(this);
         }
      }
      
      private function _alerSell(param1:AuctionSellEvent) : void
      {
         var _loc2_:AuctionSellLeftAler = param1.currentTarget as AuctionSellLeftAler;
         _temporaryInfo.Count = param1.sellCount;
         _goodsCount = param1.sellCount;
         info = _temporaryInfo;
         if(bagCell)
         {
            bagCell.itemInfo.Count = _temporaryCount;
         }
         _loc2_.dispose();
         if(_loc2_ && _loc2_.parent)
         {
            removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      private function _alerNotSell(param1:AuctionSellEvent) : void
      {
         var _loc2_:AuctionSellLeftAler = param1.currentTarget as AuctionSellLeftAler;
         info = null;
         bagCell.locked = false;
         bagCell = null;
         _loc2_.dispose();
         if(_loc2_ && _loc2_.parent)
         {
            removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      override public function updateCount() : void
      {
         if(_tbxCount == null)
         {
            return;
         }
         if(_info && itemInfo && itemInfo.MaxCount > 1)
         {
            _tbxCount.visible = true;
            _tbxCount.text = String(itemInfo.Count);
            addChild(_tbxCount);
         }
         else
         {
            _tbxCount.visible = false;
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         buttonMode = true;
         super.onMouseOver(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get goodsCount() : int
      {
         return _goodsCount;
      }
   }
}
