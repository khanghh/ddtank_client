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
      
      public function CollectionTaskRoomView(model:CollectionTaskModel)
      {
         super();
         _model = model;
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
      
      public function setMap(localPos:Point = null) : void
      {
         clearMap();
         var mapRes:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(getMapRes()) as Class)() as MovieClip;
         var article:Sprite = mapRes.getChildByName("articleLayer") as Sprite;
         var entity:Sprite = mapRes.getChildByName("entity") as Sprite;
         var sky:Sprite = mapRes.getChildByName("sky") as Sprite;
         var mesh:Sprite = mapRes.getChildByName("mesh") as Sprite;
         var bg:Sprite = mapRes.getChildByName("bg") as Sprite;
         MAP_SIZE[0] = bg.width;
         MAP_SIZE[1] = bg.height;
         _sceneScene.setHitTester(new PathMapHitTester(mesh));
         if(!_sceneMap)
         {
            _sceneMap = new CollectionTaskSceneMap(_model,_sceneScene,_model.getPlayers(),bg,mesh,entity,sky,article);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.setPlayProgressFunc(addProgressMc);
         _sceneMap.setStopProgressFunc(stopProgressMc);
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(localPos)
         {
            _sceneMap.sceneMapVO.defaultPos = localPos;
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
      
      protected function __taskCompleteHandler(event:Event) : void
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
         var i:int = 0;
         var condition:* = null;
         var info:QuestInfo = CollectionTaskManager.Instance.questInfo;
         for(i = 0; i < info.conditions.length; )
         {
            condition = info.conditions[i];
            if(condition.param != CollectionTaskManager.Instance.collectedId)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("collectionTask.cannotCollectTip",ItemManager.Instance.getTemplateById(condition.param).Name));
               return false;
            }
            if(info.progress[i] > 0 && !CollectionTaskManager.Instance.isCollecting)
            {
               return true;
            }
            i++;
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
         var sceneMapVO:SceneMapVO = new SceneMapVO();
         sceneMapVO.mapName = LanguageMgr.GetTranslation("collectionTask.scene");
         sceneMapVO.mapW = MAP_SIZE[0];
         sceneMapVO.mapH = MAP_SIZE[1];
         sceneMapVO.defaultPos = ComponentFactory.Instance.creatCustomObject("collectionTask.sceneMapVOPos");
         return sceneMapVO;
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(id,p);
         }
      }
      
      public function getAllPlayersLength() : int
      {
         return _sceneMap.characters.length;
      }
      
      public function addRobertPlayer(len:int) : void
      {
         if(_sceneMap)
         {
            _sceneMap.addRobertPlayer(len);
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
