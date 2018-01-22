package collectionTask.view
{
   import church.vo.SceneMapVO;
   import collectionTask.CollectionTaskManager;
   import collectionTask.model.CollectionTaskModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCondition;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class CollectionTaskRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZE:Array = [1200,1077];
       
      
      private var _sceneScene:SceneScene;
      
      private var _chatFrame:Sprite;
      
      private var _sceneMap:CollectionTaskSceneMap;
      
      private var _model:CollectionTaskModel;
      
      private var _menuView:CollectionTaskMenuView;
      
      private var _exitMenuView:CollectionTaskExitMenuView;
      
      private var _taskProgressView:TaskProgressView;
      
      private var _progress:ProgressSprite;
      
      private var _taskCompleteMc:MovieClip;
      
      private var _backBtnMc:MovieClip;
      
      public function CollectionTaskRoomView(param1:CollectionTaskModel)
      {
         super();
         _model = param1;
         initView();
      }
      
      private function initView() : void
      {
         _sceneScene = new SceneScene();
         ChatManager.Instance.state = 0;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         setMap();
         _menuView = ComponentFactory.Instance.creatCustomObject("collectionTask.CollectionTaskMenuView",[_model]);
         addChild(_menuView);
         _exitMenuView = ComponentFactory.Instance.creatCustomObject("collectionTask.CollectionTaskExitMenuView");
         addChild(_exitMenuView);
         _taskProgressView = ComponentFactory.Instance.creatCustomObject("collectionTask.taskProgressView");
         addChild(_taskProgressView);
      }
      
      public function setMap(param1:Point = null) : void
      {
         clearMap();
         var _loc6_:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(getMapRes()) as Class)() as MovieClip;
         var _loc3_:Sprite = _loc6_.getChildByName("articleLayer") as Sprite;
         var _loc4_:Sprite = _loc6_.getChildByName("entity") as Sprite;
         var _loc2_:Sprite = _loc6_.getChildByName("sky") as Sprite;
         var _loc7_:Sprite = _loc6_.getChildByName("mesh") as Sprite;
         var _loc5_:Sprite = _loc6_.getChildByName("bg") as Sprite;
         MAP_SIZE[0] = _loc5_.width;
         MAP_SIZE[1] = _loc5_.height;
         _sceneScene.setHitTester(new PathMapHitTester(_loc7_));
         if(!_sceneMap)
         {
            _sceneMap = new CollectionTaskSceneMap(_model,_sceneScene,_model.getPlayers(),_loc5_,_loc7_,_loc4_,_loc2_,_loc3_);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.setPlayProgressFunc(addProgressMc);
         _sceneMap.setStopProgressFunc(stopProgressMc);
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(param1)
         {
            _sceneMap.sceneMapVO.defaultPos = param1;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
      }
      
      public function refreshProgress() : void
      {
         _taskProgressView.refreshView();
         if(CollectionTaskManager.Instance.questInfo.isCompleted)
         {
            _taskCompleteMc = ComponentFactory.Instance.creat("collectionTask.tashComplete.MC");
            addChild(_taskCompleteMc);
            _taskCompleteMc.x = 350;
            _taskCompleteMc.y = 280;
            _taskCompleteMc.addEventListener("enterFrame",__taskCompleteHandler);
            _backBtnMc = ComponentFactory.Instance.creat("collectionTask.backBtn.MC");
            _backBtnMc.scaleY = 1.1;
            _backBtnMc.x = _exitMenuView.x;
            _backBtnMc.y = _exitMenuView.y;
            addChild(_backBtnMc);
         }
      }
      
      protected function __taskCompleteHandler(param1:Event) : void
      {
         if(_taskCompleteMc.currentFrame >= 71)
         {
            _taskCompleteMc.removeEventListener("enterFrame",__taskCompleteHandler);
            removeChild(_taskCompleteMc);
            _taskCompleteMc.stop();
            _taskCompleteMc = null;
         }
      }
      
      public function addProgressMc() : void
      {
         if(!checkCanCollect())
         {
            return;
         }
         _progress = new ProgressSprite(SocketManager.Instance.out.sendCollectionComplete);
         _progress.x = 430;
         _progress.y = 440;
         addChild(_progress);
      }
      
      private function checkCanCollect() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:QuestInfo = CollectionTaskManager.Instance.questInfo;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.conditions.length)
         {
            _loc1_ = _loc3_.conditions[_loc2_];
            if(_loc1_.param != CollectionTaskManager.Instance.collectedId)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("collectionTask.cannotCollectTip",ItemManager.Instance.getTemplateById(_loc1_.param).Name));
               return false;
            }
            if(_loc3_.progress[_loc2_] > 0 && !CollectionTaskManager.Instance.isCollecting)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function stopProgressMc() : void
      {
         ObjectUtils.disposeObject(_progress);
         _progress = null;
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var _loc1_:SceneMapVO = new SceneMapVO();
         _loc1_.mapName = LanguageMgr.GetTranslation("collectionTask.scene");
         _loc1_.mapW = MAP_SIZE[0];
         _loc1_.mapH = MAP_SIZE[1];
         _loc1_.defaultPos = ComponentFactory.Instance.creatCustomObject("collectionTask.sceneMapVOPos");
         return _loc1_;
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(param1,param2);
         }
      }
      
      public function getAllPlayersLength() : int
      {
         return _sceneMap.characters.length;
      }
      
      public function addRobertPlayer(param1:int) : void
      {
         if(_sceneMap)
         {
            _sceneMap.addRobertPlayer(param1);
         }
      }
      
      private function clearMap() : void
      {
         if(_sceneMap)
         {
            if(_sceneMap.parent)
            {
               _sceneMap.parent.removeChild(_sceneMap);
            }
            _sceneMap.dispose();
         }
         _sceneMap = null;
      }
      
      public function getMapRes() : String
      {
         return "tank.collectionTask.Map";
      }
      
      public function dispose() : void
      {
         if(_backBtnMc)
         {
            removeChild(_backBtnMc);
            _backBtnMc = null;
         }
         if(_sceneScene)
         {
            _sceneScene.dispose();
         }
         _sceneScene = null;
         if(_sceneMap)
         {
            if(_sceneMap.parent)
            {
               _sceneMap.parent.removeChild(_sceneMap);
            }
            _sceneMap.dispose();
         }
         _sceneMap = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         if(_chatFrame.parent)
         {
            _chatFrame.parent.removeChild(_chatFrame);
         }
         _chatFrame = null;
         ObjectUtils.disposeObject(_menuView);
         _menuView = null;
         ObjectUtils.disposeObject(_exitMenuView);
         _exitMenuView = null;
         ObjectUtils.disposeObject(_taskProgressView);
         _taskProgressView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
