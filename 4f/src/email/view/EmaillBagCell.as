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
      
      public function EmaillBagCell(){super(null);}
      
      public function set markInfo(param1:MarkChipData) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function _alerSell(param1:AuctionSellEvent) : void{}
      
      private function _alerNotSell(param1:AuctionSellEvent) : void{}
      
      override public function updateCount() : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
      
      public function get goodsCount() : int{return 0;}
   }
}
