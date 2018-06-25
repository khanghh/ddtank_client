package collectionTask.view
{
   import collectionTask.CollectionTaskManager;
   import collectionTask.model.CollectionTaskModel;
   import collectionTask.vo.PlayerVO;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.geom.Point;
   import invite.InviteManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   
   public class CollectionTaskMainView extends BaseStateView
   {
       
      
      private var _mapView:CollectionTaskRoomView;
      
      private var _sceneModel:CollectionTaskModel;
      
      public function CollectionTaskMainView()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         if(CollectionTaskManager.Instance.collectionTaskInfoList == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createCollectionRebortDataLoader()],enter,[prev,data]);
            return;
         }
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInCollectionTask");
         super.enter(prev,data);
         SoundManager.instance.playMusic("12025");
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         SocketManager.Instance.out.sendCurrentState(0);
         MainToolBar.Instance.hide();
         initView();
         addEvent();
         SocketManager.Instance.out.sendCollectionSceneEnter();
      }
      
      private function initView() : void
      {
         _sceneModel = new CollectionTaskModel();
         _mapView = new CollectionTaskRoomView(_sceneModel);
         addChild(_mapView);
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(261),__pkgHandler);
         TaskManager.instance.addEventListener("refreshProgress",__refreshProgress);
      }
      
      protected function __refreshProgress(event:Event) : void
      {
         _mapView.refreshProgress();
      }
      
      protected function __pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         switch(int(cmd) - 1)
         {
            case 0:
               addOnePlayer(pkg);
               break;
            case 1:
               movePlayer(pkg);
               break;
            case 2:
               break;
            case 3:
               removePlayer(pkg);
               break;
            case 4:
               initPlayers(pkg);
         }
      }
      
      public function initPlayers(pkg:PackageIn) : void
      {
         var len:int = pkg.readInt();
         var count:int = len > 20?20:len;
         addPlayer(pkg,count);
         if(_mapView == null)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new CollectionTaskModel();
            }
            _mapView = new CollectionTaskRoomView(_sceneModel);
            addChild(_mapView);
         }
         _mapView.addRobertPlayer(len + 1);
      }
      
      public function addOnePlayer(pkg:PackageIn) : void
      {
         if(_mapView.getAllPlayersLength() > 20)
         {
            return;
         }
         addPlayer(pkg,1);
      }
      
      private function addPlayer(pkg:PackageIn, len:int) : void
      {
         var i:int = 0;
         var playerInfo:* = null;
         var posx:int = 0;
         var posy:int = 0;
         var playerVO:* = null;
         for(i = 0; i < len; )
         {
            playerInfo = new PlayerInfo();
            playerInfo.beginChanges();
            playerInfo.ID = pkg.readInt();
            playerInfo.NickName = pkg.readUTF();
            playerInfo.isOld = pkg.readBoolean();
            playerInfo.typeVIP = pkg.readByte();
            playerInfo.VIPLevel = pkg.readInt();
            playerInfo.Sex = pkg.readBoolean();
            playerInfo.Style = pkg.readUTF();
            playerInfo.Colors = pkg.readUTF();
            playerInfo.Skin = pkg.readUTF();
            playerInfo.commitChanges();
            posx = pkg.readInt();
            posy = pkg.readInt();
            playerVO = new PlayerVO();
            playerVO.playerInfo = playerInfo;
            playerVO.playerPos = new Point(posx,posy);
            if(playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               _sceneModel.addPlayer(playerVO);
            }
            i++;
         }
      }
      
      public function movePlayer(pkg:PackageIn) : void
      {
         var i:* = 0;
         var p:* = null;
         var id:int = pkg.readInt();
         var posX:int = pkg.readInt();
         var posY:int = pkg.readInt();
         var pathStr:String = pkg.readUTF();
         if(id == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var arr:Array = pathStr.split(",");
         var path:Array = [];
         for(i = uint(0); i < arr.length; )
         {
            p = new Point(arr[i],arr[i + 1]);
            path.push(p);
            i = uint(i + 2);
         }
         if(_mapView == null)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new CollectionTaskModel();
            }
            _mapView = new CollectionTaskRoomView(_sceneModel);
            addChild(_mapView);
         }
         _mapView.movePlayer(id,path);
      }
      
      public function removePlayer(pkg:PackageIn) : void
      {
         var id:int = pkg.readInt();
         _sceneModel.removePlayer(id);
         if(id == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("main");
         }
      }
      
      private function removeEvent() : void
      {
         TaskManager.instance.removeEventListener("refreshProgress",__refreshProgress);
      }
      
      override public function getType() : String
      {
         return "collectionTaskScene";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInCollectionTask");
         CacheSysManager.getInstance().release("alertInCollectionTask");
         removeEvent();
         super.leaving(next);
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
      }
   }
}
