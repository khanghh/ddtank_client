package auctionHouse.view
{
   import auctionHouse.event.AuctionHouseEvent;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
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
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class AuctionBuyView extends Sprite implements Disposeable
   {
       
      
      private var _bidMoney:BidMoneyView;
      
      private var _right:AuctionBuyRightView;
      
      private var _bid_btn:BaseButton;
      
      private var _mouthful_btn:BaseButton;
      
      private var _bid_btnR:TextButton;
      
      private var _mouthfulAndbid:ScaleBitmapImage;
      
      private var _mouthful_btnR:TextButton;
      
      private var _btClickLock:Boolean;
      
      public function AuctionBuyView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bid_btn = ComponentFactory.Instance.creat("auctionHouse.Bid_btn");
         addChild(_bid_btn);
         _mouthful_btn = ComponentFactory.Instance.creat("auctionHouse.Mouthful_btn");
         addChild(_mouthful_btn);
         _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
         _bidMoney.cannotBid();
         _bid_btnR = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.Bid_btnR");
         _bid_btnR.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.bid");
         _mouthful_btnR = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.Mouthful_btnR");
         _mouthful_btnR.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.view.mouthful");
         _right = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.AuctionBuyRightView");
         addChild(_right);
         initialiseBtn();
         _mouthfulAndbid = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.core.commonTipBg");
         _mouthfulAndbid.addChild(_bid_btnR);
         _mouthfulAndbid.addChild(_mouthful_btnR);
         addChild(_mouthfulAndbid);
         _mouthfulAndbid.visible = false;
         var _loc1_:Boolean = false;
         _bid_btn.enable = _loc1_;
         _bid_btnR.enable = _loc1_;
      }
      
      private function addEvent() : void
      {
         _right.addEventListener("selectStrip",__selectRightStrip);
         _bid_btn.addEventListener("click",__bid);
         _mouthful_btn.addEventListener("click",__mouthFull);
         addEventListener("addedToStage",__addToStage);
         _bid_btnR.addEventListener("click",__bid);
         _mouthful_btnR.addEventListener("click",__mouthFull);
         _mouthfulAndbid.addEventListener("rollOut",_mouthfulAndbidOver);
      }
      
      private function __nextPage(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("nextPage"));
      }
      
      private function __prePage(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("prePage"));
      }
      
      private function removeEvent() : void
      {
         _right.removeEventListener("selectStrip",__selectRightStrip);
         _bid_btn.removeEventListener("click",__bid);
         _mouthful_btn.removeEventListener("click",__mouthFull);
         removeEventListener("addedToStage",__addToStage);
         _bid_btnR.removeEventListener("click",__bid);
         _mouthful_btnR.removeEventListener("click",__mouthFull);
         _mouthfulAndbid.removeEventListener("rollOut",_mouthfulAndbidOver);
      }
      
      private function getBidPrice() : int
      {
         var _loc1_:int = 0;
         var _loc2_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc2_.BuyerName == "")
         {
            _loc1_ = _loc2_.Price;
         }
         else
         {
            _loc1_ = _loc2_.Price + _loc2_.Rise;
         }
         return _loc1_;
      }
      
      function hide() : void
      {
      }
      
      private function initialiseBtn() : void
      {
         _mouthful_btn.enable = false;
         _bid_btn.enable = false;
         _mouthful_btnR.enable = false;
         _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _bid_btnR.enable = false;
         _bid_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _bidMoney.cannotBid();
      }
      
      function addAuction(param1:AuctionGoodsInfo) : void
      {
         _right.addAuction(param1);
      }
      
      function removeAuction() : void
      {
         _bidMoney.cannotBid();
      }
      
      function updateAuction(param1:AuctionGoodsInfo) : void
      {
         _right.updateAuction(param1);
         __selectRightStrip(null);
      }
      
      function clearList() : void
      {
         _right.clearList();
      }
      
      private function _mouthfulAndbidOver(param1:MouseEvent) : void
      {
         _mouthfulAndbid.visible = false;
      }
      
      private function __selectRightStrip(param1:AuctionHouseEvent) : void
      {
         _mouthfulAndbid.x = this.globalToLocal(new Point(mouseX,mouseY)).x - 10;
         _mouthfulAndbid.y = this.globalToLocal(new Point(mouseX,mouseY)).y - 10;
         if(_mouthfulAndbid.x > stage.stageWidth - _mouthfulAndbid.width)
         {
            _mouthfulAndbid.x = _mouthfulAndbid.x - _mouthfulAndbid.width + 20;
         }
         this.setChildIndex(_mouthfulAndbid,this.numChildren - 1);
         if(param1)
         {
            _mouthfulAndbid.visible = true;
         }
         var _loc2_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc2_)
         {
            if(_loc2_.AuctioneerID == PlayerManager.Instance.Self.ID)
            {
               initialiseBtn();
               return;
            }
            var _loc3_:* = _loc2_.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc3_;
            _mouthful_btnR.enable = _loc3_;
            _mouthful_btnR.filters = _loc2_.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            _loc3_ = _loc2_.BuyerID == PlayerManager.Instance.Self.ID?false:true;
            _bid_btn.enable = _loc3_;
            _bid_btnR.enable = _loc3_;
            _bid_btnR.filters = _loc2_.BuyerID == PlayerManager.Instance.Self.ID?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            if(_loc2_.BuyerID != PlayerManager.Instance.Self.ID)
            {
               _bidMoney.canMoneyBid(_loc2_.Price + _loc2_.Rise);
            }
            else
            {
               _bidMoney.cannotBid();
            }
         }
      }
      
      private function __bid(param1:MouseEvent) : void
      {
         event = param1;
         _bidKeyUp = function(param1:Event):void
         {
            SoundManager.instance.play("008");
            __bidII();
            alert1.removeEventListener("response",_responseII);
            _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
            ObjectUtils.disposeObject(alert1);
            _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
         };
         _responseII = function(param1:FrameEvent):void
         {
            SoundManager.instance.play("008");
            _checkResponse(param1.responseCode,__bidII,__cannel);
            var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
            _loc2_.removeEventListener("response",_responseII);
            _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
            ObjectUtils.disposeObject(param1.target);
            _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
         };
         SoundManager.instance.play("047");
         _btClickLock = true;
         _mouthfulAndbid.visible = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            __selectRightStrip(null);
            return;
         }
         if(_bidMoney.getData() > PlayerManager.Instance.Self.Money)
         {
            var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",_responseI);
            return;
         }
         var _loc3_:Boolean = false;
         this._bid_btn.enable = _loc3_;
         _bid_btnR.enable = _loc3_;
         var alert1:AuctionInputFrame = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.AuctionInputFrame");
         LayerManager.Instance.addToLayer(alert1,1,alert1.info.frameCenter,1);
         alert1.addToContent(_bidMoney);
         _bidMoney.money.setFocus();
         alert1.moveEnable = false;
         alert1.addEventListener("response",_responseII);
         _bidMoney.addEventListener("money_key_up",_bidKeyUp);
      }
      
      private function __bidII() : void
      {
         if(_btClickLock)
         {
            _btClickLock = false;
            if(getBidPrice() > _bidMoney.getData())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBuyView.price") + String(_bidMoney.getData()) + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBuyView.less") + String(getBidPrice()));
               return;
            }
            var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
            if(_loc1_)
            {
               SocketManager.Instance.out.auctionBid(_loc1_.AuctionID,_bidMoney.getData());
            }
            return;
         }
      }
      
      private function __mouthFull(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("047");
         _mouthfulAndbid.visible = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc5_:Boolean = false;
         _mouthful_btnR.enable = _loc5_;
         _mouthful_btn.enable = _loc5_;
         _loc5_ = false;
         _bid_btnR.enable = _loc5_;
         _bid_btn.enable = _loc5_;
         _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _bid_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _btClickLock = true;
         var _loc4_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc4_.Mouthful > PlayerManager.Instance.Self.Money)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            _loc2_.addEventListener("response",_responseI);
            return;
         }
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.buy"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",_responseII);
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _checkResponse(param1.responseCode,LeavePageManager.leaveToFillPath,_cancelFun);
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_responseI);
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _checkResponse(param1.responseCode,__callMouthFull,__cannel);
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function __callMouthFull() : void
      {
         var _loc1_:int = 0;
         if(_btClickLock)
         {
            _btClickLock = false;
            var _loc2_:AuctionGoodsInfo = _right.getSelectInfo();
            if(_loc2_)
            {
               SocketManager.Instance.out.auctionBid(_loc2_.AuctionID,_loc2_.Mouthful);
               IMManager.Instance.saveRecentContactsID(_loc2_.AuctioneerID);
               if(SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] == null)
               {
                  SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] = [];
               }
               _loc1_ = 0;
               while(_loc1_ < SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID].length)
               {
                  if(SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID][_loc1_] == _loc2_.AuctionID)
                  {
                     SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID].splice(_loc1_,1);
                  }
                  _loc1_++;
               }
               SharedManager.Instance.save();
               _bidMoney.cannotBid();
               _right.clearSelectStrip();
            }
            return;
         }
      }
      
      private function __cannel() : void
      {
         var _loc1_:AuctionGoodsInfo = _right.getSelectInfo();
         if(_loc1_)
         {
            var _loc2_:* = _loc1_.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc2_;
            _mouthful_btnR.enable = _loc2_;
            _mouthful_btnR.filters = _loc1_.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            _loc2_ = _loc1_.BuyerID == PlayerManager.Instance.Self.ID?false:true;
            _bid_btn.enable = _loc2_;
            _bid_btnR.enable = _loc2_;
            _bid_btnR.filters = _loc1_.BuyerID == PlayerManager.Instance.Self.ID?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
         }
         else
         {
            _loc2_ = false;
            _mouthful_btn.enable = _loc2_;
            _mouthful_btnR.enable = _loc2_;
            _loc2_ = false;
            _bid_btn.enable = _loc2_;
            _bid_btnR.enable = _loc2_;
            _mouthful_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            _bid_btnR.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      private function _cancelFun() : void
      {
      }
      
      private function __addToStage(param1:Event) : void
      {
         initialiseBtn();
         _bidMoney.cannotBid();
      }
      
      private function _checkResponse(param1:int, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
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
      
      public function dispose() : void
      {
         removeEvent();
         if(_right)
         {
            ObjectUtils.disposeObject(_right);
         }
         _right = null;
         if(_mouthful_btn)
         {
            ObjectUtils.disposeObject(_mouthful_btn);
         }
         _mouthful_btn = null;
         if(_bid_btn)
         {
            ObjectUtils.disposeObject(_bid_btn);
         }
         _bid_btn = null;
         if(_bidMoney)
         {
            ObjectUtils.disposeObject(_bidMoney);
         }
         _bidMoney = null;
         if(parent)
         {
            parent.removeChild(this);
         }
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
      }
   }
}
