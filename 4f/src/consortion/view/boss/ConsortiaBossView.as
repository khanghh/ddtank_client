package consortion.view.boss
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaBossDataVo;
   import consortion.data.ConsortiaBossModel;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaBossView extends Sprite implements Disposeable
   {
       
      
      private var _timeBg:Bitmap;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _extendBtn:SimpleBitmapButton;
      
      private var _bossStateBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _timer:TimerJuggler;
      
      private var _timerChairman:TimerJuggler;
      
      private var _bossState:int = -1;
      
      private var _callBossLevel:int = 0;
      
      private var _isClickEnter:Boolean = false;
      
      private var _frame:ConsortiaBossFrame;
      
      public function ConsortiaBossView(param1:ConsortiaBossFrame){super();}
      
      private function init() : void{}
      
      private function extendBossTime(param1:MouseEvent) : void{}
      
      private function __confirmExtendBossTime(param1:FrameEvent) : void{}
      
      private function callOrEnterBoss(param1:MouseEvent) : void{}
      
      private function __confirmCallBoss(param1:FrameEvent) : void{}
      
      private function initData() : void{}
      
      private function timerHandler(param1:Event) : void{}
      
      private function refreshData(param1:PkgEvent) : void{}
      
      private function refreshView(param1:ConsortiaBossModel) : void{}
      
      private function refreshEndTimeTxt(param1:ConsortiaBossModel) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      public function show() : void{}
      
      public function hied() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
