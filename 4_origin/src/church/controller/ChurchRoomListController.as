package church.controller
{
   import church.ChurchManager;
   import church.model.ChurchRoomListModel;
   import church.view.ChurchMainView;
   import ddt.data.ChurchRoomInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class ChurchRoomListController extends BaseStateView
   {
      
      public static const UNMARRY:String = "unmarry";
       
      
      private var _model:ChurchRoomListModel;
      
      private var _view:ChurchMainView;
      
      private var _mapSrcLoaded:Boolean = false;
      
      private var _mapServerReady:Boolean = false;
      
      public function ChurchRoomListController()
      {
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         init();
         addEvent();
         MainToolBar.Instance.show();
         SoundManager.instance.playMusic("062");
      }
      
      private function init() : void
      {
         _model = new ChurchRoomListModel();
         _view = new ChurchMainView(this,_model);
         _view.show();
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(241),__addRoom);
         SocketManager.Instance.addEventListener(PkgEvent.format(254),__removeRoom);
         SocketManager.Instance.addEventListener(PkgEvent.format(255),__updateRoom);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(241),__addRoom);
         SocketManager.Instance.removeEventListener(PkgEvent.format(254),__removeRoom);
         SocketManager.Instance.removeEventListener(PkgEvent.format(255),__updateRoom);
      }
      
      private function __addRoom(event:PkgEvent) : void
      {
         var self:* = null;
         var pkg:PackageIn = event.pkg;
         var result:Boolean = pkg.readBoolean();
         if(!result)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.weddingRoom.WeddingRoomControler.addRoom"));
            return;
         }
         var roomInfo:ChurchRoomInfo = new ChurchRoomInfo();
         roomInfo.id = pkg.readInt();
         roomInfo.isStarted = pkg.readBoolean();
         roomInfo.roomName = pkg.readUTF();
         roomInfo.isLocked = pkg.readBoolean();
         roomInfo.mapID = pkg.readInt();
         roomInfo.valideTimes = pkg.readInt();
         roomInfo.currentNum = pkg.readInt();
         roomInfo.createID = pkg.readInt();
         roomInfo.createName = pkg.readUTF();
         roomInfo.groomID = pkg.readInt();
         roomInfo.groomName = pkg.readUTF();
         roomInfo.brideID = pkg.readInt();
         roomInfo.brideName = pkg.readUTF();
         roomInfo.creactTime = pkg.readDate();
         var statu:int = pkg.readByte();
         if(statu == 1)
         {
            roomInfo.status = "wedding_none";
         }
         else
         {
            roomInfo.status = "wedding_ing";
         }
         if(PathManager.solveExternalInterfaceEnabel())
         {
            self = PlayerManager.Instance.Self;
            ExternalInterfaceManager.sendToAgent(8,self.ID,self.NickName,ServerManager.Instance.zoneName,-1,"",self.SpouseName);
         }
         roomInfo.discription = pkg.readUTF();
         roomInfo.seniorType = pkg.readInt();
         _model.addRoom(roomInfo);
      }
      
      private function __removeRoom(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         pkg.position = 20;
         var id:int = pkg.readInt();
         _model.removeRoom(id);
      }
      
      private function __updateRoom(event:PkgEvent) : void
      {
         var roomInfo:* = null;
         var statu:int = 0;
         var pkg:PackageIn = event.pkg;
         var result:Boolean = pkg.readBoolean();
         if(result)
         {
            roomInfo = new ChurchRoomInfo();
            roomInfo.id = pkg.readInt();
            roomInfo.isStarted = pkg.readBoolean();
            roomInfo.roomName = pkg.readUTF();
            roomInfo.isLocked = pkg.readBoolean();
            roomInfo.mapID = pkg.readInt();
            roomInfo.valideTimes = pkg.readInt();
            roomInfo.currentNum = pkg.readInt();
            roomInfo.createID = pkg.readInt();
            roomInfo.createName = pkg.readUTF();
            roomInfo.groomID = pkg.readInt();
            roomInfo.groomName = pkg.readUTF();
            roomInfo.brideID = pkg.readInt();
            roomInfo.brideName = pkg.readUTF();
            roomInfo.creactTime = pkg.readDate();
            statu = pkg.readByte();
            if(statu == 1)
            {
               roomInfo.status = "wedding_none";
            }
            else
            {
               roomInfo.status = "wedding_ing";
            }
            roomInfo.discription = pkg.readUTF();
            roomInfo.seniorType = pkg.readInt();
            _model.updateRoom(roomInfo);
         }
      }
      
      public function createRoom(roomInfo:ChurchRoomInfo) : void
      {
         var type:int = 0;
         if(ChurchManager.instance.selfRoom)
         {
            type = 0;
            if(roomInfo.seniorType == 0)
            {
               type = 1;
            }
            else if(roomInfo.seniorType == 4)
            {
               type = 3;
            }
            else
            {
               type = 2;
            }
            SocketManager.Instance.out.sendEnterRoom(0,"",type);
         }
         else
         {
            SocketManager.Instance.out.sendCreateRoom(roomInfo.roomName,!!roomInfo.password?roomInfo.password:"",roomInfo.mapID,2,roomInfo.canInvite,roomInfo.discription,roomInfo.seniorType);
         }
      }
      
      public function unmarry(isPlayMovie:Boolean = false) : void
      {
         if(ChurchManager.instance.selfRoom)
         {
            if(ChurchManager.instance.selfRoom.status == "wedding_ing")
            {
               SocketManager.Instance.out.sendUnmarry(true);
               SocketManager.Instance.out.sendUnmarry(isPlayMovie);
               if(_model && ChurchManager.instance.selfRoom)
               {
                  _model.removeRoom(ChurchManager.instance.selfRoom.id);
               }
               dispatchEvent(new Event("unmarry"));
               return;
            }
         }
         SocketManager.Instance.out.sendUnmarry(isPlayMovie);
         if(_model && ChurchManager.instance.selfRoom)
         {
            _model.removeRoom(ChurchManager.instance.selfRoom.id);
         }
         dispatchEvent(new Event("unmarry"));
      }
      
      public function changeViewState(state:String) : void
      {
         _view.changeState(state);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
         SocketManager.Instance.out.sendExitMarryRoom();
         MainToolBar.Instance.backFunction = null;
         MainToolBar.Instance.hide();
         dispose();
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "ddtchurchroomlist";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_model)
         {
            _model.dispose();
         }
         _model = null;
         if(_view)
         {
            if(_view.parent)
            {
               _view.parent.removeChild(_view);
            }
            _view.dispose();
         }
         _view = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
