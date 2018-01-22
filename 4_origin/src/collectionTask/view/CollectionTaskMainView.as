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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         if(CollectionTaskManager.Instance.collectionTaskInfoList == null)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createCollectionRebortDataLoader()],enter,[param1,param2]);
            return;
         }
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInCollectionTask");
         super.enter(param1,param2);
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
      
      protected function __refreshProgress(param1:Event) : void
      {
         _mapView.refreshProgress();
      }
      
      protected function __pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         switch(int(_loc2_) - 1)
         {
            case 0:
               addOnePlayer(_loc3_);
               break;
            case 1:
               movePlayer(_loc3_);
               break;
            case 2:
               break;
            case 3:
               removePlayer(_loc3_);
               break;
            case 4:
               initPlayers(_loc3_);
         }
      }
      
      public function initPlayers(param1:PackageIn) : void
      {
         var _loc3_:int = param1.readInt();
         var _loc2_:int = _loc3_ > 20?20:_loc3_;
         addPlayer(param1,_loc2_);
         if(_mapView == null)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new CollectionTaskModel();
            }
            _mapView = new CollectionTaskRoomView(_sceneModel);
            addChild(_mapView);
         }
         _mapView.addRobertPlayer(_loc3_ + 1);
      }
      
      public function addOnePlayer(param1:PackageIn) : void
      {
         if(_mapView.getAllPlayersLength() > 20)
         {
            return;
         }
         addPlayer(param1,1);
      }
      
      private function addPlayer(param1:PackageIn, param2:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _loc7_ = 0;
         while(_loc7_ < param2)
         {
            _loc6_ = new PlayerInfo();
            _loc6_.beginChanges();
            _loc6_.ID = param1.readInt();
            _loc6_.NickName = param1.readUTF();
            _loc6_.isOld = param1.readBoolean();
            _loc6_.typeVIP = param1.readByte();
            _loc6_.VIPLevel = param1.readInt();
            _loc6_.Sex = param1.readBoolean();
            _loc6_.Style = param1.readUTF();
            _loc6_.Colors = param1.readUTF();
            _loc6_.Skin = param1.readUTF();
            _loc6_.commitChanges();
            _loc5_ = param1.readInt();
            _loc3_ = param1.readInt();
            _loc4_ = new PlayerVO();
            _loc4_.playerInfo = _loc6_;
            _loc4_.playerPos = new Point(_loc5_,_loc3_);
            if(_loc6_.ID != PlayerManager.Instance.Self.ID)
            {
               _sceneModel.addPlayer(_loc4_);
            }
            _loc7_++;
         }
      }
      
      public function movePlayer(param1:PackageIn) : void
      {
         var _loc9_:* = 0;
         var _loc6_:* = null;
         var _loc2_:int = param1.readInt();
         var _loc5_:int = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc8_:String = param1.readUTF();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var _loc4_:Array = _loc8_.split(",");
         var _loc7_:Array = [];
         _loc9_ = uint(0);
         while(_loc9_ < _loc4_.length)
         {
            _loc6_ = new Point(_loc4_[_loc9_],_loc4_[_loc9_ + 1]);
            _loc7_.push(_loc6_);
            _loc9_ = uint(_loc9_ + 2);
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
         _mapView.movePlayer(_loc2_,_loc7_);
      }
      
      public function removePlayer(param1:PackageIn) : void
      {
         var _loc2_:int = param1.readInt();
         _sceneModel.removePlayer(_loc2_);
         if(_loc2_ == PlayerManager.Instance.Self.ID)
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
      
      override public function leaving(param1:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInCollectionTask");
         CacheSysManager.getInstance().release("alertInCollectionTask");
         removeEvent();
         super.leaving(param1);
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
      }
   }
}
