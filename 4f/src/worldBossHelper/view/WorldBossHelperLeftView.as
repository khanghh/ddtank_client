package worldBossHelper.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerConfigInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import worldBossHelper.WorldBossHelperController;
   import worldBossHelper.WorldBossHelperManager;
   import worldBossHelper.event.WorldBossHelperEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossHelperLeftView extends Sprite implements Disposeable
   {
       
      
      private var _infoBg:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _receieveData:Boolean;
      
      private var _state:Boolean;
      
      private var _openStateTxt:FilterFrameText;
      
      private var _closeStateTxt:FilterFrameText;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _date1:Date;
      
      private var _date2:Date;
      
      private var _timer:Timer;
      
      private var _remainTime:int;
      
      private var _count:int;
      
      private var _countArr:Array;
      
      private var _titleTxtArr:Array;
      
      private var _allHonorTxt:FilterFrameText;
      
      private var _allMoneyTxt:FilterFrameText;
      
      private var _allMedalTxt:FilterFrameText;
      
      private var _startTimer:Timer;
      
      public function WorldBossHelperLeftView(){super();}
      
      private function initEvent() : void{}
      
      protected function __btnHandler(param1:MouseEvent) : void{}
      
      public function dispatchHelperEvent() : void{}
      
      protected function __alertOpenHelper(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function fightFailDescription() : void{}
      
      private function stopAndDisposeTimer() : void{}
      
      public function get state() : Boolean{return false;}
      
      public function set state(param1:Boolean) : void{}
      
      private function initView() : void{}
      
      public function changeState() : void{}
      
      private function checkTrueStart() : Boolean{return false;}
      
      private function startTimerHandler(param1:TimerEvent) : void{}
      
      private function disposeStartTimer() : void{}
      
      public function startFight() : void{}
      
      protected function __timerHandler(param1:TimerEvent) : void{}
      
      public function addDescription(param1:Boolean, param2:int, param3:Array, param4:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
