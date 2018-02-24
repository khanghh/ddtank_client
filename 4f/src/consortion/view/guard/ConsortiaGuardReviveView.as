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
      
      public function ConsortiaGuardReviveView(){super();}
      
      private function initView() : void{}
      
      public function show(param1:FightPlayerVo) : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      private function revive(param1:Boolean) : void{}
      
      private function updateTime(param1:Number) : void{}
      
      private function setFormat(param1:int) : String{return null;}
      
      private function __onReviveClick(param1:MouseEvent) : void{}
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void{}
      
      private function __onAlertFrame(param1:FrameEvent) : void{}
      
      private function disposeFrame() : void{}
      
      public function dispose() : void{}
   }
}
