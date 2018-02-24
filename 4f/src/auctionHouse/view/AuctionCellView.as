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
   import ddt.data.goods.ItemTemplateInfo;
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
      
      public function AuctionCellView(){super(null);}
      
      override protected function createChildren() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      private function _alerSell(param1:AuctionSellEvent) : void{}
      
      private function _alerNotSell(param1:AuctionSellEvent) : void{}
      
      public function get goodsCount() : int{return 0;}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      public function onObjectClicked() : void{}
      
      override public function dispose() : void{}
      
      override public function updateCount() : void{}
   }
}
