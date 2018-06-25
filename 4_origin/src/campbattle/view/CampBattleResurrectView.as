package campbattle.view
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
   import consortionBattle.view.ConsBatBuyConfirmView;
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
   
   public class CampBattleResurrectView extends Sprite implements Disposeable
   {
      
      public static const FIGHT:int = 2;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _resurrectBtn:SimpleBitmapButton;
      
      private var _timeCD:MovieClip;
      
      private var _txtProp:FilterFrameText;
      
      private var _totalCount:int;
      
      private var timer:TimerJuggler;
      
      private var _lastCreatTime:int = 0;
      
      public function CampBattleResurrectView(totalCount:int)
      {
         super();
         this.x = -113;
         this.y = -121;
         _totalCount = totalCount;
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
         PositionUtils.setPos(_resurrectBtn,"campBattle.resurrect.Pos");
         addChild(_resurrectBtn);
         timer = TimerManager.getInstance().addTimerJuggler(1000,_totalCount + 1);
         timer.addEventListener("timer",__startCount);
         timer.addEventListener("timerComplete",__timerComplete);
         timer.start();
      }
      
      private function addEvent() : void
      {
         _resurrectBtn.addEventListener("click",__resurrect);
      }
      
      private function __resurrect(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            promptlyRevive();
         }
      }
      
      public function __startCount(e:Event) : void
      {
         if(_totalCount < 0)
         {
            __timerComplete();
            return;
         }
         var str:String = setFormat(int(_totalCount / 3600)) + ":" + setFormat(int(_totalCount / 60 % 60)) + ":" + setFormat(int(_totalCount % 60));
         (_timeCD["timeHour2"] as MovieClip).gotoAndStop("num_" + str.charAt(0));
         (_timeCD["timeHour"] as MovieClip).gotoAndStop("num_" + str.charAt(1));
         (_timeCD["timeMint2"] as MovieClip).gotoAndStop("num_" + str.charAt(3));
         (_timeCD["timeMint"] as MovieClip).gotoAndStop("num_" + str.charAt(4));
         (_timeCD["timeSecond2"] as MovieClip).gotoAndStop("num_" + str.charAt(6));
         (_timeCD["timeSecond"] as MovieClip).gotoAndStop("num_" + str.charAt(7));
         _totalCount = Number(_totalCount) - 1;
      }
      
      private function removeEvent() : void
      {
         if(_resurrectBtn)
         {
            _resurrectBtn.removeEventListener("click",__resurrect);
         }
      }
      
      protected function promptlyRevive() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpObj:Object = ConsortiaBattleManager.instance.getBuyRecordStatus(2);
         if(tmpObj.isNoPrompt)
         {
            if(tmpObj.isBand && PlayerManager.Instance.Self.BandMoney < 50)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               tmpObj.isNoPrompt = false;
            }
            else if(!tmpObj.isBand && PlayerManager.Instance.Self.Money < 50)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughMoneyTxt"));
               tmpObj.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.resurrect(tmpObj.isBand);
               dispose();
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.buyResurrect.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"ConsBatBuyConfirmView",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__resurrectConfirm,false,0,true);
      }
      
      protected function __resurrectConfirm(evt:FrameEvent) : void
      {
         var tmpObj:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__resurrectConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < 50)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < 50)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as ConsBatBuyConfirmView).isNoPrompt)
            {
               tmpObj = ConsortiaBattleManager.instance.getBuyRecordStatus(2);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            dispose();
            SocketManager.Instance.out.resurrect(confirmFrame.isBand);
         }
      }
      
      private function setFormat(value:int) : String
      {
         var str:String = value.toString();
         if(value < 10)
         {
            str = "0" + str;
         }
         return str;
      }
      
      protected function __timerComplete(e:Event = null) : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         timer.stop();
         timer.removeEventListener("timer",__startCount);
         timer.removeEventListener("timerComplete",__timerComplete);
         TimerManager.getInstance().removeJugglerByTimer(timer);
         timer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _bg = null;
         _txtProp = null;
         _resurrectBtn = null;
         _timeCD = null;
      }
   }
}
