package consortion.view.guard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.MovieClipWrapper;
   
   public class ConsortiaGuardView extends Sprite implements Disposeable
   {
       
      
      private var _movie:MovieClipWrapper;
      
      private var _clickBuyBuff:SimpleBitmapButton;
      
      private var _bossRank:ConsortiaGuardSubBossRank;
      
      private var _barUIList:Vector.<ConsortiaGuardBossBar>;
      
      private var _currentType:int;
      
      public function ConsortiaGuardView(){super();}
      
      private function init() : void{}
      
      protected function __onHideBossRank(param1:Event) : void{}
      
      private function __onShowBossRank(param1:ConsortiaGuardEvent) : void{}
      
      protected function removeBossRank(param1:MouseEvent) : void{}
      
      private function hideBossRank() : void{}
      
      private function __onClickBuyBuff(param1:MouseEvent) : void{}
      
      private function __onAlertFrame(param1:FrameEvent) : void{}
      
      private function __onUpdateGameState(param1:ConsortiaGuardEvent) : void{}
      
      private function updateGame() : void{}
      
      public function dispose() : void{}
   }
}
