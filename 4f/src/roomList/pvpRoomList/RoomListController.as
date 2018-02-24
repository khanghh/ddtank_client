package roomList.pvpRoomList
{
   import academy.AcademyManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.StatisticManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import par.ParticleManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomInfo;
   import roomList.LookupRoomFrame;
   import roomList.RoomListEnumerate;
   import trainer.view.NewHandContainer;
   
   public class RoomListController
   {
      
      private static var isShowTutorial:Boolean = false;
      
      private static var _instance:RoomListController;
       
      
      private var _model:RoomListModel;
      
      private var _view:RoomListView;
      
      private var _createRoomView:RoomListCreateRoomView;
      
      private var _findRoom:LookupRoomFrame;
      
      private var _buffList:DictionaryData;
      
      private var _timer:Timer;
      
      public function RoomListController(){super();}
      
      public static function disorder(param1:Array) : Array{return null;}
      
      public static function get instance() : RoomListController{return null;}
      
      public function setup() : void{}
      
      private function __openViewHandler(param1:CEvent) : void{}
      
      private function init() : void{}
      
      private function initRoomListView(param1:String = null) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function initEvent() : void{}
      
      private function __addRoom(param1:CrazyTankSocketEvent) : void{}
      
      private function updataRoom(param1:Array) : void{}
      
      private function __addWaitingPlayer(param1:PkgEvent) : void{}
      
      private function __removeWaitingPlayer(param1:PkgEvent) : void{}
      
      public function setRoomShowMode(param1:int) : void{}
      
      public function enter() : void{}
      
      private function __modelCompleted(param1:Event) : void{}
      
      public function hide() : void{}
      
      public function getType() : String{return null;}
      
      public function sendGoIntoRoom(param1:RoomInfo) : void{}
      
      public function showFindRoom() : void{}
      
      protected function __containerClick(param1:MouseEvent) : void{}
      
      protected function __onChanllengeClick(param1:Event) : void{}
      
      public function dispose() : void{}
      
      public function getBackType() : String{return null;}
      
      public function showCreateView() : void{}
   }
}
