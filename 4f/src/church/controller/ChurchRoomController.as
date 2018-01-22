package church.controller
{
   import baglocked.BaglockedManager;
   import church.ChurchManager;
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import church.view.weddingRoom.WeddingRoomSwitchMovie;
   import church.view.weddingRoom.WeddingRoomView;
   import church.vo.PlayerVO;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import ddt.view.chat.ChatData;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChurchRoomController extends BaseStateView
   {
      
      private static const RESTART_WEDDING_FEE:int = 300;
      
      private static const RESTART_COSTLYWEDDING_FEE:int = 8000;
       
      
      private var _sceneModel:ChurchRoomModel;
      
      private var _view:WeddingRoomView;
      
      private var timer:TimerJuggler;
      
      private var _baseAlerFrame:BaseAlerFrame;
      
      public function ChurchRoomController(){super();}
      
      override public function prepare() : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function init() : void{}
      
      public function resetTimer() : void{}
      
      private function __timerComplete(param1:Event) : void{}
      
      private function stopTimer() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __continuation(param1:PkgEvent) : void{}
      
      private function __updateValidTime(param1:WeddingRoomEvent) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      public function __addPlayer(param1:PkgEvent) : void{}
      
      public function __removePlayer(param1:PkgEvent) : void{}
      
      public function __movePlayer(param1:PkgEvent) : void{}
      
      private function __updateWeddingStatus(param1:WeddingRoomEvent) : void{}
      
      public function playWeddingMovie() : void{}
      
      public function startWedding() : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      private function __startWedding(param1:PkgEvent) : void{}
      
      private function __stopWedding(param1:PkgEvent) : void{}
      
      public function modifyDiscription(param1:String, param2:Boolean, param3:String, param4:String) : void{}
      
      public function useFire(param1:int, param2:int) : void{}
      
      private function __onUseFire(param1:PkgEvent) : void{}
      
      private function __onUseSalute(param1:PkgEvent) : void{}
      
      public function setSaulte(param1:int) : void{}
      
      private function __sceneChange(param1:WeddingRoomEvent) : void{}
      
      public function readyEnterScene() : void{}
      
      private function __readyEnterOk(param1:Event) : void{}
      
      public function enterScene() : void{}
      
      public function giftSubmit(param1:uint) : void{}
      
      public function roomContinuation(param1:int) : void{}
      
      private function getWeddingMoney() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
