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
      
      public function show(param1:FightPlayerVo) : void
      {
         if(param1 == null || !param1.reviveTime)
         {
            dispose();
            return;
         }
         _fightPlayerVo = param1;
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__onTimer);
         _timer.start();
         LayerManager.Instance.addToLayer(this,1,true,2);
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc3_:Number = _fightPlayerVo.reviveTime.getTime();
         var _loc2_:Number = TimeManager.Instance.NowTime();
         if(_loc2_ >= _loc3_)
         {
            revive(false);
         }
         else
         {
            updateTime(_loc3_ - _loc2_);
         }
      }
      
      private function revive(param1:Boolean) : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",__onTimer);
         SocketManager.Instance.out.sendConsortiaGuradPlayerRevive(param1);
         dispose();
      }
      
      private function updateTime(param1:Number) : void
      {
         var _loc3_:Date = new Date(param1);
         var _loc2_:String = setFormat(0) + ":" + setFormat(_loc3_.minutes) + ":" + setFormat(_loc3_.seconds);
         (_timeCD["timeHour2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(0));
         (_timeCD["timeHour"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(1));
         (_timeCD["timeMint2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(3));
         (_timeCD["timeMint"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(4));
         (_timeCD["timeSecond2"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(6));
         (_timeCD["timeSecond"] as MovieClip).gotoAndStop("num_" + _loc2_.charAt(7));
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
      
      private function __onReviveClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = ServerConfigManager.instance.consortiaGuardReviveRiches;
         if(PlayerManager.Instance.Self.Riches < _loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.notRiches"));
            return;
         }
         if(!ConsortiaGuardControl.Instance.notAlertAgain)
         {
            _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.consortiaGurad.richesTips",_loc2_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            _alertFrame.addEventListener("response",__onAlertFrame);
            _alertFrame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
            _alertFrame.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
         }
         else
         {
            revive(true);
         }
      }
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         ConsortiaGuardControl.Instance.notAlertAgain = _loc2_.selected;
      }
      
      private function __onAlertFrame(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
