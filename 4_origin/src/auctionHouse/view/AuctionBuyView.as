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
      
      private function __nextPage(evt:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         dispatchEvent(new AuctionHouseEvent("nextPage"));
      }
      
      private function __prePage(evt:MouseEvent) : void
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
         var min:int = 0;
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info.BuyerName == "")
         {
            min = info.Price;
         }
         else
         {
            min = info.Price + info.Rise;
         }
         return min;
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
      
      function addAuction(info:AuctionGoodsInfo) : void
      {
         _right.addAuction(info);
      }
      
      function removeAuction() : void
      {
         _bidMoney.cannotBid();
      }
      
      function updateAuction(info:AuctionGoodsInfo) : void
      {
         _right.updateAuction(info);
         __selectRightStrip(null);
      }
      
      function clearList() : void
      {
         _right.clearList();
      }
      
      private function _mouthfulAndbidOver(e:MouseEvent) : void
      {
         _mouthfulAndbid.visible = false;
      }
      
      private function __selectRightStrip(event:AuctionHouseEvent) : void
      {
         _mouthfulAndbid.x = this.globalToLocal(new Point(mouseX,mouseY)).x - 10;
         _mouthfulAndbid.y = this.globalToLocal(new Point(mouseX,mouseY)).y - 10;
         if(_mouthfulAndbid.x > stage.stageWidth - _mouthfulAndbid.width)
         {
            _mouthfulAndbid.x = _mouthfulAndbid.x - _mouthfulAndbid.width + 20;
         }
         this.setChildIndex(_mouthfulAndbid,this.numChildren - 1);
         if(event)
         {
            _mouthfulAndbid.visible = true;
         }
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info)
         {
            if(info.AuctioneerID == PlayerManager.Instance.Self.ID)
            {
               initialiseBtn();
               return;
            }
            var _loc3_:* = info.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc3_;
            _mouthful_btnR.enable = _loc3_;
            _mouthful_btnR.filters = info.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            _loc3_ = info.BuyerID == PlayerManager.Instance.Self.ID?false:true;
            _bid_btn.enable = _loc3_;
            _bid_btnR.enable = _loc3_;
            _bid_btnR.filters = info.BuyerID == PlayerManager.Instance.Self.ID?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            if(info.BuyerID != PlayerManager.Instance.Self.ID)
            {
               _bidMoney.canMoneyBid(info.Price + info.Rise);
            }
            else
            {
               _bidMoney.cannotBid();
            }
         }
      }
      
      private function __bid(event:MouseEvent) : void
      {
         event = event;
         _bidKeyUp = function(e:Event):void
         {
            SoundManager.instance.play("008");
            __bidII();
            alert1.removeEventListener("response",_responseII);
            _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
            ObjectUtils.disposeObject(alert1);
            _bidMoney = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.BidMoneyView");
         };
         _responseII = function(evt:FrameEvent):void
         {
            SoundManager.instance.play("008");
            _checkResponse(evt.responseCode,__bidII,__cannel);
            var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
            alert.removeEventListener("response",_responseII);
            _bidMoney.removeEventListener("money_key_up",_bidKeyUp);
            ObjectUtils.disposeObject(evt.target);
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
            var info:AuctionGoodsInfo = _right.getSelectInfo();
            if(info)
            {
               SocketManager.Instance.out.auctionBid(info.AuctionID,_bidMoney.getData());
            }
            return;
         }
      }
      
      private function __mouthFull(event:MouseEvent) : void
      {
         var alert:* = null;
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
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info.Mouthful > PlayerManager.Instance.Self.Money)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",_responseI);
            return;
         }
         var alert1:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.buy"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert1.moveEnable = false;
         alert1.addEventListener("response",_responseII);
      }
      
      private function _responseI(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _checkResponse(evt.responseCode,LeavePageManager.leaveToFillPath,_cancelFun);
         var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
         alert.removeEventListener("response",_responseI);
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function _responseII(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _checkResponse(evt.responseCode,__callMouthFull,__cannel);
         var alert:BaseAlerFrame = BaseAlerFrame(evt.currentTarget);
         alert.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function __callMouthFull() : void
      {
         var i:int = 0;
         if(_btClickLock)
         {
            _btClickLock = false;
            var info:AuctionGoodsInfo = _right.getSelectInfo();
            if(info)
            {
               SocketManager.Instance.out.auctionBid(info.AuctionID,info.Mouthful);
               IMManager.Instance.saveRecentContactsID(info.AuctioneerID);
               if(SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] == null)
               {
                  SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID] = [];
               }
               for(i = 0; i < SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID].length; )
               {
                  if(SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID][i] == info.AuctionID)
                  {
                     SharedManager.Instance.AuctionIDs[PlayerManager.Instance.Self.ID].splice(i,1);
                  }
                  i++;
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
         var info:AuctionGoodsInfo = _right.getSelectInfo();
         if(info)
         {
            var _loc2_:* = info.Mouthful == 0?false:true;
            _mouthful_btn.enable = _loc2_;
            _mouthful_btnR.enable = _loc2_;
            _mouthful_btnR.filters = info.Mouthful == 0?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
            _loc2_ = info.BuyerID == PlayerManager.Instance.Self.ID?false:true;
            _bid_btn.enable = _loc2_;
            _bid_btnR.enable = _loc2_;
            _bid_btnR.filters = info.BuyerID == PlayerManager.Instance.Self.ID?ComponentFactory.Instance.creatFilters("grayFilter"):ComponentFactory.Instance.creatFilters("lightFilter");
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
      
      private function __addToStage(event:Event) : void
      {
         initialiseBtn();
         _bidMoney.cannotBid();
      }
      
      private function _checkResponse(keyCode:int, submitFun:Function = null, cancelFun:Function = null, closeFun:Function = null) : void
      {
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
