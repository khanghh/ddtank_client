package collectionTask.view{   import collectionTask.CollectionTaskManager;   import collectionTask.model.CollectionTaskModel;   import collectionTask.vo.PlayerVO;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.utils.HelperDataModuleLoad;   import ddt.view.MainToolBar;   import flash.events.Event;   import flash.geom.Point;   import invite.InviteManager;   import quest.TaskManager;   import road7th.comm.PackageIn;      public class CollectionTaskMainView extends BaseStateView   {                   private var _mapView:CollectionTaskRoomView;            private var _sceneModel:CollectionTaskModel;            public function CollectionTaskMainView() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function initView() : void { }
            private function addEvent() : void { }
            protected function __refreshProgress(event:Event) : void { }
            protected function __pkgHandler(event:PkgEvent) : void { }
            public function initPlayers(pkg:PackageIn) : void { }
            public function addOnePlayer(pkg:PackageIn) : void { }
            private function addPlayer(pkg:PackageIn, len:int) : void { }
            public function movePlayer(pkg:PackageIn) : void { }
            public function removePlayer(pkg:PackageIn) : void { }
            private function removeEvent() : void { }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
   }}