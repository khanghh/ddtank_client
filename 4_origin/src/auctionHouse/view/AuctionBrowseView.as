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
      
      public function AuctionBrowseView(controller:AuctionHouseController, model:AuctionHouseModel)
      {
         super();
         _controller = controller;
         _model = model;
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
      
      protected function sendHander(event:MouseEvent) : void
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
      
      protected function askHander(event:MouseEvent) : void
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
      
      private function presentBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var name:String = giveFriendOpenFrame.nameInput.text;
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(name == "")
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
         if(FilterWordManager.IsNullorEmpty(name))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
            return;
         }
         if(_isAsk)
         {
            SocketManager.Instance.out.requestAuctionPay(info.AuctionID,giveFriendOpenFrame.Name,giveFriendOpenFrame.textArea.text);
         }
         else if(!BuriedManager.Instance.checkMoney(false,info.Mouthful))
         {
            SocketManager.Instance.out.sendForAuction(info.AuctionID,giveFriendOpenFrame.Name);
         }
         _friendInfo = {};
         _friendInfo["id"] = giveFriendOpenFrame.selectPlayerId;
         _friendInfo["name"] = name;
         _friendInfo["msg"] = FilterWordManager.filterWrod(giveFriendOpenFrame.textArea.text);
         giveFriendOpenFrame.dispose();
         giveFriendOpenFrame = null;
      }
      
      private function responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1 || event.responseCode == 4)
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
      
      private function _response(evt:FrameEvent) : void
      {
         var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
         alert.removeEventListener("response",_response);
         ObjectUtils.disposeObject(evt.target);
      }
      
      function addAuction(info:AuctionGoodsInfo) : void
      {
         if(AuctionHouseModel._dimBooble != true)
         {
            _right.addAuction(info);
         }
      }
      
      function updateAuction(info:AuctionGoodsInfo) : void
      {
         _right.updateAuction(info);
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
      
      function setCategory(value:Vector.<CateCoryInfo>) : void
      {
         _list.setCategory(value);
      }
      
      function setPage(start:int, totalCount:int) : void
      {
         _right.setPage(start,totalCount);
      }
      
      function setSelectType(type:CateCoryInfo) : void
      {
         initialiseBtn();
         _list.setSelectType(type);
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
      
      function searchByCurCondition(currentPage:int, playerID:int = -1) : void
      {
         if(playerID != -1)
         {
            _controller.searchAuctionList(currentPage,"",_list.getType(),-1,playerID,-1,_right.sortCondition,_right.sortBy.toString());
            return;
         }
         if(_isSearch)
         {
            _controller.searchAuctionList(currentPage,_list.searchText,_list.getType(),getPayType(),playerID,-1,_right.sortCondition,_right.sortBy.toString());
         }
         else
         {
            _controller.searchAuctionList(currentPage,_list.searchText,_list.getType(),-1,playerID,-1,_right.sortCondition,_right.sortBy.toString());
         }
         _bidMoney.cannotBid();
      }
      
      private function getBidPrice() : int
      {
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info)
         {
            return info.BuyerName == ""?info.Price:info.Price + info.Rise;
         }
         return 0;
      }
      
      private function getPrice() : int
      {
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         return !!info?info.Price:0;
      }
      
      private function getMouthful() : int
      {
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         return !!info?info.Mouthful:0;
      }
      
      private function __searchCondition(event:MouseEvent) : void
      {
         _isSearch = true;
      }
      
      private function keyEnterHandler(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
         {
            __searchCondition(null);
         }
      }
      
      private function __next(event:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("nextPage"));
         _bid_btn.enable = false;
         _mouthful_btn.enable = false;
      }
      
      private function __pre(event:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("prePage"));
         _bid_btn.enable = false;
         _mouthful_btn.enable = false;
      }
      
      private function __selectLeftStrip(event:AuctionHouseEvent) : void
      {
         _isSearch = false;
         _controller.browseTypeChange(_list.getInfo());
      }
      
      private function __selectRightStrip(event:AuctionHouseEvent) : void
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
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info == null || info.AuctioneerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            return;
         }
         if(info.BuyerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            _mouthfulAndbid.visible = true;
            var _loc3_:* = info.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc3_;
            _loc3_ = _loc3_;
            _mouthful_btnR.enable = _loc3_;
            _loc3_ = _loc3_;
            _askBtn.enable = _loc3_;
            _sendBtn.enable = _loc3_;
            _loc3_ = info.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            _mouthful_btnR.filters = _loc3_;
            _loc3_ = _loc3_;
            _sendBtn.filters = _loc3_;
            _askBtn.filters = _loc3_;
            return;
         }
         if(event && event.currentTarget == _right)
         {
            _mouthfulAndbid.visible = true;
         }
         _loc3_ = info.Mouthful == 0?false:true;
         _mouthful_btn.enable = _loc3_;
         _loc3_ = _loc3_;
         _mouthful_btnR.enable = _loc3_;
         _loc3_ = _loc3_;
         _askBtn.enable = _loc3_;
         _sendBtn.enable = _loc3_;
         _loc3_ = info.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
         _mouthful_btnR.filters = _loc3_;
         _loc3_ = _loc3_;
         _sendBtn.filters = _loc3_;
         _askBtn.filters = _loc3_;
         info.PayType == 0?_bidMoney.canGoldBid(getBidPrice()):_bidMoney.canMoneyBid(getBidPrice());
         if(event)
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
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info == null || info.AuctioneerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            return;
         }
         if(info.BuyerID == PlayerManager.Instance.Self.ID)
         {
            initialiseBtn();
            var _loc2_:* = info.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc2_;
            _mouthful_btnR.enable = _loc2_;
            _mouthful_btnR.filters = info.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            return;
         }
         _loc2_ = info.Mouthful == 0?false:true;
         _mouthful_btn.enable = _loc2_;
         _loc2_ = _loc2_;
         _mouthful_btnR.enable = _loc2_;
         _loc2_ = _loc2_;
         _askBtn.enable = _loc2_;
         _sendBtn.enable = _loc2_;
         _loc2_ = info.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
         _mouthful_btnR.filters = _loc2_;
         _loc2_ = _loc2_;
         _sendBtn.filters = _loc2_;
         _askBtn.filters = _loc2_;
         _bid_btn.enable = true;
         return;
         §§push(info.PayType == 0?_bidMoney.canGoldBid(getBidPrice()):_bidMoney.canMoneyBid(getBidPrice()));
      }
      
      private function __bid(event:MouseEvent) : void
      {
         event = event;
         SoundManager.instance.play("047");
         _btClickLock = true;
         _right.getSelectInfo().PayType == 0?_bidMoney.canGoldBid(getBidPrice()):_bidMoney.canMoneyBid(getBidPrice());
         if(_bidMoney.getData() > PlayerManager.Instance.Self.Money)
         {
            LeavePageManager.showFillFrame();
         }
         else
         {
            _bidKeyUp = function(e:Event):void
            {
               SoundManager.instance.play("008");
               __bidOk();
               alert1.removeEventListener("response",_responseII);
               _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
               ObjectUtils.disposeObject(alert1);
               _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
               _isUpdating = false;
            };
            _responseII = function(evt:FrameEvent):void
            {
               SoundManager.instance.play("008");
               _checkResponse(evt.responseCode,__bidOk,__cancel);
               var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
               alert.removeEventListener("response",_responseII);
               _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
               ObjectUtils.disposeObject(evt.target);
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
      
      private function _checkResponse(keyCode:int, submitFun:Function = null, cancelFun:Function = null, closeFun:Function = null) : void
      {
         SoundManager.instance.play("008");
         switch(int(keyCode))
         {
            case 0:
            case 1:
               cancelFun();
               break;
            case 2:
            case 3:
            case 4:
               submitFun();
         }
      }
      
      private function _cancelFun() : void
      {
      }
      
      private function __mouthFull(event:MouseEvent) : void
      {
         var alert1:* = null;
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
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.buy"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert1.moveEnable = false;
            alert1.addEventListener("response",_responseIV);
         }
      }
      
      private function _mouthfulAndbidOver(e:MouseEvent) : void
      {
         _mouthfulAndbid.visible = false;
         _bid_btnR.enable = false;
         _mouthful_btnR.enable = false;
      }
      
      private function _responseIV(evt:FrameEvent) : void
      {
         _checkResponse(evt.responseCode,__mouthFullOk,__cancel);
         var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
         alert.removeEventListener("response",_responseIV);
         ObjectUtils.disposeObject(evt.target);
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
            var info:AuctionGoodsInfo = _right.getSelectInfo();
            if(info)
            {
               SocketManager.Instance.out.auctionBid(info.AuctionID,_bidMoney.getData());
               IMManager.Instance.saveRecentContactsID(info.AuctioneerID);
               info = null;
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
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         _bid_btn.enable = false;
         _mouthful_btn.enable = false;
         if(info == null)
         {
            return;
         }
         if(info.Mouthful != 0 && getMouthful() <= PlayerManager.Instance.Self.Money)
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
            var info:AuctionGoodsInfo = _right.getSelectInfo();
            if(info && info.AuctionID && info.Mouthful)
            {
               SocketManager.Instance.out.auctionBid(info.AuctionID,info.Mouthful);
               IMManager.Instance.saveRecentContactsID(info.AuctioneerID);
               _right.clearSelectStrip();
               _right.setSelectEmpty();
               _bidMoney.cannotBid();
               searchByCurCondition(_model.browseCurrent);
            }
            return;
         }
      }
      
      private function __updateAuction(evt:PkgEvent) : void
      {
         var auctionID:int = 0;
         var succes:Boolean = evt.pkg.readBoolean();
         if(succes)
         {
            auctionID = evt.pkg.readInt();
            if(SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] == null)
            {
               SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] = [];
            }
            SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID].push(auctionID);
            SharedManager.Instance.save();
         }
         _isUpdating = false;
      }
      
      private function __addToStage(event:Event) : void
      {
         initialiseBtn();
         _bidMoney.cannotBid();
         _right.addStageInit();
      }
      
      private function sortChange(e:AuctionHouseEvent) : void
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
