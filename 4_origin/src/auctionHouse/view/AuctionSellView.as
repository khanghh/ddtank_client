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
      
      public function AuctionSellView(param1:AuctionHouseController, param2:AuctionHouseModel)
      {
         super();
         _controller = param1;
         _model = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _right = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.AuctionRightView");
         _right.setup("sell");
         addChild(_right);
         _left = ComponentFactory.Instance.creatCustomObject("auctionHouse.view.AuctionSellLeftView");
         addChildAt(_left,0);
         _cancelBid_btn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.CancelBid_btn");
         addChild(_cancelBid_btn);
         _sendBugle = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SendBugle");
         addChild(_sendBugle);
      }
      
      private function addEvent() : void
      {
         _cancelBid_btn.addEventListener("click",__cancel);
         _sendBugle.addEventListener("click",__sendBugle);
         addEventListener("removedFromStage",__removeStage);
         _right.prePage_btn.addEventListener("click",__pre);
         _right.nextPage_btn.addEventListener("click",__next);
         _right.addEventListener("sortChange",sortChange);
         _right.addEventListener("selectStrip",__selectStrip);
         this.addEventListener("addedToStage",__addToStage);
      }
      
      private function removeEvent() : void
      {
         _right.removeEventListener("sortChange",sortChange);
         _cancelBid_btn.removeEventListener("click",__cancel);
         _sendBugle.removeEventListener("click",__sendBugle);
         removeEventListener("removedFromStage",__removeStage);
         _right.prePage_btn.removeEventListener("click",__pre);
         _right.nextPage_btn.removeEventListener("click",__next);
         _right.removeEventListener("selectStrip",__selectStrip);
         this.removeEventListener("addedToStage",__addToStage);
      }
      
      private function __addToStage(param1:Event) : void
      {
         _cancelBid_btn.enable = false;
         _sendBugle.enable = false;
         _left.addStage();
      }
      
      function clearLeft() : void
      {
         _left.clear();
      }
      
      function clearList() : void
      {
         _right.clearList();
      }
      
      function hideReady() : void
      {
         _left.hideReady();
         _right.hideReady();
      }
      
      function addAuction(param1:AuctionGoodsInfo) : void
      {
         _right.addAuction(param1);
      }
      
      function setPage(param1:int, param2:int) : void
      {
         _right.setPage(param1,param2);
      }
      
      function updateList(param1:AuctionGoodsInfo) : void
      {
         _right.updateAuction(param1);
      }
      
      private function __sendBugle(param1:MouseEvent) : void
      {
         e = param1;
         if(SharedManager.Instance.isAuctionHouseTodayUseBugle)
         {
            if(_selectCheckBtn == null)
            {
               _selectCheckBtn = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.noMoraAlert");
               _selectCheckBtn.text = LanguageMgr.GetTranslation("dice.alert.nextPrompt");
            }
            var alert1:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellLeftView.UseBugle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert1.moveEnable = false;
            alert1.addChild(_selectCheckBtn);
            alert1.addEventListener("response",function(param1:FrameEvent):void
            {
               if(param1.responseCode == 2 || param1.responseCode == 3)
               {
                  if(_selectCheckBtn.selected)
                  {
                     SharedManager.Instance.isAuctionHouseTodayUseBugle = !_selectCheckBtn.selected;
                  }
                  ChatManager.Instance.sendFastAuctionBugle(_right.getSelectInfo().AuctionID);
               }
               alert1.dispose();
               _selectCheckBtn.dispose();
               _selectCheckBtn = null;
            });
         }
         else
         {
            ChatManager.Instance.sendFastAuctionBugle(_right.getSelectInfo().AuctionID);
         }
      }
      
      private function __cancel(param1:MouseEvent) : void
      {
         SoundManager.instance.play("043");
         _btClickLock = true;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _cancelBid_btn.enable = false;
         _sendBugle.enable = false;
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellView.cancel"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _loc2_.addEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_response);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               __cannelNo();
               break;
            case 2:
            case 3:
            case 4:
               __cancelOk();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function __cancelOk() : void
      {
         if(_btClickLock)
         {
            _btClickLock = false;
            if(_right.getSelectInfo())
            {
               if(_right.getSelectInfo().BuyerName != "")
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellView.Price"));
                  return;
               }
               SocketManager.Instance.out.auctionCancelSell(_right.getSelectInfo().AuctionID);
               _controller.model.sellTotal = _controller.model.sellTotal - 1;
               _right.clearSelectStrip();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionSellView.Choose"));
            }
            SoundManager.instance.play("008");
            _cancelBid_btn.enable = false;
            _sendBugle.enable = false;
            return;
         }
      }
      
      private function __cannelNo() : void
      {
         SoundManager.instance.play("008");
         _cancelBid_btn.enable = true;
         _sendBugle.enable = true;
      }
      
      private function __removeStage(param1:Event) : void
      {
         _left.clear();
      }
      
      private function __next(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         _cancelBid_btn.enable = false;
         _sendBugle.enable = false;
         dispatchEvent(new AuctionHouseEvent("nextPage"));
      }
      
      private function __pre(param1:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         _cancelBid_btn.enable = false;
         _sendBugle.enable = false;
         dispatchEvent(new AuctionHouseEvent("prePage"));
      }
      
      private function sortChange(param1:AuctionHouseEvent) : void
      {
         _cancelBid_btn.enable = false;
         _sendBugle.enable = false;
         _model.sellCurrent = 1;
         _controller.searchAuctionList(1,"",-1,-1,PlayerManager.Instance.Self.ID,-1,_right.sortCondition,_right.sortBy.toString());
      }
      
      function searchByCurCondition(param1:int, param2:int = -1) : void
      {
         _controller.searchAuctionList(param1,"",-1,-1,param2,-1,_right.sortCondition,_right.sortBy.toString());
      }
      
      private function __selectStrip(param1:AuctionHouseEvent) : void
      {
         if(_right.getSelectInfo())
         {
            if(_right.getSelectInfo().BuyerName != "")
            {
               _cancelBid_btn.enable = false;
               _sendBugle.enable = false;
            }
            else
            {
               _cancelBid_btn.enable = true;
               _sendBugle.enable = true;
            }
         }
      }
      
      public function get this_left() : AuctionSellLeftView
      {
         return _left;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_right)
         {
            ObjectUtils.disposeObject(_right);
         }
         _right = null;
         if(_left)
         {
            ObjectUtils.disposeObject(_left);
         }
         _left = null;
         if(_cancelBid_btn)
         {
            ObjectUtils.disposeObject(_cancelBid_btn);
         }
         _cancelBid_btn = null;
         if(_sendBugle)
         {
            ObjectUtils.disposeObject(_sendBugle);
         }
         _sendBugle = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
