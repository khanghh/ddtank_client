package quest
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickUseFrame;
   import ddt.command.StripTip;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingBless.KingBlessManager;
   
   public class TrusteeshipView extends Sprite implements Disposeable
   {
       
      
      private var _spiritImage:Bitmap;
      
      private var _spiritValueTxtBg:Image;
      
      private var _speedUpBg:Bitmap;
      
      private var _spiritValueTxt:FilterFrameText;
      
      private var _speedUpTipTxt:FilterFrameText;
      
      private var _speedUpTimeTxt:FilterFrameText;
      
      private var _speedUpBtn:SimpleBitmapButton;
      
      private var _startCancelBtn:TextButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _buyBtnStrip:StripTip;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _questInfo:QuestInfo;
      
      private var _callback:Function;
      
      private var _questBtn:BaseButton;
      
      private var _confirmFrame:BaseAlerFrame;
      
      public function TrusteeshipView()
      {
         super();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _spiritImage = ComponentFactory.Instance.creatBitmap("asset.trusteeship.spiritImage");
         _spiritValueTxtBg = ComponentFactory.Instance.creatComponentByStylename("trusteeship.spiritTxtBg");
         _spiritValueTxtBg.tipData = LanguageMgr.GetTranslation("ddt.trusteeship.maxSpiritTipTxt",TrusteeshipManager.instance.maxSpiritValue);
         _speedUpBg = ComponentFactory.Instance.creatBitmap("asset.trusteeship.speedUpBg");
         _spiritValueTxt = ComponentFactory.Instance.creatComponentByStylename("trusteeship.spiritValueTxt");
         refreshSpiritTxt();
         _speedUpTipTxt = ComponentFactory.Instance.creatComponentByStylename("trusteeship.speedUpTipTxt");
         _speedUpTipTxt.text = LanguageMgr.GetTranslation("ddt.trusteeship.speedUpTipTxt");
         _speedUpTimeTxt = ComponentFactory.Instance.creatComponentByStylename("trusteeship.speedUpTimeTxt");
         _speedUpBtn = ComponentFactory.Instance.creatComponentByStylename("trusteeship.speedUpBtn");
         _startCancelBtn = ComponentFactory.Instance.creatComponentByStylename("trusteeship.startCancelBtn");
         _startCancelBtn.text = LanguageMgr.GetTranslation("ddt.trusteeship.startTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("trusteeship.buyBtn");
         _buyBtn.tipData = LanguageMgr.GetTranslation("ddt.trusteeship.buySpiritBtnTipTxt");
         _buyBtnStrip = ComponentFactory.Instance.creatCustomObject("trusteeship.buyBtnStrip");
         _buyBtnStrip.tipData = LanguageMgr.GetTranslation("ddt.trusteeship.buySpiritBtnTipTxt");
         refreshBuyBtn(null);
         addChild(_spiritImage);
         addChild(_spiritValueTxtBg);
         addChild(_speedUpBg);
         addChild(_spiritValueTxt);
         addChild(_speedUpTipTxt);
         addChild(_speedUpTimeTxt);
         addChild(_speedUpBtn);
         addChild(_startCancelBtn);
         addChild(_buyBtn);
         addChild(_buyBtnStrip);
      }
      
      private function refreshBuyBtn(event:Event) : void
      {
         if(ServerConfigManager.instance.getIsBuyQuestEnereyNeedKingBuff)
         {
            _buyBtn.enable = false;
            _buyBtnStrip.visible = true;
         }
         else
         {
            _buyBtn.enable = true;
            _buyBtnStrip.visible = false;
         }
      }
      
      public function refreshSpiritTxt() : void
      {
         _spiritValueTxt.text = TrusteeshipManager.instance.spiritValue.toString();
      }
      
      private function initEvent() : void
      {
         _startCancelBtn.addEventListener("click",startCancelHandler,false,0,true);
         _speedUpBtn.addEventListener("click",speedUpHandler,false,0,true);
         _buyBtn.addEventListener("click",buyHandler);
         KingBlessManager.instance.addEventListener("update_main_event",refreshBuyBtn);
      }
      
      private function startCancelHandler(event:MouseEvent) : void
      {
         var msg:* = null;
         var cost:int = 0;
         var quick:* = null;
         var needNum:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_speedUpBtn.visible)
         {
            msg = LanguageMgr.GetTranslation("ddt.trusteeship.cancelTipTxt");
         }
         else
         {
            if(!TrusteeshipManager.instance.isCanStart())
            {
               if(TrusteeshipManager.instance.isHasTrusteeshipQuestUnaviable())
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.trusteeship.refreshTrusteeshipStateTxt"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.trusteeship.cannotStartTipTxt"));
               }
               return;
            }
            cost = _questInfo.TrusteeshipCost;
            if(TrusteeshipManager.instance.spiritValue < cost)
            {
               quick = ComponentFactory.Instance.creat("ddtcore.QuickUseFrame");
               needNum = (TrusteeshipManager.instance.maxSpiritValue - TrusteeshipManager.instance.spiritValue) / 20;
               quick.setItemInfo(11918,cost,1,needNum);
               return;
            }
            msg = LanguageMgr.GetTranslation("ddt.trusteeship.startTipTxt",_questInfo.TrusteeshipNeedTime,cost);
         }
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirmStartCancel);
      }
      
      private function __confirmStartCancel(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmStartCancel);
         _confirmFrame = null;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(_speedUpBtn.visible)
            {
               SocketManager.Instance.out.sendTrusteeshipCancel(_questInfo.id);
            }
            else
            {
               SocketManager.Instance.out.sendTrusteeshipStart(_questInfo.id);
            }
         }
      }
      
      private function speedUpHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var minute:int = _count / (60000 / 1000);
         var second:int = _count % (60000 / 1000);
         var needTime:int = minute + (second > 0?1:0);
         var needMoney:int = needTime * TrusteeshipManager.instance.speedUpOneMinNeedMoney;
         var msg:String = LanguageMgr.GetTranslation("ddt.trusteeship.speedUpCostTipTxt",needMoney);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirmSpeedUp);
      }
      
      private function __confirmSpeedUp(evt:FrameEvent) : void
      {
         var minute:int = 0;
         var second:int = 0;
         var needTime:int = 0;
         var needMoney:int = 0;
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmSpeedUp);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            minute = _count / (60000 / 1000);
            second = _count % (60000 / 1000);
            needTime = minute + (second > 0?1:0);
            needMoney = needTime * TrusteeshipManager.instance.speedUpOneMinNeedMoney;
            CheckMoneyUtils.instance.checkMoney(evt.currentTarget.isBand,needMoney,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendTrusteeshipSpeedUp(_questInfo.id,CheckMoneyUtils.instance.isBind);
         _confirmFrame = null;
      }
      
      private function buyHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(TrusteeshipManager.instance.spiritValue >= TrusteeshipManager.instance.maxSpiritValue)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.trusteeship.maxSpiritCannotBuyTxt"));
            return;
         }
         var msg:String = LanguageMgr.GetTranslation("ddt.trusteeship.buySpiritCostTipTxt",TrusteeshipManager.instance.buyOnceNeedMoney,TrusteeshipManager.instance.buyOnceSpiritValue);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirmBuySpirit);
      }
      
      private function __confirmBuySpirit(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            CheckMoneyUtils.instance.checkMoney(_confirmFrame.isBand,TrusteeshipManager.instance.buyOnceNeedMoney,onCheckComplete2);
         }
         _confirmFrame.removeEventListener("response",__confirmBuySpirit);
         _confirmFrame.dispose();
         _confirmFrame = null;
      }
      
      protected function onCheckComplete2() : void
      {
         SocketManager.Instance.out.sendTrusteeshipBuySpirit(_confirmFrame.isBand);
      }
      
      public function refreshView(questInfo:QuestInfo, callback:Function, questBtn:BaseButton) : void
      {
         var endTimestamp:Number = NaN;
         var nowTimestamp:Number = NaN;
         _questInfo = questInfo;
         _callback = callback;
         _questBtn = questBtn;
         if(_questInfo.isCompleted)
         {
            taskCompleteState();
            return;
         }
         var vo:TrusteeshipDataVo = TrusteeshipManager.instance.getTrusteeshipInfo(_questInfo.id);
         if(!vo)
         {
            _questBtn.visible = true;
            _speedUpBg.visible = false;
            _speedUpTipTxt.visible = false;
            _speedUpTimeTxt.visible = false;
            _speedUpBtn.visible = false;
            _startCancelBtn.visible = true;
            _startCancelBtn.text = LanguageMgr.GetTranslation("ddt.trusteeship.startTxt");
            _timer.stop();
         }
         else
         {
            _questBtn.visible = false;
            _speedUpBg.visible = true;
            _speedUpTipTxt.visible = true;
            _speedUpTimeTxt.visible = true;
            _speedUpBtn.visible = true;
            _startCancelBtn.visible = true;
            _startCancelBtn.text = LanguageMgr.GetTranslation("ddt.trusteeship.cancelTxt");
            endTimestamp = vo.endTime.getTime();
            nowTimestamp = TimeManager.Instance.Now().getTime();
            _count = int((endTimestamp - nowTimestamp) / 1000);
            if(_count > 0)
            {
               _speedUpTimeTxt.text = getTimeStr(_count);
               _timer.reset();
               _timer.start();
            }
            else
            {
               taskCompleteState();
            }
         }
      }
      
      public function clearSome() : void
      {
         _questInfo = null;
         _callback = null;
         _questBtn = null;
         _timer.stop();
      }
      
      private function taskCompleteState() : void
      {
         _timer.stop();
         _speedUpBg.visible = false;
         _speedUpTipTxt.visible = false;
         _speedUpTimeTxt.visible = false;
         _speedUpBtn.visible = false;
         _startCancelBtn.visible = false;
         if(_callback != null)
         {
            _callback(true);
         }
         _callback = null;
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         _count = Number(_count) - 1;
         if(_count <= 0)
         {
            taskCompleteState();
         }
         else
         {
            _speedUpTimeTxt.text = getTimeStr(_count);
         }
      }
      
      private function getTimeStr(count:int) : String
      {
         var hour:int = count / (3600000 / 1000);
         var hourRest:int = count % (3600000 / 1000);
         var minute:int = hourRest / (60000 / 1000);
         var second:int = hourRest % (60000 / 1000);
         return LanguageMgr.GetTranslation("ddt.trusteeship.speedUpTimeTxt",getTimeStrOO(hour),getTimeStrOO(minute),getTimeStrOO(second));
      }
      
      private function getTimeStrOO(value:int) : String
      {
         if(value == 0)
         {
            return "00";
         }
         if(value < 10)
         {
            return "0" + value;
         }
         return value.toString();
      }
      
      private function removeEvent() : void
      {
         if(_startCancelBtn)
         {
            _startCancelBtn.removeEventListener("click",startCancelHandler);
         }
         if(_speedUpBtn)
         {
            _speedUpBtn.removeEventListener("click",speedUpHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",buyHandler);
         }
         KingBlessManager.instance.removeEventListener("update_main_event",refreshBuyBtn);
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
         }
         _timer = null;
         _questInfo = null;
         _callback = null;
         _questBtn = null;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _spiritImage = null;
         _spiritValueTxtBg = null;
         _speedUpBg = null;
         _spiritValueTxt = null;
         _speedUpTipTxt = null;
         _speedUpTimeTxt = null;
         _speedUpBtn = null;
         _startCancelBtn = null;
         _buyBtn = null;
         _buyBtnStrip = null;
         if(_confirmFrame)
         {
            _confirmFrame.removeEventListener("response",__confirmBuySpirit);
            _confirmFrame.removeEventListener("response",__confirmSpeedUp);
            _confirmFrame.removeEventListener("response",__confirmStartCancel);
            ObjectUtils.disposeObject(_confirmFrame);
         }
         _confirmFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
