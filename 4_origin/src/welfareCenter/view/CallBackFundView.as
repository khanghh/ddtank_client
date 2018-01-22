package welfareCenter.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import welfareCenter.callBackFund.CallBackFundManager;
   
   public class CallBackFundView extends Sprite implements Disposeable
   {
       
      
      private var _btnSp:Sprite;
      
      private var _quickBuyBtn:SimpleBitmapButton;
      
      private var _quickReceiveBtn:SimpleBitmapButton;
      
      private var _tomorrowComeBtn:SimpleBitmapButton;
      
      private var _receiveOverBtn:SimpleBitmapButton;
      
      private var _callBackFunMgr:CallBackFundManager;
      
      private var _rewardsHBox:HBox;
      
      private var _rewardsHBox1:HBox;
      
      public function CallBackFundView()
      {
         super();
         _callBackFunMgr = CallBackFundManager.instance;
         initView();
         initEvent();
         update(null);
      }
      
      private function initView() : void
      {
         UICreatShortcut.creatAndAdd("callBackFund.bg",this);
         var _loc2_:Date = _callBackFunMgr.startTime;
         var _loc1_:String = _loc2_.fullYear + "." + (_loc2_.month + 1) + "." + _loc2_.date;
         var _loc4_:Date = _callBackFunMgr.endTime;
         var _loc5_:String = _loc4_.fullYear + "." + (_loc4_.month + 1) + "." + _loc4_.date;
         UICreatShortcut.creatTextAndAdd("callbackfund.openTimeTf",_loc1_ + "-" + _loc5_,this);
         var _loc3_:String = LanguageMgr.GetTranslation("callBackFund.frame.contentText",_callBackFunMgr.buyFundCount,6);
         UICreatShortcut.creatTextAndAdd("callbackfund.contentTf",_loc3_,this);
         _btnSp = new Sprite();
         addChild(_btnSp);
         setGoods();
      }
      
      private function setGoods() : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:Array = CallBackFundManager.instance.dailyRewardInfoList;
         if(_loc3_)
         {
            _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("callBackFund.dailyView.rewardsHBox");
            addChild(_rewardsHBox);
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc2_ = CallBackFundManager.instance.createCell(_loc3_[_loc6_]);
               _rewardsHBox.addChild(_loc2_);
               _loc6_++;
            }
         }
         var _loc1_:Array = CallBackFundManager.instance.downRewardInfoList;
         if(_loc1_)
         {
            _rewardsHBox1 = ComponentFactory.Instance.creatComponentByStylename("callBackFund.downView.rewardsHBox");
            addChild(_rewardsHBox1);
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc4_ = CallBackFundManager.instance.createCell(_loc1_[_loc5_]);
               _rewardsHBox1.addChild(_loc4_);
               _loc5_++;
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler);
         addEventListener("click",onBtnClick);
         CallBackFundManager.instance.addEventListener("event_state_change",update);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         removeEventListener("click",onBtnClick);
         CallBackFundManager.instance.removeEventListener("event_state_change",update);
      }
      
      private function update(param1:Event) : void
      {
         ObjectUtils.removeChildAllChildren(_btnSp);
         var _loc2_:int = CallBackFundManager.instance.state;
         if(_loc2_ == 0)
         {
            _quickBuyBtn = UICreatShortcut.creatAndAdd("callBackFund.quickBuyBtn",_btnSp);
            _quickBuyBtn.mouseChildren = false;
         }
         else if(_loc2_ == 1)
         {
            _quickReceiveBtn = UICreatShortcut.creatAndAdd("callBackFund.quickReceiveBtn",_btnSp);
            _quickReceiveBtn.mouseChildren = false;
         }
         else if(_loc2_ == 2)
         {
            _tomorrowComeBtn = UICreatShortcut.creatAndAdd("callBackFund.tomorrowComeBtn",_btnSp);
            UICreatShortcut.creatTextAndAdd("callbackfund.leftDayTf",LanguageMgr.GetTranslation("callBackFund.frame.leftDayText",_callBackFunMgr.getLeftReceiveTime()),_btnSp);
         }
         else
         {
            _receiveOverBtn = UICreatShortcut.creatAndAdd("callBackFund.receiveOverBtn",_btnSp);
         }
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         evt = param1;
         var target:* = evt.target;
         if(target == _quickBuyBtn)
         {
            onAlertFrameResponse = function(param1:FrameEvent):void
            {
               if(param1.responseCode == 3 || param1.responseCode == 2)
               {
                  CheckMoneyUtils.instance.checkMoney(false,_callBackFunMgr.buyFundCount,onCheckComplete);
               }
               _payAlert.removeEventListener("response",onAlertFrameResponse);
               ObjectUtils.disposeObject(_payAlert);
            };
            onCheckComplete = function():void
            {
               SocketManager.Instance.out.BuyCallFund();
            };
            SoundManager.instance.playButtonSound();
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(!CallBackFundManager.instance.isOpen)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callBackFund.frame.activityFinish"));
               return;
            }
            var msg:String = LanguageMgr.GetTranslation("callbackfund.buyFundTip",_callBackFunMgr.buyFundCount);
            var _payAlert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",50,true,0);
            _payAlert.enterEnable = false;
            _payAlert.addEventListener("response",onAlertFrameResponse);
         }
         else if(target == _quickReceiveBtn)
         {
            SoundManager.instance.playButtonSound();
            SocketManager.Instance.out.getCallFund();
         }
         else if(target == _tomorrowComeBtn || target == _receiveOverBtn)
         {
            SoundManager.instance.playButtonSound();
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callBackFund.frame.receive"));
         }
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            dispose();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _btnSp = null;
         _quickBuyBtn = null;
         _quickReceiveBtn = null;
         _tomorrowComeBtn = null;
         _receiveOverBtn = null;
         _callBackFunMgr = null;
      }
   }
}
