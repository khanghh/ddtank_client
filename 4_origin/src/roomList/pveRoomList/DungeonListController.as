package roomList.pveRoomList
{
   import academy.AcademyManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.map.DungeonInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.StatisticManager;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomInfo;
   import roomList.LookupRoomFrame;
   import roomList.RoomListEnumerate;
   import trainer.view.NewHandContainer;
   
   public class DungeonListController
   {
      
      private static var _instance:DungeonListController;
       
      
      private var _model:DungeonListModel;
      
      private var _view:DungeonListView;
      
      private var _findRoom:LookupRoomFrame;
      
      private var _defaluDungeonMapId_3:int;
      
      private var _defaluDungeonMapId_4:int;
      
      private var _buffList:DictionaryData;
      
      private var _timer:Timer;
      
      public function DungeonListController()
      {
         super();
      }
      
      public static function disorder(arr:Array) : Array
      {
         var i:int = 0;
         var random:int = 0;
         var temInfo:* = null;
         var j:int = 0;
         for(i = 0; i < arr.length; )
         {
            random = Math.random() * 10000 % arr.length;
            temInfo = arr[i];
            arr[i] = arr[random];
            arr[random] = temInfo;
            i++;
         }
         var newArray:Array = [];
         for(j = 0; j < arr.length; )
         {
            if(!(arr[j] as RoomInfo).isPlaying)
            {
               newArray.push(arr[j]);
            }
            else
            {
               newArray.unshift(arr[j]);
            }
            j++;
         }
         return newArray;
      }
      
      public static function get instance() : DungeonListController
      {
         if(!_instance)
         {
            _instance = new DungeonListController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DungeonListManager.instance.addEventListener("openview",__openViewHandler);
      }
      
      private function __openViewHandler(event:CEvent) : void
      {
         upMapId();
         enter();
      }
      
      private function init() : void
      {
         _model = new DungeonListModel();
         StateManager.createStateAsync("dungeon",initDungeonListView);
      }
      
      private function initDungeonListView(type:String = null) : void
      {
         initEvent();
         _view = ComponentFactory.Instance.creatComponentByStylename("roomList.DungeonListView");
         _view.initView(this,_model);
         LayerManager.Instance.addToLayer(_view,3,true,2);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         StatisticManager.loginRoomListNum++;
         SocketManager.Instance.out.sendCurrentState(1);
         SocketManager.Instance.out.sendSceneLogin(2);
         MainToolBar.Instance.show();
         CacheSysManager.unlock("alertInFight");
         CacheSysManager.getInstance().release("alertInFight",1200);
         AcademyManager.Instance.showAlert();
         PlayerManager.Instance.Self.isUpGradeInGame = false;
         PlayerManager.Instance.Self.sendOverTimeListByBody();
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(120))
         {
            NewHandContainer.Instance.showArrow(130,0,"trainer.creatRoomArrowPos","asset.trainer.creatRoomTipAsset","trainer.creatRoomTipPos",LayerManager.Instance.getLayerByType(2));
         }
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         var i:int = 0;
         var len:int = _buffList.length;
         len = len > 50?50:len;
         var tmpArray:Array = _buffList.list.concat();
         for(i = 0; i < len; )
         {
            _model.addWaitingPlayer(tmpArray[i]);
            _buffList.remove(tmpArray[i].ID);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("gameRoomListUpdate",__addRoom);
         SocketManager.Instance.addEventListener(PkgEvent.format(18),__addWaitingPlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(21),__removeWaitingPlayer);
         PlayerTipManager.instance.addEventListener("challenge",__onChanllengeClick);
      }
      
      private function __addRoom(evt:CrazyTankSocketEvent) : void
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
         updataRoom(tempArray);
      }
      
      private function updataRoom(tempArray:Array) : void
      {
         if(tempArray.length == 0)
         {
            _model.updateRoom(tempArray);
            return;
         }
         if((tempArray[0] as RoomInfo).type > 2)
         {
            _model.updateRoom(tempArray);
         }
      }
      
      private function __addWaitingPlayer(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var player:PlayerInfo = PlayerManager.Instance.findPlayer(pkg.clientId);
         player.beginChanges();
         player.Grade = pkg.readInt();
         player.ddtKingGrade = pkg.readInt();
         player.Sex = pkg.readBoolean();
         player.NickName = pkg.readUTF();
         player.typeVIP = pkg.readByte();
         player.VIPLevel = pkg.readInt();
         player.ConsortiaName = pkg.readUTF();
         player.Offer = pkg.readInt();
         player.WinCount = pkg.readInt();
         player.TotalCount = pkg.readInt();
         player.EscapeCount = pkg.readInt();
         player.ConsortiaID = pkg.readInt();
         player.Repute = pkg.readInt();
         player.IsMarried = pkg.readBoolean();
         if(player.IsMarried)
         {
            player.SpouseID = pkg.readInt();
            player.SpouseName = pkg.readUTF();
         }
         player.LoginName = pkg.readUTF();
         player.FightPower = pkg.readInt();
         player.apprenticeshipState = pkg.readInt();
         player.isOld = pkg.readBoolean();
         player.commitChanges();
         _buffList.add(player.ID,player);
      }
      
      private function __removeWaitingPlayer(evt:PkgEvent) : void
      {
         var tmpId:int = evt.pkg.clientId;
         if(_buffList.hasKey(tmpId))
         {
            _buffList.remove(tmpId);
         }
         else
         {
            _model.removeWaitingPlayer(tmpId);
         }
      }
      
      public function setRoomShowMode(mode:int) : void
      {
         _model.roomShowMode = mode;
      }
      
      public function enter() : void
      {
         if(!StartupResourceLoader.firstEnterHall)
         {
            SoundManager.instance.playMusic("062");
         }
         _buffList = new DictionaryData();
         init();
      }
      
      public function hide() : void
      {
         StateManager.currentStateType = "main";
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         dispose();
         PlayerManager.Instance.Self.sendOverTimeListByBody();
      }
      
      public function getType() : String
      {
         return "dungeon";
      }
      
      public function sendGoIntoRoom(info:RoomInfo) : void
      {
      }
      
      public function showFindRoom() : void
      {
         if(_findRoom)
         {
            _findRoom.dispose();
         }
         _findRoom = null;
         _findRoom = ComponentFactory.Instance.creat("asset.ddtroomList.LookupRoomFrame");
         LayerManager.Instance.addToLayer(_findRoom,3);
      }
      
      protected function __onChanllengeClick(e:Event) : void
      {
         if(PlayerTipManager.instance.info.Grade < 12)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.cantBeChallenged",12));
            return;
         }
         if(PlayerTipManager.instance.info.playerState.StateID == 0 && e.target.info is FriendListPlayer)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.friendOffline"));
            return;
         }
         var i:int = Math.random() * RoomListEnumerate.PREWORD.length;
         GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[i],1,2,"");
         RoomManager.Instance.tempInventPlayerID = PlayerTipManager.instance.info.ID;
         PlayerTipManager.instance.removeEventListener("challenge",__onChanllengeClick);
      }
      
      private function upMapId() : void
      {
         var dungeon:DungeonInfo = MapManager.getListByType(3)[0] as DungeonInfo;
         if(dungeon)
         {
            _defaluDungeonMapId_3 = dungeon.ID;
         }
         var dungeon_4:DungeonInfo = MapManager.getListByType(4)[0] as DungeonInfo;
         if(dungeon_4)
         {
            _defaluDungeonMapId_4 = dungeon_4.ID;
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.reset();
            _timer.stop();
            _timer = null;
         }
         _buffList = null;
         PlayerTipManager.instance.removeEventListener("challenge",__onChanllengeClick);
         if(_findRoom)
         {
            _findRoom.dispose();
         }
         if(_model)
         {
            _model.dispose();
         }
         _findRoom = null;
         _model = null;
         SocketManager.Instance.removeEventListener("gameRoomListUpdate",__addRoom);
         SocketManager.Instance.removeEventListener(PkgEvent.format(18),__addWaitingPlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(21),__removeWaitingPlayer);
      }
      
      public function getBackType() : String
      {
         return "main";
      }
   }
}
