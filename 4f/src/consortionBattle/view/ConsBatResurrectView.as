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
      
      public function ConsBatResurrectView(param1:int){super();}
      
      private function init() : void{}
      
      private function __startCount(param1:Event) : void{}
      
      private function setFormat(param1:int) : String{return null;}
      
      protected function __timerComplete() : void{}
      
      private function addEvent() : void{}
      
      private function __stayRes(param1:MouseEvent) : void{}
      
      protected function promptlyStayRevive() : void{}
      
      protected function __StayResurrectConfirm(param1:FrameEvent) : void{}
      
      protected function __StayResurrectTwoConfirm(param1:FrameEvent) : void{}
      
      private function __resurrect(param1:MouseEvent) : void{}
      
      protected function promptlyRevive() : void{}
      
      protected function __resurrectConfirm(param1:FrameEvent) : void{}
      
      protected function __resurrectTwoConfirm(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
