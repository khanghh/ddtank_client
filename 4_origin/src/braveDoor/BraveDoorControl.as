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
      
      public function openView_Handler(evt:CEvent) : void
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
      
      private function initBraveDoorView(event:CEvent) : void
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
      
      private function __updateRoom(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var info:* = null;
         var tempArray:Array = [];
         var pkg:PackageIn = evt.pkg;
         _model.roomTotal = pkg.readInt();
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            id = pkg.readInt();
            info = _model.getRoomById(id);
            if(info == null)
            {
               info = new RoomInfo();
            }
            info.ID = id;
            info.type = pkg.readByte();
            info.timeType = pkg.readByte();
            info.totalPlayer = pkg.readByte();
            info.viewerCnt = pkg.readByte();
            info.maxViewerCnt = pkg.readByte();
            info.placeCount = pkg.readByte();
            info.IsLocked = pkg.readBoolean();
            info.mapId = pkg.readInt();
            info.isPlaying = pkg.readBoolean();
            info.Name = pkg.readUTF();
            info.gameMode = pkg.readByte();
            info.hardLevel = pkg.readByte();
            info.levelLimits = pkg.readInt();
            info.isOpenBoss = pkg.readBoolean();
            if(info.type != 10)
            {
               tempArray.push(info);
            }
            i++;
         }
         updateRoomInfo(tempArray);
      }
      
      private function updateRoomInfo(tempArray:Array) : void
      {
         _model.updateRoom(tempArray);
      }
      
      public function updateRoomMap($duplicateId:int) : void
      {
         $duplicateId = $duplicateId;
         this.dispatchEvent(new BraveDoorEvent("updateSelectDuplicate",$duplicateId));
      }
      
      private function sendSetRoom(dupId:int) : void
      {
         GameInSocketOut.sendGameRoomSetUp(dupId,49,false,"","",1,0,0,false,0);
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
      
      private function setRoomMap(evt:BraveDoorEvent) : void
      {
         updateRoomMap(int(evt.data));
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1 && currentRoomType == 1)
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
      
      public function lockSwitchView(type:int) : void
      {
         _isLockSwitchView = true;
         _enterRoomType = type;
      }
      
      public function unLockSwitchView() : void
      {
         _isLockSwitchView = false;
         _enterRoomType = 0;
      }
      
      public function switchView(type:int) : void
      {
         _currentRoomType = type;
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
