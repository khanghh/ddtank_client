package auctionHouse.view
{
   import auctionHouse.event.AuctionSellEvent;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class AuctionCellView extends LinkedBagCell
   {
      
      public static const SELECT_BID_GOOD:String = "selectBidGood";
      
      public static const SELECT_GOOD:String = "selectGood";
      
      public static const CELL_MOUSEOVER:String = "Cell_mouseOver";
      
      public static const CELL_MOUSEOUT:String = "Cell_mouseOut";
       
      
      private var _picRect:Rectangle;
      
      private var _temporaryInfo:InventoryItemInfo;
      
      private var _temporaryCount:int;
      
      private var _goodsCount:int;
      
      public function AuctionCellView()
      {
         _goodsCount = 1;
         var _loc1_:Sprite = new Sprite();
         _loc1_.addChild(ComponentFactory.Instance.creatBitmap("asset.auctionHouse.CellBgIIAsset"));
         super(_loc1_);
         tipDirctions = "7";
         (_bg as Sprite).graphics.beginFill(0,0);
         (_bg as Sprite).graphics.drawRect(-5,-5,203,55);
         (_bg as Sprite).graphics.endFill();
         _picRect = ComponentFactory.Instance.creatCustomObject("auctionHouse.sell.cell.PicRect");
         PicPos = _picRect.topLeft;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
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
         if(_loc3_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc3_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionCellView.Object"));
            }
            else if(_loc3_.IsBinds)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionCellView.Sale"));
            }
            else
            {
               _goodsCount = 1;
               bagCell = param1.source as BagCell;
               _temporaryCount = bagCell.itemInfo.Count;
               _temporaryInfo = bagCell.itemInfo;
               if(bagCell.itemInfo.Count > 1)
               {
                  _loc2_ = ComponentFactory.Instance.creat("auctionHouse.AuctionSellLeftAler");
                  _loc2_.show(_temporaryInfo.Count);
                  _loc2_.addEventListener("sell",_alerSell);
                  _loc2_.addEventListener("notsell",_alerNotSell);
               }
               DragManager.acceptDrag(bagCell,"link");
            }
         }
      }
      
      private function _alerSell(param1:AuctionSellEvent) : void
      {
         var _loc2_:AuctionSellLeftAler = param1.currentTarget as AuctionSellLeftAler;
         _goodsCount = param1.sellCount;
         _temporaryInfo.Count = param1.sellCount;
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
      
      public function get goodsCount() : int
      {
         return _goodsCount;
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         super.dragStop(param1);
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
         super.onMouseClick(param1);
         dispatchEvent(new Event("selectBidGood"));
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("Cell_mouseOver"));
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("Cell_mouseOut"));
      }
      
      public function onObjectClicked() : void
      {
         super.dragStart();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
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
            _tbxCount.x = _picRect.right - _tbxCount.width;
            _tbxCount.y = _picRect.bottom - _tbxCount.height;
            addChild(_tbxCount);
         }
         else
         {
            _tbxCount.visible = false;
         }
      }
   }
}
