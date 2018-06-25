package auctionHouse.view{   import auctionHouse.event.AuctionHouseEvent;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.auctionHouse.AuctionGoodsInfo;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class AuctionBuyView extends Sprite implements Disposeable   {                   private var _bidMoney:BidMoneyView;            private var _right:AuctionBuyRightView;            private var _bid_btn:BaseButton;            private var _mouthful_btn:BaseButton;            private var _bid_btnR:TextButton;            private var _mouthfulAndbid:ScaleBitmapImage;            private var _mouthful_btnR:TextButton;            private var _btClickLock:Boolean;            public function AuctionBuyView() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function __nextPage(evt:MouseEvent) : void { }
            private function __prePage(evt:MouseEvent) : void { }
            private function removeEvent() : void { }
            private function getBidPrice() : int { return 0; }
            protected function hide() : void { }
            private function initialiseBtn() : void { }
            protected function addAuction(info:AuctionGoodsInfo) : void { }
            protected function removeAuction() : void { }
            protected function updateAuction(info:AuctionGoodsInfo) : void { }
            protected function clearList() : void { }
            private function _mouthfulAndbidOver(e:MouseEvent) : void { }
            private function __selectRightStrip(event:AuctionHouseEvent) : void { }
            private function __bid(event:MouseEvent) : void { }
            private function __bidII() : void { }
            private function __mouthFull(event:MouseEvent) : void { }
            private function _responseI(evt:FrameEvent) : void { }
            private function _responseII(evt:FrameEvent) : void { }
            private function __callMouthFull() : void { }
            private function __cannel() : void { }
            private function _cancelFun() : void { }
            private function __addToStage(event:Event) : void { }
            private function _checkResponse(keyCode:int, submitFun:Function = null, cancelFun:Function = null, closeFun:Function = null) : void { }
            public function dispose() : void { }
   }}