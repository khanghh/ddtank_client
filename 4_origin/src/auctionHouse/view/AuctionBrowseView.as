package auctionHouse.view
{
   import auctionHouse.controller.AuctionHouseController;
   import auctionHouse.event.AuctionHouseEvent;
   import auctionHouse.model.AuctionHouseModel;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.data.goods.CateCoryInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddtBuried.BuriedManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.view.BuySingleGoodsView;
   import shop.view.ShopPresentClearingFrame;
   
   public class AuctionBrowseView extends Sprite implements Disposeable
   {
       
      
      private var _controller:AuctionHouseController;
      
      private var _model:AuctionHouseModel;
      
      private var _list:BrowseLeftMenuView;
      
      private var _bidMoney:BidMoneyView;
      
      private var _bid_btn:BaseButton;
      
      private var _mouthful_btn:BaseButton;
      
      private var _bid_btnR:TextButton;
      
      private var _mouthfulAndbid:ScaleBitmapImage;
      
      private var _mouthful_btnR:TextButton;
      
      private var _btClickLock:Boolean;
      
      private var _isSearch:Boolean;
      
      private var _right:AuctionRightView;
      
      private var _isUpdating:Boolean;
      
      private var _askBtn:TextButton;
      
      private var _sendBtn:TextButton;
      
      private var giveFriendOpenFrame:ShopPresentClearingFrame;
      
      private var _friendInfo:Object;
      
      private var view:BuySingleGoodsView;
      
      private var _isAsk:Boolean;
      
      public function AuctionBrowseView(param1:AuctionHouseController, param2:AuctionHouseModel)
      {
         super();
         _controller = param1;
         _model = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bid_btn = ComponentFactory.Instance.creat("auctionHouse.Bid_btn");
         addChild(_bid_btn);
         _mouthful_btn = ComponentFactory.Instance.creat("auctionHouse.Mouthful_btn");
         addChild(_mouthful_btn);
         _bid_btnR = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.Bid_btnR");
         _bid_btnR.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.bid");
         _mouthful_btnR = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.Mouthful_btnR");
         _mouthful_btnR.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.mouthful");
         _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
         _askBtn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.ask_btnR");
         _askBtn.text = LanguageMgr.GetTranslation("shop.ShopIIPresentView.ask");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.Send_btnR");
         _sendBtn.text = LanguageMgr.GetTranslation("shop.ShopIIPresentView.send");
         _list = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BrowseLeftMenuView");
         addChild(_list);
         _right = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.AuctionRightView");
         _right.setup("browse");
         addChild(_right);
         initialiseBtn();
         _mouthfulAndbid = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.core.commonTipBg");
         _mouthfulAndbid.addChild(_bid_btnR);
         _mouthfulAndbid.addChild(_mouthful_btnR);
         _mouthfulAndbid.addChild(_askBtn);
         _mouthfulAndbid.addChild(_sendBtn);
         addChild(_mouthfulAndbid);
         _bid_btnR.enable = false;
         _mouthful_btnR.enable = false;
         _mouthfulAndbid.visible = false;
      }
      
      private function initialiseBtn() : void
      {
         _mouthful_btn.enable = false;
         _bid_btn.enable = false;
         _bidMoney.cannotBid();
      }
      
      private function addEvent() : void
      {
         _right.prePage_btn.addEventListener("click",__pre);
         _right.nextPage_btn.addEventListener("click",__next);
         _right.addEventListener("selectStrip",__selectRightStrip);
         _right.addEventListener("sortChange",sortChange);
         _list.addEventListener("selectStrip",__selectLeftStrip);
         _askBtn.addEventListener("click",askHander);
         _sendBtn.addEventListener("click",sendHander);
         _bid_btn.addEventListener("click",__bid);
         _mouthful_btn.addEventListener("click",__mouthFull);
         _bid_btnR.addEventListener("click",__bid);
         _mouthful_btnR.addEventListener("click",__mouthFull);
         _mouthfulAndbid.addEventListener("rollOut",_mouthfulAndbidOver);
         addEventListener("addedToStage",__addToStage);
         SocketManager.Instance.addEventListener(PkgEvent.format(193),__updateAuction);
      }
      
      protected function sendHander(param1:MouseEvent) : void
      {
         if(giveFriendOpenFrame)
         {
            giveFriendOpenFrame.dispose();
            giveFriendOpenFrame = null;
         }
         _isAsk = false;
         giveFriendOpenFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         giveFriendOpenFrame.nameInput.enable = true;
         giveFriendOpenFrame.titleTxt.visible = false;
         giveFriendOpenFrame.setType();
         giveFriendOpenFrame.show();
         giveFriendOpenFrame.presentBtn.addEventListener("click",presentBtnClick,false,0,true);
         giveFriendOpenFrame.addEventListener("response",responseHandler,false,0,true);
      }
      
      protected function askHander(param1:MouseEvent) : void
      {
         if(giveFriendOpenFrame)
         {
            giveFriendOpenFrame.dispose();
            giveFriendOpenFrame = null;
         }
         _isAsk = true;
         giveFriendOpenFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         giveFriendOpenFrame.nameInput.enable = true;
         giveFriendOpenFrame.titleTxt.visible = false;
         giveFriendOpenFrame.setType(3);
         giveFriendOpenFrame.show();
         giveFriendOpenFrame.presentBtn.addEventListener("click",presentBtnClick,false,0,true);
         giveFriendOpenFrame.addEventListener("response",responseHandler,false,0,true);
      }
      
      private function presentBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:String = giveFriendOpenFrame.nameInput.text;
         var _loc3_:AuctionGoodsInfo = _right.getSelectInfo();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_loc2_ == "")
         {
            if(_isAsk)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.askPay"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
            }
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
            return;
         }
         if(_isAsk)
         {
            SocketManager.Instance.out.requestAuctionPay(_loc3_.AuctionID,giveFriendOpenFrame.Name,giveFriendOpenFrame.textArea.text);
         }
         else if(!BuriedManager.Instance.checkMoney(false,_loc3_.Mouthful))
         {
            SocketManager.Instance.out.sendForAuction(_loc3_.AuctionID,giveFriendOpenFrame.Name);
         }
         _friendInfo = {};
         _friendInfo["id"] = giveFriendOpenFrame.selectPlayerId;
         _friendInfo["name"] = _loc2_;
         _friendInfo["msg"] = FilterWordManager.filterWrod(giveFriendOpenFrame.textArea.text);
         giveFriendOpenFrame.dispose();
         giveFriendOpenFrame = null;
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            StageReferance.stage.focus = this;
         }
      }
      
      private function removeEvent() : void
      {
         _askBtn.removeEventListener("click",askHander);
         _sendBtn.removeEventListener("click",sendHander);
         _right.prePage_btn.removeEventListener("click",__pre);
         _right.nextPage_btn.removeEventListener("click",__next);
         _right.removeEventListener("sortChange",sortChange);
         _right.removeEventListener("selectStrip",__selectRightStrip);
         _list.removeEventListener("selectStrip",__selectLeftStrip);
         _bid_btn.removeEventListener("click",__bid);
         _mouthful_btn.removeEventListener("click",__mouthFull);
         _bid_btnR.removeEventListener("click",__bid);
         _mouthful_btnR.removeEventListener("click",__mouthFull);
         _mouthfulAndbid.removeEventListener("rollOut",_mouthfulAndbidOver);
         removeEventListener("addedToStage",__addToStage);
         SocketManager.Instance.removeEventListener(PkgEvent.format(193),__updateAuction);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_response);
         ObjectUtils.disposeObject(param1.target);
      }
      
      function addAuction(param1:AuctionGoodsInfo) : void
      {
         if(AuctionHouseModel._dimBooble != true)
         {
            _right.addAuction(param1);
         }
      }
      
      function updateAuction(param1:AuctionGoodsInfo) : void
      {
         _right.updateAuction(param1);
         __selectRightStrip(null);
      }
      
      function removeAuction() : void
      {
         __searchCondition(null);
      }
      
      function hideReady() : void
      {
         _right.hideReady();
      }
      
      function clearList() : void
      {
         if(AuctionHouseModel._dimBooble == true)
         {
            _list.setFocusName();
            return;
         }
         _right.clearList();
         __selectRightStrip(null);
      }
      
      function setCategory(param1:Vector.<CateCoryInfo>) : void
      {
         _list.setCategory(param1);
      }
      
      function setPage(param1:int, param2:int) : void
      {
         _right.setPage(param1,param2);
      }
      
      function setSelectType(param1:CateCoryInfo) : void
      {
         initialiseBtn();
         _list.setSelectType(param1);
      }
      
      function getLeftInfo() : CateCoryInfo
      {
         return _list.getInfo();
      }
      
      function setTextEmpty() : void
      {
         _list.searchText = "";
      }
      
      function getPayType() : int
      {
         return -1;
      }
      
      function searchByCurCondition(param1:int, param2:int = -1) : void
      {
         if(param2 != -1)
         {
            _controller.searchAuctionList(param1,"",_list.getType(),-1,param2,-1,_right.sortCondition,_right.sortBy.toString());
            return;
         }
         if(_isSearch)
         {
            _controller.searchAuctionList(param1,_list.searchText,_list.getType(),getPayType(),param2,-1,_right.sortCondition,_right.sortBy.toString());
         }
         else
         {
            _controller.searchAuctionList(param1,_list.searchText,_list.getType(),-1,param2,-1,_right.sortCondition,_right.sortBy.toString());
         }
         _bidMoney.cannotBid();
      }
      
      private function getBidPrice() : int
      {
         var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc1_)
         {
            return _loc1_.BuyerName == ""?_loc1_.Price:_loc1_.Price + _loc1_.Rise;
         }
         return 0;
      }
      
      private function getPrice() : int
      {
         var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
         return !!_loc1_?_loc1_.Price:0;
      }
      
      private function getMouthful() : int
      {
         var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
         return !!_loc1_?_loc1_.Mouthful:0;
      }
      
      private function __searchCondition(param1:MouseEvent) : void
      {
         _isSearch = true;
      }
      
      private function keyEnterHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __searchCondition(null);
         }
      }
      
      private function __next(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("nextPage"));
         _bid_btn.enable = false;
         _mouthful_btn.enable = false;
      }
      
      private function __pre(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("prePage"));
         _bid_btn.enable = false;
         _mouthful_btn.enable = false;
      }
      
      private function __selectLeftStrip(param1:AuctionHouseEvent) : void
      {
         _isSearch = false;
         _controller.browseTypeChange(_list.getInfo());
      }
      
      private function __selectRightStrip(param1:AuctionHouseEvent) : void
      {
         _mouthfulAndbid.x = this.globalToLocal(new Point(mouseX,mouseY)).x - 10;
         _mouthfulAndbid.y = this.globalToLocal(new Point(mouseX,mouseY)).y - 10;
         if(_mouthfulAndbid.x > stage.stageWidth - _mouthfulAndbid.width)
         {
            _mouthfulAndbid.x = _mouthfulAndbid.x - _mouthfulAndbid.width + 20;
         }
         _bid_btnR.enable = false;
         _bid_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _mouthful_btnR.enable = false;
         _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         this.setChildIndex(_mouthfulAndbid,this.numChildren - 1);
         if(_isUpdating)
         {
            return;
         }
         var _loc2_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc2_ == null || _loc2_.AuctioneerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            return;
         }
         if(_loc2_.BuyerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            _mouthfulAndbid.visible = true;
            var _loc3_:* = _loc2_.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc3_;
            _loc3_ = _loc3_;
            _mouthful_btnR.enable = _loc3_;
            _loc3_ = _loc3_;
            _askBtn.enable = _loc3_;
            _sendBtn.enable = _loc3_;
            _loc3_ = _loc2_.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            _mouthful_btnR.filters = _loc3_;
            _loc3_ = _loc3_;
            _sendBtn.filters = _loc3_;
            _askBtn.filters = _loc3_;
            return;
         }
         if(param1 && param1.currentTarget == _right)
         {
            _mouthfulAndbid.visible = true;
         }
         _loc3_ = _loc2_.Mouthful == 0?false:true;
         _mouthful_btn.enable = _loc3_;
         _loc3_ = _loc3_;
         _mouthful_btnR.enable = _loc3_;
         _loc3_ = _loc3_;
         _askBtn.enable = _loc3_;
         _sendBtn.enable = _loc3_;
         _loc3_ = _loc2_.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
         _mouthful_btnR.filters = _loc3_;
         _loc3_ = _loc3_;
         _sendBtn.filters = _loc3_;
         _askBtn.filters = _loc3_;
         _loc2_.PayType == 0?_bidMoney.canGoldBid(getBidPrice()):_bidMoney.canMoneyBid(getBidPrice());
         if(param1)
         {
            _loc3_ = true;
            _bid_btn.enable = _loc3_;
            _bid_btnR.enable = _loc3_;
            _bid_btnR.filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      private function init_FUL_BID_btnStatue() : void
      {
         _bid_btnR.enable = false;
         _bid_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _mouthful_btnR.enable = false;
         _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         if(_isUpdating)
         {
            return;
         }
         var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc1_ == null || _loc1_.AuctioneerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            return;
         }
         if(_loc1_.BuyerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            var _loc2_:* = _loc1_.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc2_;
            _mouthful_btnR.enable = _loc2_;
            _mouthful_btnR.filters = _loc1_.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            return;
         }
         _loc2_ = _loc1_.Mouthful == 0?false:true;
         _mouthful_btn.enable = _loc2_;
         _loc2_ = _loc2_;
         _mouthful_btnR.enable = _loc2_;
         _loc2_ = _loc2_;
         _askBtn.enable = _loc2_;
         _sendBtn.enable = _loc2_;
         _loc2_ = _loc1_.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
         _mouthful_btnR.filters = _loc2_;
         _loc2_ = _loc2_;
         _sendBtn.filters = _loc2_;
         _askBtn.filters = _loc2_;
         _bid_btn.enable = true;
         return;
         §§push(_loc1_.PayType == 0?_bidMoney.canGoldBid(getBidPrice()):_bidMoney.canMoneyBid(getBidPrice()));
      }
      
      private function __bid(param1:MouseEvent) : void
      {
         event = param1;
         SoundManager.instance.play("047");
         _btClickLock = true;
         _right.getSelectInfo().PayType == 0?_bidMoney.canGoldBid(getBidPrice()):_bidMoney.canMoneyBid(getBidPrice());
         if(_bidMoney.getData() > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
         }
         else
         {
            _bidKeyUp = function(param1:Event):void
            {
               SoundManager.instance.play("008");
               __bidOk();
               alert1.removeEventListener("response",_responseII);
               _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
               ObjectUtils.disposeObject(alert1);
               _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
               _isUpdating = false;
            };
            _responseII = function(param1:FrameEvent):void
            {
               SoundManager.instance.play("008");
               _checkResponse(param1.responseCode,__bidOk,__cancel);
               var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
               _loc2_.removeEventListener("response",_responseII);
               _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
               ObjectUtils.disposeObject(param1.target);
               _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
               _isUpdating = false;
            };
            checkPlayerMoney();
            _bid_btn.enable = false;
            _mouthfulAndbid.visible = false;
            if(PlayerManager.Instance.Self.bagLocked)
            {
               _mouthful_btnR.enable = false;
               _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _bid_btn.enable = true;
               BaglockedManager.Instance.show();
               return;
            }
            var alert1:AuctionInputFrame = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.AuctionInputFrame");
            LayerManager.Instance.addToLayer(alert1,1,alert1.info.frameCenter,1);
            alert1.addToContent(_bidMoney);
            _bidMoney.money.setFocus();
            alert1.moveEnable = false;
            alert1.addEventListener("response",_responseII);
            _bidMoney.addEventListener("money_key_up",_bidKeyUp);
         }
      }
      
      private function _checkResponse(param1:int, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1))
         {
            case 0:
            case 1:
               param3();
               break;
            case 2:
            case 3:
            case 4:
               param2();
         }
      }
      
      private function _cancelFun() : void
      {
      }
      
      private function __mouthFull(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("047");
         _btClickLock = true;
         _mouthfulAndbid.visible = false;
         if(getMouthful() > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               _mouthful_btnR.enable = false;
               _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               BaglockedManager.Instance.show();
               return;
            }
            _mouthful_btn.enable = false;
            _bid_btn.enable = false;
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.buy"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",_responseIV);
         }
      }
      
      private function _mouthfulAndbidOver(param1:MouseEvent) : void
      {
         _mouthfulAndbid.visible = false;
         _bid_btnR.enable = false;
         _mouthful_btnR.enable = false;
      }
      
      private function _responseIV(param1:FrameEvent) : void
      {
         _checkResponse(param1.responseCode,__mouthFullOk,__cancel);
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_responseIV);
         ObjectUtils.disposeObject(param1.target);
         _isUpdating = false;
      }
      
      private function __bidOk() : void
      {
         _isUpdating = true;
         if(_btClickLock)
         {
            _btClickLock = false;
            if(getBidPrice() > _bidMoney.getData())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBuyView.Auction") + String(getBidPrice()) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple"));
               _bid_btn.enable = true;
               return;
            }
            if(_bidMoney.getData() > PlayerManager.Instance.Self.Money)
            {
               _bid_btn.enable = true;
               LeavePageManager.showFillFrame();
               return;
            }
            if(getMouthful() != 0 && _bidMoney.getData() >= getMouthful())
            {
               _btClickLock = true;
               _mouthful_btn.enable = false;
               _bid_btn.enable = false;
               __mouthFullOk();
               return;
            }
            var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
            if(_loc1_)
            {
               SocketManager.Instance.out.auctionBid(_loc1_.AuctionID,_bidMoney.getData());
               IMManager.Instance.saveRecentContactsID(_loc1_.AuctioneerID);
               _loc1_ = null;
            }
            return;
         }
      }
      
      private function __cancel() : void
      {
         init_FUL_BID_btnStatue();
      }
      
      private function checkPlayerMoney() : void
      {
         var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
         _bid_btn.enable = false;
         _mouthful_btn.enable = false;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.Mouthful != 0 && getMouthful() <= PlayerManager.Instance.Self.Money)
         {
            _mouthful_btn.enable = true;
         }
      }
      
      private function __mouthFullOk() : void
      {
         if(_btClickLock)
         {
            _btClickLock = false;
            if(getMouthful() > PlayerManager.Instance.Self.Money)
            {
               _bid_btn.enable = true;
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.Your") + String(getMouthful()) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple"));
               return;
            }
            var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
            if(_loc1_ && _loc1_.AuctionID && _loc1_.Mouthful)
            {
               SocketManager.Instance.out.auctionBid(_loc1_.AuctionID,_loc1_.Mouthful);
               IMManager.Instance.saveRecentContactsID(_loc1_.AuctioneerID);
               _right.clearSelectStrip();
               _right.setSelectEmpty();
               _bidMoney.cannotBid();
               searchByCurCondition(_model.browseCurrent);
            }
            return;
         }
      }
      
      private function __updateAuction(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            _loc2_ = param1.pkg.readInt();
            if(SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] == null)
            {
               SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] = [];
            }
            SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID].push(_loc2_);
            SharedManager.Instance.save();
         }
         _isUpdating = false;
      }
      
      private function __addToStage(param1:Event) : void
      {
         initialiseBtn();
         _bidMoney.cannotBid();
         _right.addStageInit();
      }
      
      private function sortChange(param1:AuctionHouseEvent) : void
      {
         __searchCondition(null);
      }
      
      public function get Right() : AuctionRightView
      {
         return _right;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _controller = null;
         ObjectUtils.disposeObject(_askBtn);
         _askBtn = null;
         ObjectUtils.disposeObject(_sendBtn);
         _sendBtn = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_bidMoney)
         {
            ObjectUtils.disposeObject(_bidMoney);
         }
         _bidMoney = null;
         if(_bid_btn)
         {
            ObjectUtils.disposeObject(_bid_btn);
         }
         _bid_btn = null;
         if(_mouthful_btn)
         {
            ObjectUtils.disposeObject(_mouthful_btn);
         }
         _mouthful_btn = null;
         if(_bid_btnR)
         {
            ObjectUtils.disposeObject(_bid_btnR);
         }
         _bid_btnR = null;
         if(_mouthful_btnR)
         {
            ObjectUtils.disposeObject(_mouthful_btnR);
         }
         _mouthful_btnR = null;
         if(_mouthfulAndbid)
         {
            ObjectUtils.disposeObject(_mouthfulAndbid);
         }
         _mouthfulAndbid = null;
         if(_right)
         {
            ObjectUtils.disposeObject(_right);
         }
         _right = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
