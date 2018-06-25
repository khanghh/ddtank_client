package consortion.view.guard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import starling.display.player.FightPlayerVo;
   
   public class ConsortiaGuardReviveView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _promptlyRevive:SimpleBitmapButton;
      
      private var _timeCD:MovieClip;
      
      private var _totalCount:int;
      
      private var _timer:Timer;
      
      private var _fightPlayerVo:FightPlayerVo;
      
      private var _alertFrame:BaseAlerFrame;
      
      public function ConsortiaGuardReviveView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.reviveBg");
         addChild(_bg);
         _timeCD = ComponentFactory.Instance.creat("asset.consortiaGuard.reviveTimer");
         PositionUtils.setPos(_timeCD,"consortiaGuard.reviveTimerPos");
         addChild(_timeCD);
         _promptlyRevive = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.promptlyReviveBtn");
         _promptlyRevive.addEventListener("click",__onReviveClick);
         addChild(_promptlyRevive);
      }
      
      public function show(vo:FightPlayerVo) : void
      {
         if(vo == null || !vo.reviveTime)
         {
            dispose();
            return;
         }
         _fightPlayerVo = vo;
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__onTimer);
         _timer.start();
         LayerManager.Instance.addToLayer(this,1,true,2);
      }
      
      private function __onTimer(e:TimerEvent) : void
      {
         var reviveTime:Number = _fightPlayerVo.reviveTime.getTime();
         var time:Number = TimeManager.Instance.NowTime();
         if(time >= reviveTime)
         {
            revive(false);
         }
         else
         {
            updateTime(reviveTime - time);
         }
      }
      
      private function revive(value:Boolean) : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",__onTimer);
         SocketManager.Instance.out.sendConsortiaGuradPlayerRevive(value);
         dispose();
      }
      
      private function updateTime(surplus:Number) : void
      {
         var date:Date = new Date(surplus);
         var str:String = setFormat(0) + ":" + setFormat(date.minutes) + ":" + setFormat(date.seconds);
         (_timeCD["timeHour2"] as MovieClip).gotoAndStop("num_" + str.charAt(0));
         (_timeCD["timeHour"] as MovieClip).gotoAndStop("num_" + str.charAt(1));
         (_timeCD["timeMint2"] as MovieClip).gotoAndStop("num_" + str.charAt(3));
         (_timeCD["timeMint"] as MovieClip).gotoAndStop("num_" + str.charAt(4));
         (_timeCD["timeSecond2"] as MovieClip).gotoAndStop("num_" + str.charAt(6));
         (_timeCD["timeSecond"] as MovieClip).gotoAndStop("num_" + str.charAt(7));
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
      
      private function __onReviveClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var riches:int = ServerConfigManager.instance.consortiaGuardReviveRiches;
         if(PlayerManager.Instance.Self.Riches < riches)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.notRiches"));
            return;
         }
         if(!ConsortiaGuardControl.Instance.notAlertAgain)
         {
            _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.consortiaGurad.richesTips",riches),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            _alertFrame.addEventListener("response",__onAlertFrame);
            _alertFrame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
            _alertFrame.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
         }
         else
         {
            revive(true);
         }
      }
      
      protected function __onSelectCheckClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var btn:SelectedCheckButton = e.currentTarget as SelectedCheckButton;
         ConsortiaGuardControl.Instance.notAlertAgain = btn.selected;
      }
      
      private function __onAlertFrame(e:FrameEvent) : void
      {
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            _fightPlayerVo.state = 0;
            SocketManager.Instance.out.sendConsortiaGuradPlayerRevive(true);
            dispose();
         }
         disposeFrame();
      }
      
      private function disposeFrame() : void
      {
         if(_alertFrame)
         {
            _alertFrame.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
            _alertFrame.removeEventListener("response",__onAlertFrame);
            ObjectUtils.disposeObject(_alertFrame);
         }
         _alertFrame = null;
      }
      
      public function dispose() : void
      {
         disposeFrame();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _promptlyRevive.removeEventListener("click",__onReviveClick);
         if(_timer)
         {
            _timer.removeEventListener("timer",__onTimer);
         }
         _timer = null;
         ObjectUtils.disposeAllChildren(this);
         _timeCD = null;
         _bg = null;
         _promptlyRevive = null;
      }
   }
}
