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
         var startTime:Date = _callBackFunMgr.startTime;
         var startTimeStr:String = startTime.fullYear + "." + (startTime.month + 1) + "." + startTime.date;
         var endTime:Date = _callBackFunMgr.endTime;
         var endTimeStr:String = endTime.fullYear + "." + (endTime.month + 1) + "." + endTime.date;
         UICreatShortcut.creatTextAndAdd("callbackfund.openTimeTf",startTimeStr + "-" + endTimeStr,this);
         var contextTxt:String = LanguageMgr.GetTranslation("callBackFund.frame.contentText",_callBackFunMgr.buyFundCount,6);
         UICreatShortcut.creatTextAndAdd("callbackfund.contentTf",contextTxt,this);
         _btnSp = new Sprite();
         addChild(_btnSp);
         setGoods();
      }
      
      private function setGoods() : void
      {
         var i:int = 0;
         var _cell:* = null;
         var k:int = 0;
         var _cell1:* = null;
         var rewards:Array = CallBackFundManager.instance.dailyRewardInfoList;
         if(rewards)
         {
            _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("callBackFund.dailyView.rewardsHBox");
            addChild(_rewardsHBox);
            for(i = 0; i < rewards.length; )
            {
               _cell = CallBackFundManager.instance.createCell(rewards[i]);
               _rewardsHBox.addChild(_cell);
               i++;
            }
         }
         var rewardsdownView:Array = CallBackFundManager.instance.downRewardInfoList;
         if(rewardsdownView)
         {
            _rewardsHBox1 = ComponentFactory.Instance.creatComponentByStylename("callBackFund.downView.rewardsHBox");
            addChild(_rewardsHBox1);
            for(k = 0; k < rewardsdownView.length; )
            {
               _cell1 = CallBackFundManager.instance.createCell(rewardsdownView[k]);
               _rewardsHBox1.addChild(_cell1);
               k++;
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
      
      private function update(evt:Event) : void
      {
         ObjectUtils.removeChildAllChildren(_btnSp);
         var state:int = CallBackFundManager.instance.state;
         if(state == 0)
         {
            _quickBuyBtn = UICreatShortcut.creatAndAdd("callBackFund.quickBuyBtn",_btnSp);
            _quickBuyBtn.mouseChildren = false;
         }
         else if(state == 1)
         {
            _quickReceiveBtn = UICreatShortcut.creatAndAdd("callBackFund.quickReceiveBtn",_btnSp);
            _quickReceiveBtn.mouseChildren = false;
         }
         else if(state == 2)
         {
            _tomorrowComeBtn = UICreatShortcut.creatAndAdd("callBackFund.tomorrowComeBtn",_btnSp);
            UICreatShortcut.creatTextAndAdd("callbackfund.leftDayTf",LanguageMgr.GetTranslation("callBackFund.frame.leftDayText",_callBackFunMgr.getLeftReceiveTime()),_btnSp);
         }
         else
         {
            _receiveOverBtn = UICreatShortcut.creatAndAdd("callBackFund.receiveOverBtn",_btnSp);
         }
      }
      
      private function onBtnClick(evt:MouseEvent) : void
      {
         evt = evt;
         var target:* = evt.target;
         if(target == _quickBuyBtn)
         {
            onAlertFrameResponse = function(evt:FrameEvent):void
            {
               if(evt.responseCode == 3 || evt.responseCode == 2)
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
      
      private function responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
