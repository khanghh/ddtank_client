package auctionHouse.view
{
   import bagAndInfo.bag.BagFrame;
   import bagAndInfo.cell.DragEffect;
   import beadSystem.beadSystemManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.MultipleLineTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import shop.view.NewShopBugleView;
   
   public class AuctionSellLeftView extends Sprite implements Disposeable
   {
       
      
      private var _bid_btn:BaseButton;
      
      private var _bidLight:Bitmap;
      
      private var _keep:FilterFrameText;
      
      private var _startMoney:FilterFrameText;
      
      private var _mouthfulM:FilterFrameText;
      
      private var name_txt:FilterFrameText;
      
      private var _selectRate:Number = 1;
      
      private var _bidTime1:SelectedCheckButton;
      
      private var _bidTime2:SelectedCheckButton;
      
      private var _bidTime3:SelectedCheckButton;
      
      private var _sellLoudBtn:SelectedCheckButton;
      
      private var _sellLoudBtnTxt:FilterFrameText;
      
      private var _currentTime:SelectedButton;
      
      private var _cellsItems:Vector.<AuctionCellView>;
      
      private var _cell:AuctionCellView;
      
      private var _dragArea:AuctionDragInArea;
      
      private var _bag:BagFrame;
      
      private var _cellGoodsID:int;
      
      private var _auctionObjectBg:BaseButton;
      
      private var _auctionObject:Sprite;
      
      private var _selectObjectTip:MultipleLineTip;
      
      private var _auctionObjectFrame:int = 0;
      
      private var _lowestPrice:Number;
      
      private var _selectCheckBtn:SelectedCheckButton;
      
      private var _cellShowTipAble:Boolean = false;
      
      private var _shopBugle:NewShopBugleView;
      
      public function AuctionSellLeftView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function __selectBidTimeII(param1:MouseEvent) : void{}
      
      private function selectBidUpdate(param1:SelectedButton) : void{}
      
      private function removeEvent() : void{}
      
      function addStage() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      function clear() : void{}
      
      function hideReady() : void{}
      
      public function openBagFrame() : void{}
      
      private function update() : void{}
      
      private function getRate() : int{return 0;}
      
      private function getKeep() : String{return null;}
      
      private function _onAuctionObjectClicked(param1:Event) : void{}
      
      private function _onAuctionObjectOver(param1:Event) : void{}
      
      private function _onAuctionObjectOut(param1:Event) : void{}
      
      private function __setBidGood(param1:Event) : void{}
      
      private function __CellstartShine(param1:CellEvent) : void{}
      
      private function __startShine(param1:CellEvent) : void{}
      
      private function __stopShine(param1:CellEvent) : void{}
      
      private function _auctionObjectflash(param1:Event) : void{}
      
      private function __selectGood(param1:Event) : void{}
      
      private function initInfo() : void{}
      
      private function __bid_btnOver(param1:MouseEvent) : void{}
      
      private function __bid_btnOut(param1:MouseEvent) : void{}
      
      private function __startBid(param1:MouseEvent) : void{}
      
      public function sendFastAuctionBugle(param1:int = 11101) : void{}
      
      private function _responseV(param1:FrameEvent) : void{}
      
      private function auctionGood() : void{}
      
      private function autionFunc() : void{}
      
      private function __change(param1:Event) : void{}
      
      private function __textInput(param1:TextEvent) : void{}
      
      private function __textInputMouth(param1:TextEvent) : void{}
      
      private function __timeChange(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
