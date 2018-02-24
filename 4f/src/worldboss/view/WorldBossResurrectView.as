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
      
      public function WorldBossResurrectView(param1:int){super();}
      
      private function init() : void{}
      
      private function addEvent() : void{}
      
      private function __resurrect(param1:MouseEvent) : void{}
      
      private function __reFight(param1:MouseEvent) : void{}
      
      public function __startCount(param1:TimerEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function __onAlertResponse2(param1:FrameEvent) : void{}
      
      private function seveIsResurrect(param1:Boolean) : void{}
      
      private function seveIsReFight(param1:Boolean) : void{}
      
      private function promptlyRevive() : void{}
      
      protected function onCheckCancel() : void{}
      
      protected function onCheckComplete() : void{}
      
      private function promptlyFight() : void{}
      
      protected function onCheckCancel2() : void{}
      
      protected function onCheckComplete2() : void{}
      
      private function requestRevive(param1:int, param2:Boolean) : void{}
      
      private function setFormat(param1:int) : String{return null;}
      
      private function __timerComplete(param1:TimerEvent = null) : void{}
      
      public function dispose() : void{}
   }
}
