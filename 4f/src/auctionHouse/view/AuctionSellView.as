package auctionHouse.view
{
   import auctionHouse.controller.AuctionHouseController;
   import auctionHouse.event.AuctionHouseEvent;
   import auctionHouse.model.AuctionHouseModel;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="nextPage",type="auctionHouse.event.AuctionHouseEvent")]
   [Event(name="prePage",type="auctionHouse.event.AuctionHouseEvent")]
   public class AuctionSellView extends Sprite implements Disposeable
   {
       
      
      private var _right:AuctionRightView;
      
      private var _left:AuctionSellLeftView;
      
      private var _controller:AuctionHouseController;
      
      private var _model:AuctionHouseModel;
      
      private var _cancelBid_btn:BaseButton;
      
      private var _sendBugle:BaseButton;
      
      private var _selectCheckBtn:SelectedCheckButton;
      
      private var _btClickLock:Boolean;
      
      public function AuctionSellView(param1:AuctionHouseController, param2:AuctionHouseModel){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addToStage(param1:Event) : void{}
      
      function clearLeft() : void{}
      
      function clearList() : void{}
      
      function hideReady() : void{}
      
      function addAuction(param1:AuctionGoodsInfo) : void{}
      
      function setPage(param1:int, param2:int) : void{}
      
      function updateList(param1:AuctionGoodsInfo) : void{}
      
      private function __sendBugle(param1:MouseEvent) : void{}
      
      private function __cancel(param1:MouseEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function __cancelOk() : void{}
      
      private function __cannelNo() : void{}
      
      private function __removeStage(param1:Event) : void{}
      
      private function __next(param1:MouseEvent) : void{}
      
      private function __pre(param1:MouseEvent) : void{}
      
      private function sortChange(param1:AuctionHouseEvent) : void{}
      
      function searchByCurCondition(param1:int, param2:int = -1) : void{}
      
      private function __selectStrip(param1:AuctionHouseEvent) : void{}
      
      public function get this_left() : AuctionSellLeftView{return null;}
      
      public function dispose() : void{}
   }
}
