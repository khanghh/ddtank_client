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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
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
      
      private function __addRoom(param1:PkgEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc4_.readBoolean();
         if(!_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.weddingRoom.WeddingRoomControler.addRoom"));
            return;
         }
         var _loc3_:ChurchRoomInfo = new ChurchRoomInfo();
         _loc3_.id = _loc4_.readInt();
         _loc3_.isStarted = _loc4_.readBoolean();
         _loc3_.roomName = _loc4_.readUTF();
         _loc3_.isLocked = _loc4_.readBoolean();
         _loc3_.mapID = _loc4_.readInt();
         _loc3_.valideTimes = _loc4_.readInt();
         _loc3_.currentNum = _loc4_.readInt();
         _loc3_.createID = _loc4_.readInt();
         _loc3_.createName = _loc4_.readUTF();
         _loc3_.groomID = _loc4_.readInt();
         _loc3_.groomName = _loc4_.readUTF();
         _loc3_.brideID = _loc4_.readInt();
         _loc3_.brideName = _loc4_.readUTF();
         _loc3_.creactTime = _loc4_.readDate();
         var _loc6_:int = _loc4_.readByte();
         if(_loc6_ == 1)
         {
            _loc3_.status = "wedding_none";
         }
         else
         {
            _loc3_.status = "wedding_ing";
         }
         if(PathManager.solveExternalInterfaceEnabel())
         {
            _loc5_ = PlayerManager.Instance.Self;
            ExternalInterfaceManager.sendToAgent(8,_loc5_.ID,_loc5_.NickName,ServerManager.Instance.zoneName,-1,"",_loc5_.SpouseName);
         }
         _loc3_.discription = _loc4_.readUTF();
         _loc3_.seniorType = _loc4_.readInt();
         _model.addRoom(_loc3_);
      }
      
      private function __removeRoom(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         _loc3_.position = 20;
         var _loc2_:int = _loc3_.readInt();
         _model.removeRoom(_loc2_);
      }
      
      private function __updateRoom(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc4_.readBoolean();
         if(_loc2_)
         {
            _loc3_ = new ChurchRoomInfo();
            _loc3_.id = _loc4_.readInt();
            _loc3_.isStarted = _loc4_.readBoolean();
            _loc3_.roomName = _loc4_.readUTF();
            _loc3_.isLocked = _loc4_.readBoolean();
            _loc3_.mapID = _loc4_.readInt();
            _loc3_.valideTimes = _loc4_.readInt();
            _loc3_.currentNum = _loc4_.readInt();
            _loc3_.createID = _loc4_.readInt();
            _loc3_.createName = _loc4_.readUTF();
            _loc3_.groomID = _loc4_.readInt();
            _loc3_.groomName = _loc4_.readUTF();
            _loc3_.brideID = _loc4_.readInt();
            _loc3_.brideName = _loc4_.readUTF();
            _loc3_.creactTime = _loc4_.readDate();
            _loc5_ = _loc4_.readByte();
            if(_loc5_ == 1)
            {
               _loc3_.status = "wedding_none";
            }
            else
            {
               _loc3_.status = "wedding_ing";
            }
            _loc3_.discription = _loc4_.readUTF();
            _loc3_.seniorType = _loc4_.readInt();
            _model.updateRoom(_loc3_);
         }
      }
      
      public function createRoom(param1:ChurchRoomInfo) : void
      {
         var _loc2_:int = 0;
         if(ChurchManager.instance.selfRoom)
         {
            _loc2_ = 0;
            if(param1.seniorType == 0)
            {
               _loc2_ = 1;
            }
            else if(param1.seniorType == 4)
            {
               _loc2_ = 3;
            }
            else
            {
               _loc2_ = 2;
            }
            SocketManager.Instance.out.sendEnterRoom(0,"",_loc2_);
         }
         else
         {
            SocketManager.Instance.out.sendCreateRoom(param1.roomName,!!param1.password?param1.password:"",param1.mapID,2,param1.canInvite,param1.discription,param1.seniorType);
         }
      }
      
      public function unmarry(param1:Boolean = false) : void
      {
         if(ChurchManager.instance.selfRoom)
         {
            if(ChurchManager.instance.selfRoom.status == "wedding_ing")
            {
               SocketManager.Instance.out.sendUnmarry(true);
               SocketManager.Instance.out.sendUnmarry(param1);
               if(_model && ChurchManager.instance.selfRoom)
               {
                  _model.removeRoom(ChurchManager.instance.selfRoom.id);
               }
               dispatchEvent(new Event("unmarry"));
               return;
            }
         }
         SocketManager.Instance.out.sendUnmarry(param1);
         if(_model && ChurchManager.instance.selfRoom)
         {
            _model.removeRoom(ChurchManager.instance.selfRoom.id);
         }
         dispatchEvent(new Event("unmarry"));
      }
      
      public function changeViewState(param1:String) : void
      {
         _view.changeState(param1);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
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
