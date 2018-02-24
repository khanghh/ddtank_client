package christmas.controller
{
   import christmas.ChristmasCoreManager;
   import christmas.info.MonsterInfo;
   import christmas.model.ChristmasRoomModel;
   import christmas.player.PlayerVO;
   import christmas.view.playingSnowman.ChristmasRoomView;
   import christmas.view.playingSnowman.WaitingChristmasView;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.geom.Point;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class ChristmasRoomController extends BaseStateView
   {
      
      private static var _instance:ChristmasRoomController;
      
      private static var _isFirstCome:Boolean = true;
       
      
      private var _sceneModel:ChristmasRoomModel;
      
      private var _view:ChristmasRoomView;
      
      private var _waitingView:WaitingChristmasView;
      
      protected var _monsters:DictionaryData;
      
      private var _monsterCount:int = 0;
      
      private var _callback:Function;
      
      private var _callbackArg:int;
      
      public function ChristmasRoomController(){super();}
      
      public static function get Instance() : ChristmasRoomController{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function init() : void{}
      
      protected function __onTimeOut(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      public function __updatePlayerStauts(param1:CrazyTankSocketEvent) : void{}
      
      private function __monstersEvent(param1:CrazyTankSocketEvent) : void{}
      
      private function __onLoadComplete(param1:Event) : void{}
      
      public function setSelfStatus(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      override public function getBackType() : String{return null;}
      
      public function __addPlayer(param1:CrazyTankSocketEvent) : void{}
      
      public function __removePlayer(param1:CrazyTankSocketEvent) : void{}
      
      public function __movePlayer(param1:CrazyTankSocketEvent) : void{}
      
      override public function getType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function dispose() : void{}
   }
}
