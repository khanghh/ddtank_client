package consortionBattle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsBatResurrectView extends Sprite implements Disposeable
   {
      
      public static const FIGHT:int = 2;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _resurrectBtn:SimpleBitmapButton;
      
      private var _stayResBtn:SimpleBitmapButton;
      
      private var _timeCD:MovieClip;
      
      private var _txtProp:FilterFrameText;
      
      private var _totalCount:int;
      
      private var _timer:TimerJuggler;
      
      private var _consumeCount:int = 5;
      
      private var _lastCreatTime2:int = 0;
      
      private var _lastCreatTime:int = 0;
      
      public function ConsBatResurrectView(param1:int)
      {
         super();
         _totalCount = param1;
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.resurrectBg");
         addChild(_bg);
         _txtProp = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.resurrect.txtProp");
         addChild(_txtProp);
         _txtProp.text = LanguageMgr.GetTranslation("worldboss.resurrectView.prop");
         _timeCD = ComponentFactory.Instance.creat("asset.consortiaBattle.resurrectTimeCD");
         PositionUtils.setPos(_timeCD,"consortiaBattle.timeCDPos");
         addChild(_timeCD);
         _resurrectBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.resurrect.btn");
         addChild(_resurrectBtn);
         _stayResBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.stayRes.btn");
         addChild(_stayResBtn);
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__startCount);
         _timer.start();
      }
      
      private function __startCount(param1:Event) : void
      {
         if(_totalCount < 0)
         {
            __timerComplete();
            return;
         }
         var _loc2_:String = setFormat(int(_totalCount / 3600)) + ":" + setFormat(int(_totalCount / 60 % 60)) + ":" + setFormat(int(_totalCount % 60));
         (_timeCD["timeHour2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(0));
         (_timeCD["timeHour"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(1));
         (_timeCD["timeMint2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(3));
         (_timeCD["timeMint"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(4));
         (_timeCD["timeSecond2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(6));
         (_timeCD["timeSecond"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(7));
         _totalCount = Number(_totalCount) - 1;
      }
      
      private function setFormat(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(param1 < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      protected function __timerComplete() : void
      {
         if(_consumeCount >= 5)
         {
            SocketManager.Instance.out.sendConsBatConsume(5,true);
            _consumeCount = 0;
         }
         else
         {
            _consumeCount = Number(_consumeCount) + 1;
         }
      }
      
      private function addEvent() : void
      {
         _resurrectBtn.addEventListener("click",__resurrect,false,0,true);
         _stayResBtn.addEventListener("click",__stayRes,false,0,true);
      }
      
      private function __stayRes(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastCreatTime2 > 1000)
         {
            _lastCreatTime2 = getTimer();
            promptlyStayRevive();
         }
      }
      
      protected function promptlyStayRevive() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc1_:Object = ConsortiaBattleManager.instance.getBuyRecordStatus(3);
         if(_loc1_.isNoPrompt)
         {
            if(_loc1_.isBand && PlayerManager.Instance.Self.BandMoney < 80)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               _loc1_.isNoPrompt = false;
            }
            else if(!_loc1_.isBand && PlayerManager.Instance.Self.Money < 80)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughMoneyTxt"));
               _loc1_.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendConsBatConsume(4,_loc1_.isBand);
               return;
            }
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.buyStayResurrect.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"ConsBatBuyConfirmView",30,true,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__StayResurrectConfirm,false,0,true);
      }
      
      protected function __StayResurrectConfirm(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",__StayResurrectConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_loc4_.isBand && PlayerManager.Instance.Self.BandMoney < 80)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.changeMoneyCostTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",__StayResurrectTwoConfirm,false,0,true);
               return;
            }
            if(!_loc4_.isBand && PlayerManager.Instance.Self.Money < 80)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc4_ as ConsBatBuyConfirmView).isNoPrompt)
            {
               _loc3_ = ConsortiaBattleManager.instance.getBuyRecordStatus(3);
               _loc3_.isNoPrompt = true;
               _loc3_.isBand = _loc4_.isBand;
            }
            SocketManager.Instance.out.sendConsBatConsume(4,_loc4_.isBand);
         }
      }
      
      protected function __StayResurrectTwoConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__StayResurrectTwoConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < 80)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendConsBatConsume(4,false);
         }
      }
      
      private function __resurrect(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            promptlyRevive();
         }
      }
      
      protected function promptlyRevive() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc1_:Object = ConsortiaBattleManager.instance.getBuyRecordStatus(2);
         if(_loc1_.isNoPrompt)
         {
            if(_loc1_.isBand && PlayerManager.Instance.Self.BandMoney < 50)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               _loc1_.isNoPrompt = false;
            }
            else if(!_loc1_.isBand && PlayerManager.Instance.Self.Money < 50)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughMoneyTxt"));
               _loc1_.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendConsBatConsume(3,_loc1_.isBand);
               return;
            }
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.buyResurrect.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"ConsBatBuyConfirmView",30,true,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__resurrectConfirm,false,0,true);
      }
      
      protected function __resurrectConfirm(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",__resurrectConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_loc4_.isBand && PlayerManager.Instance.Self.BandMoney < 50)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.changeMoneyCostTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",__resurrectTwoConfirm,false,0,true);
               return;
            }
            if(!_loc4_.isBand && PlayerManager.Instance.Self.Money < 50)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc4_ as ConsBatBuyConfirmView).isNoPrompt)
            {
               _loc3_ = ConsortiaBattleManager.instance.getBuyRecordStatus(2);
               _loc3_.isNoPrompt = true;
               _loc3_.isBand = _loc4_.isBand;
            }
            SocketManager.Instance.out.sendConsBatConsume(3,_loc4_.isBand);
         }
      }
      
      protected function __resurrectTwoConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__resurrectTwoConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < 50)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendConsBatConsume(3,false);
         }
      }
      
      private function removeEvent() : void
      {
         if(_resurrectBtn)
         {
            _resurrectBtn.removeEventListener("click",__resurrect);
         }
         if(_stayResBtn)
         {
            _stayResBtn.removeEventListener("click",__stayRes);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__startCount);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _bg = null;
         _txtProp = null;
         _resurrectBtn = null;
         _stayResBtn = null;
         _timeCD = null;
      }
   }
}
