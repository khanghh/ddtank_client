package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaTaskView extends Sprite implements Disposeable
   {
      
      public static var RESET_MONEY:int = 500;
      
      public static var SUBMIT_RICHES:int = 5000;
       
      
      private var _myView:ConsortiaMyTaskView;
      
      private var _timeBG:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var _lastTimeTxt:FilterFrameText;
      
      private var _noTask:FilterFrameText;
      
      private var _timer:TimerJuggler;
      
      private var diff:Number;
      
      public function ConsortiaTaskView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function __resetClick(param1:MouseEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void{}
      
      private function removeEvents() : void{}
      
      private function __updateEndTimeInfo(param1:ConsortiaTaskEvent) : void{}
      
      private function __getTaskInfo(param1:ConsortiaTaskEvent) : void{}
      
      private function __showTask() : void{}
      
      private function __noTask() : void{}
      
      private function __startTimer() : void{}
      
      private function __timerOne(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
