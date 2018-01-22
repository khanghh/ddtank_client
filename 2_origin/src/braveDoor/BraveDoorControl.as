package braveDoor
{
   import BraveDoor.BraveDoorManager;
   import BraveDoor.event.BraveDoorEvent;
   import academy.AcademyManager;
   import braveDoor.data.BraveDoorListModel;
   import braveDoor.view.BraveDoorFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.StatisticManager;
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   import road7th.comm.PackageIn;
   import room.model.RoomInfo;
   import roomList.LookupRoomFrame;
   
   public class BraveDoorControl extends EventDispatcher
   {
      
      public static const ROOM:int = 1;
      
      public static const TEM:int = 2;
      
      private static var _instance:BraveDoorControl;
       
      
      private var _frame:BraveDoorFrame = null;
      
      private var _model:BraveDoorListModel;
      
      private var _findRoom:LookupRoomFrame;
      
      private var _currentRoomType:int = 1;
      
      private var _enterRoomType:int = 0;
      
      private var _isLockSwitchView:Boolean = false;
      
      public function BraveDoorControl()
      {
         super();
      }
      
      public static function get instance() : BraveDoorControl
      {
         if(!_instance)
         {
            _instance = new BraveDoorControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         BraveDoorManager.instance.addEventListener("openBraveDoorView",openView_Handler);
      }
      
      public function openView_Handler(param1:CEvent) : void
      {
         enter();
      }
      
      public function enter() : void
      {
         if(!StartupResourceLoader.firstEnterHall)
         {
            SoundManager.instance.playMusic("062");
         }
         init();
      }
      
      private function init() : void
      {
         _model = new BraveDoorListModel();
         StateManager.createStateAsync("braveDoorRoom",initBraveDoorView);
      }
      
      private function initBraveDoorView(param1:CEvent) : void
      {
         if(_frame != null)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         _frame = ComponentFactory.Instance.creat("ddt.braveDoor.braveDoorFrame",[this,_model]);
         if(_frame)
         {
            LayerManager.Instance.addToLayer(_frame,3,true,1);
            initEvents();
            StateManager.currentStateType = "braveDoorRoom";
         }
         SocketManager.Instance.out.sendCurrentState(1);
         StatisticManager.loginRoomListNum++;
         SocketManager.Instance.out.sendUpdateRoomList(7,3);
         CacheSysManager.unlock("alertInFight");
         CacheSysManager.getInstance().release("alertInFight",1200);
         AcademyManager.Instance.showAlert();
         PlayerManager.Instance.Self.isUpGradeInGame = false;
         PlayerManager.Instance.Self.sendOverTimeListByBody();
         if(_isLockSwitchView)
         {
            switchView(_enterRoomType);
            unLockSwitchView();
         }
      }
      
      private function __updateRoom(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Array = [];
         var _loc4_:PackageIn = param1.pkg;
         _model.roomTotal = _loc4_.readInt();
         var _loc5_:int = _loc4_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc4_.readInt();
            _loc6_ = _model.getRoomById(_loc2_);
            if(_loc6_ == null)
            {
               _loc6_ = new RoomInfo();
            }
            _loc6_.ID = _loc2_;
            _loc6_.type = _loc4_.readByte();
            _loc6_.timeType = _loc4_.readByte();
            _loc6_.totalPlayer = _loc4_.readByte();
            _loc6_.viewerCnt = _loc4_.readByte();
            _loc6_.maxViewerCnt = _loc4_.readByte();
            _loc6_.placeCount = _loc4_.readByte();
            _loc6_.IsLocked = _loc4_.readBoolean();
            _loc6_.mapId = _loc4_.readInt();
            _loc6_.isPlaying = _loc4_.readBoolean();
            _loc6_.Name = _loc4_.readUTF();
            _loc6_.gameMode = _loc4_.readByte();
            _loc6_.hardLevel = _loc4_.readByte();
            _loc6_.levelLimits = _loc4_.readInt();
            _loc6_.isOpenBoss = _loc4_.readBoolean();
            if(_loc6_.type != 10)
            {
               _loc3_.push(_loc6_);
            }
            _loc7_++;
         }
         updateRoomInfo(_loc3_);
      }
      
      private function updateRoomInfo(param1:Array) : void
      {
         _model.updateRoom(param1);
      }
      
      public function updateRoomMap(param1:int) : void
      {
         $duplicateId = param1;
         this.dispatchEvent(new BraveDoorEvent("updateSelectDuplicate",$duplicateId));
      }
      
      private function sendSetRoom(param1:int) : void
      {
         GameInSocketOut.sendGameRoomSetUp(param1,49,false,"","",1,0,0,false,0);
      }
      
      protected function initEvents() : void
      {
         if(_frame)
         {
            _frame.addEventListener("response",__responseHandler);
         }
         SocketManager.Instance.addEventListener("gameRoomListUpdate",__updateRoom);
         addEventListener("selectedDuplicate",setRoomMap);
      }
      
      private function setRoomMap(param1:BraveDoorEvent) : void
      {
         updateRoomMap(int(param1.data));
      }
      
      protected function removeEvents() : void
      {
         if(_frame)
         {
            _frame.removeEventListener("response",__responseHandler);
         }
         SocketManager.Instance.removeEventListener("gameRoomListUpdate",__updateRoom);
         removeEventListener("selectedDuplicate",setRoomMap);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 && currentRoomType == 1)
         {
            SoundManager.instance.playButtonSound();
            if(_frame)
            {
               ObjectUtils.disposeObject(_frame);
               _frame = null;
               hide();
            }
         }
      }
      
      public function lockSwitchView(param1:int) : void
      {
         _isLockSwitchView = true;
         _enterRoomType = param1;
      }
      
      public function unLockSwitchView() : void
      {
         _isLockSwitchView = false;
         _enterRoomType = 0;
      }
      
      public function switchView(param1:int) : void
      {
         _currentRoomType = param1;
         if(_frame)
         {
            _frame.closeButton.enable = _currentRoomType == 1;
         }
         this.dispatchEvent(new BraveDoorEvent("switchRoomView",_currentRoomType));
      }
      
      public function hide() : void
      {
         StateManager.currentStateType = "main";
         dispose();
         PlayerManager.Instance.Self.sendOverTimeListByBody();
      }
      
      public function get currentRoomType() : int
      {
         return _currentRoomType;
      }
      
      public function dispose() : void
      {
         removeEvents();
         BraveDoorManager.instance.moduleIsShow = false;
         _model = null;
      }
   }
}
