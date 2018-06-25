package worldboss.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddtBuried.BuriedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import road7th.comm.PackageOut;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   
   public class WorldBossResurrectView extends Sprite implements Disposeable
   {
      
      public static const FIGHT:int = 2;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _resurrectBtn:BaseButton;
      
      private var _reFightBtn:BaseButton;
      
      private var _timeCD:MovieClip;
      
      private var _txtProp:FilterFrameText;
      
      private var _totalCount:int;
      
      private var timer:Timer;
      
      private var alert:WorldBossConfirmFrame;
      
      private var _lastCreatTime:int = 0;
      
      public function WorldBossResurrectView(totalCount:int)
      {
         super();
         _totalCount = totalCount;
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("worldBossRoom.resurrectBg");
         addChild(_bg);
         _txtProp = ComponentFactory.Instance.creat("worldBossRoom.resurrect.txtProp");
         addChild(_txtProp);
         _txtProp.text = LanguageMgr.GetTranslation("worldboss.resurrectView.prop");
         _resurrectBtn = ComponentFactory.Instance.creat("worldbossRoom.resurrect.btn");
         addChild(_resurrectBtn);
         _reFightBtn = ComponentFactory.Instance.creat("worldbossRoom.reFight.btn");
         addChild(_reFightBtn);
         _timeCD = ComponentFactory.Instance.creat("asset.worldboosRoom.timeCD");
         addChild(_timeCD);
         timer = new Timer(1000,_totalCount + 1);
         timer.addEventListener("timer",__startCount);
         timer.addEventListener("timerComplete",__timerComplete);
         timer.start();
      }
      
      private function addEvent() : void
      {
         _resurrectBtn.addEventListener("click",__resurrect);
         _reFightBtn.addEventListener("click",__reFight);
      }
      
      private function __resurrect(e:MouseEvent) : void
      {
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            SoundManager.instance.play("008");
            if(SharedManager.Instance.isResurrect)
            {
               promptlyRevive();
            }
            else
            {
               alert = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.WorldBossConfirmFrame");
               alert.showFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.revive.propMoney",WorldBossManager.Instance.bossInfo.reviveMoney),null,seveIsResurrect);
               alert.addEventListener("response",__onAlertResponse);
            }
         }
      }
      
      private function __reFight(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastCreatTime > 1000)
         {
            _lastCreatTime = getTimer();
            if(SharedManager.Instance.isReFight)
            {
               promptlyFight();
            }
            else
            {
               alert = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.WorldBossConfirmFrame");
               alert.showFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.reFight.propMoney",WorldBossManager.Instance.bossInfo.reFightMoney),null,seveIsReFight);
               alert.addEventListener("response",__onAlertResponse2);
            }
         }
      }
      
      public function __startCount(e:TimerEvent) : void
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
         _resurrectBtn.removeEventListener("click",__resurrect);
         _reFightBtn.removeEventListener("click",__reFight);
      }
      
      private function __onAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            default:
            default:
               alert.dispose();
               alert.removeEventListener("response",__onAlertResponse);
               return;
            case 2:
            case 3:
            default:
               SharedManager.Instance.isResurrectBind = alert.selectedItem.isBind;
               promptlyRevive();
               return;
         }
      }
      
      private function __onAlertResponse2(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            default:
            default:
               alert.dispose();
               alert.removeEventListener("response",__onAlertResponse2);
               return;
            case 2:
            case 3:
            default:
               SharedManager.Instance.isReFightBind = alert.selectedItem.isBind;
               promptlyFight();
               return;
         }
      }
      
      private function seveIsResurrect(bool:Boolean) : void
      {
         SharedManager.Instance.isResurrect = bool;
         SharedManager.Instance.save();
      }
      
      private function seveIsReFight(bool:Boolean) : void
      {
         SharedManager.Instance.isReFight = bool;
         SharedManager.Instance.save();
      }
      
      private function promptlyRevive() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         CheckMoneyUtils.instance.checkMoney(alert.selectedItem.isBind,WorldBossManager.Instance.bossInfo.reviveMoney,onCheckComplete,onCheckCancel);
         if(alert)
         {
            alert.dispose();
            alert.removeEventListener("response",__onAlertResponse);
         }
      }
      
      protected function onCheckCancel() : void
      {
         SharedManager.Instance.isResurrectBind = false;
         SharedManager.Instance.isResurrect = false;
         alert = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.WorldBossConfirmFrame");
         alert.showFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.revive.propMoney",WorldBossManager.Instance.bossInfo.reviveMoney),null,seveIsResurrect);
         alert.addEventListener("response",__onAlertResponse);
      }
      
      protected function onCheckComplete() : void
      {
         requestRevive(1,CheckMoneyUtils.instance.isBind);
      }
      
      private function promptlyFight() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         CheckMoneyUtils.instance.checkMoney(alert.selectedItem.isBind,WorldBossManager.Instance.bossInfo.reFightMoney,onCheckComplete2,onCheckCancel2);
         if(alert)
         {
            alert.dispose();
            alert.removeEventListener("response",__onAlertResponse);
         }
         if(BuriedManager.Instance.checkMoney(SharedManager.Instance.isReFightBind,WorldBossManager.Instance.bossInfo.reFightMoney))
         {
            SharedManager.Instance.isReFightBind = false;
            SharedManager.Instance.isReFight = false;
            if(alert)
            {
               alert.dispose();
            }
            alert = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.WorldBossConfirmFrame");
            alert.showFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.reFight.propMoney",WorldBossManager.Instance.bossInfo.reFightMoney),null,seveIsReFight);
            alert.addEventListener("response",__onAlertResponse2);
            return;
         }
         if(alert)
         {
            alert.dispose();
            alert.removeEventListener("response",__onAlertResponse2);
         }
      }
      
      protected function onCheckCancel2() : void
      {
         SharedManager.Instance.isReFightBind = false;
         SharedManager.Instance.isReFight = false;
         alert = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyBuff.WorldBossConfirmFrame");
         alert.showFrame(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.reFight.propMoney",WorldBossManager.Instance.bossInfo.reFightMoney),null,seveIsReFight);
         alert.addEventListener("response",__onAlertResponse2);
      }
      
      protected function onCheckComplete2() : void
      {
         requestRevive(2,CheckMoneyUtils.instance.isBind);
         WorldBossManager.Instance.dispatchEvent(new WorldBossRoomEvent("startFight"));
      }
      
      private function requestRevive(type:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(37);
         pkg.writeInt(type);
         pkg.writeBoolean(bool);
         SocketManager.Instance.socket.send(pkg);
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
      
      private function __timerComplete(e:TimerEvent = null) : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         timer.stop();
         timer.removeEventListener("timer",__startCount);
         timer.removeEventListener("timerComplete",__timerComplete);
         if(alert)
         {
            alert.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _bg = null;
         _txtProp = null;
         _resurrectBtn = null;
         _reFightBtn = null;
         _timeCD = null;
      }
   }
}
