package auctionHouse.view{   import auctionHouse.controller.AuctionHouseController;   import auctionHouse.event.AuctionHouseEvent;   import auctionHouse.model.AuctionHouseModel;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.auctionHouse.AuctionGoodsInfo;   import ddt.data.goods.CateCoryInfo;   import ddt.events.PkgEvent;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import ddtBuried.BuriedManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import shop.view.BuySingleGoodsView;   import shop.view.ShopPresentClearingFrame;      public class AuctionBrowseView extends Sprite implements Disposeable   {                   private var _controller:AuctionHouseController;            private var _model:AuctionHouseModel;            private var _list:BrowseLeftMenuView;            private var _bidMoney:BidMoneyView;            private var _bid_btn:BaseButton;            private var _mouthful_btn:BaseButton;            private var _bid_btnR:TextButton;            private var _mouthfulAndbid:ScaleBitmapImage;            private var _mouthful_btnR:TextButton;            private var _btClickLock:Boolean;            private var _isSearch:Boolean;            private var _right:AuctionRightView;            private var _isUpdating:Boolean;            private var _askBtn:TextButton;            private var _sendBtn:TextButton;            private var giveFriendOpenFrame:ShopPresentClearingFrame;            private var _friendInfo:Object;            private var view:BuySingleGoodsView;            private var _isAsk:Boolean;            public function AuctionBrowseView(controller:AuctionHouseController, model:AuctionHouseModel) { super(); }
            private function initView() : void { }
            private function initialiseBtn() : void { }
            private function addEvent() : void { }
            protected function sendHander(event:MouseEvent) : void { }
            protected function askHander(event:MouseEvent) : void { }
            private function presentBtnClick(event:MouseEvent) : void { }
            private function responseHandler(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            private function _response(evt:FrameEvent) : void { }
            protected function addAuction(info:AuctionGoodsInfo) : void { }
            protected function updateAuction(info:AuctionGoodsInfo) : void { }
            protected function removeAuction() : void { }
            protected function hideReady() : void { }
            protected function clearList() : void { }
            protected function setCategory(value:Vector.<CateCoryInfo>) : void { }
            protected function setPage(start:int, totalCount:int) : void { }
            protected function setSelectType(type:CateCoryInfo) : void { }
            protected function getLeftInfo() : CateCoryInfo { return null; }
            protected function setTextEmpty() : void { }
            protected function getPayType() : int { return 0; }
            protected function searchByCurCondition(currentPage:int, playerID:int = -1) : void { }
            private function getBidPrice() : int { return 0; }
            private function getPrice() : int { return 0; }
            private function getMouthful() : int { return 0; }
            private function __searchCondition(event:MouseEvent) : void { }
            private function keyEnterHandler(e:KeyboardEvent) : void { }
            private function __next(event:MouseEvent) : void { }
            private function __pre(event:MouseEvent) : void { }
            private function __selectLeftStrip(event:AuctionHouseEvent) : void { }
            private function __selectRightStrip(event:AuctionHouseEvent) : void { }
            private function init_FUL_BID_btnStatue() : void { }
            private function __bid(event:MouseEvent) : void { }
            private function _checkResponse(keyCode:int, submitFun:Function = null, cancelFun:Function = null, closeFun:Function = null) : void { }
            private function _cancelFun() : void { }
            private function __mouthFull(event:MouseEvent) : void { }
            private function _mouthfulAndbidOver(e:MouseEvent) : void { }
            private function _responseIV(evt:FrameEvent) : void { }
            private function __bidOk() : void { }
            private function __cancel() : void { }
            private function checkPlayerMoney() : void { }
            private function __mouthFullOk() : void { }
            private function __updateAuction(evt:PkgEvent) : void { }
            private function __addToStage(event:Event) : void { }
            private function sortChange(e:AuctionHouseEvent) : void { }
            public function get Right() : AuctionRightView { return null; }
            public function dispose() : void { }
   }}