package collectionTask.view{   import church.vo.SceneMapVO;   import collectionTask.CollectionTaskManager;   import collectionTask.model.CollectionTaskModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestCondition;   import ddt.data.quest.QuestInfo;   import ddt.manager.ChatManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.view.scenePathSearcher.PathMapHitTester;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;      public class CollectionTaskRoomView extends Sprite implements Disposeable   {            public static const MAP_SIZE:Array = [1200,1077];                   private var _sceneScene:SceneScene;            private var _chatFrame:Sprite;            private var _sceneMap:CollectionTaskSceneMap;            private var _model:CollectionTaskModel;            private var _menuView:CollectionTaskMenuView;            private var _exitMenuView:CollectionTaskExitMenuView;            private var _taskProgressView:TaskProgressView;            private var _progress:ProgressSprite;            private var _taskCompleteMc:MovieClip;            private var _backBtnMc:MovieClip;            public function CollectionTaskRoomView(model:CollectionTaskModel) { super(); }
            private function initView() : void { }
            public function setMap(localPos:Point = null) : void { }
            public function refreshProgress() : void { }
            protected function __taskCompleteHandler(event:Event) : void { }
            public function addProgressMc() : void { }
            private function checkCanCollect() : Boolean { return false; }
            public function stopProgressMc() : void { }
            public function getSceneMapVO() : SceneMapVO { return null; }
            public function movePlayer(id:int, p:Array) : void { }
            public function getAllPlayersLength() : int { return 0; }
            public function addRobertPlayer(len:int) : void { }
            private function clearMap() : void { }
            public function getMapRes() : String { return null; }
            public function dispose() : void { }
   }}