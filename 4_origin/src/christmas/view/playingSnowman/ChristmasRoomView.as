package christmas.view.playingSnowman
{
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.controller.ChristmasRoomController;
   import christmas.loader.LoaderChristmasUIModule;
   import christmas.model.ChristmasRoomModel;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.view.chat.ChatView;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChristmasRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZEII:Array = [1738,1300];
       
      
      private var _contoller:ChristmasRoomController;
      
      private var _model:ChristmasRoomModel;
      
      private var _sceneScene:SceneScene;
      
      private var _sceneMap:ChristmasScneneMap;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _snowPackNumImg:Bitmap;
      
      private var _snowPackNumTxt:FilterFrameText;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _timer:TimerJuggler;
      
      public function ChristmasRoomView(param1:ChristmasRoomController, param2:ChristmasRoomModel)
      {
         super();
         this._contoller = param1;
         this._model = param2;
         initialize();
      }
      
      public function show() : void
      {
         _contoller.addChild(this);
      }
      
      private function initialize() : void
      {
         SoundManager.instance.playMusic("christmasRoom");
         _sceneScene = new SceneScene();
         ChatManager.Instance.state = 21;
         _chatFrame = ChatManager.Instance.view;
         _chatFrame.output.isLock = true;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
         _snowPackNumImg = ComponentFactory.Instance.creatBitmap("asset.christmas.snowpacknum");
         _snowPackNumTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.christmasRoom.snowPackNumTxt");
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.christmasRoom.activeTimeTxt");
         _snowPackNumTxt.text = ChristmasCoreController.instance.getBagSnowPacksCount() + "";
         addChild(_snowPackNumImg);
         addChild(_snowPackNumTxt);
         addChild(_activeTimeTxt);
         _roomMenuView = ComponentFactory.Instance.creat("christmas.room.menuView");
         addChild(_roomMenuView);
         _roomMenuView.addEventListener("close",_leaveRoom);
         flushTip();
         setMap();
         firestGetTime();
         addEvent();
      }
      
      private function addEvent() : void
      {
         ChristmasCoreManager.instance.addEventListener("update_times_room",__updateRoomTimes);
      }
      
      private function removeEvent() : void
      {
         ChristmasCoreManager.instance.removeEventListener("update_times_room",__updateRoomTimes);
      }
      
      private function __updateRoomTimes(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Date = _loc2_.readDate();
         ChristmasCoreController.instance.model.gameEndTime = _loc2_.readDate();
         ChristmasScneneMap.packsNum = 1;
         firestGetTime();
      }
      
      public function removeTimer() : void
      {
         _sceneMap.stopAllTimer();
      }
      
      public function setViewAgain() : void
      {
         SoundManager.instance.playMusic("christmasRoom");
         ChatManager.Instance.state = 21;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
         _chatFrame.output.isLock = true;
         _sceneMap.enterIng = false;
         firestGetTime();
      }
      
      private function flushTip() : void
      {
         _timer = TimerManager.getInstance().addTimerJuggler(60000,0);
         _timer.addEventListener("timer",updateTip);
         _timer.start();
      }
      
      private function updateTip(param1:Event) : void
      {
         firestGetTime();
      }
      
      private function firestGetTime() : void
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         var _loc3_:Number = _loc1_.getTime();
         var _loc5_:Number = ChristmasCoreController.instance.model.gameEndTime.getTime();
         var _loc6_:Number = _loc5_ - _loc3_;
         var _loc2_:int = _loc6_ / 3600000;
         var _loc4_:int = (_loc6_ - _loc2_ * 1000 * 60 * 60) / 60000;
         if(_loc4_ >= 0)
         {
            _activeTimeTxt.text = LanguageMgr.GetTranslation("christmas.flushTimecut",_loc2_,_loc4_ + 1);
         }
         else
         {
            _activeTimeTxt.text = LanguageMgr.GetTranslation("christmas.flushTimecut",0,0);
         }
         _snowPackNumTxt.text = ChristmasCoreController.instance.getBagSnowPacksCount() + "";
      }
      
      public function setMap(param1:Point = null) : void
      {
         ChristmasCoreController.isFrameChristmas = true;
         clearMap();
         var _loc7_:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(LoaderChristmasUIModule.Instance.getMapRes()) as Class)() as MovieClip;
         var _loc5_:Sprite = _loc7_.getChildByName("articleLayer") as Sprite;
         var _loc2_:Sprite = _loc7_.getChildByName("NPCMouse") as Sprite;
         var _loc9_:Sprite = _loc7_.getChildByName("mesh") as Sprite;
         var _loc6_:Sprite = _loc7_.getChildByName("bg") as Sprite;
         var _loc8_:Sprite = _loc7_.getChildByName("bgSize") as Sprite;
         var _loc4_:Sprite = _loc7_.getChildByName("snowCenter") as Sprite;
         var _loc3_:Sprite = _loc7_.getChildByName("decoration") as Sprite;
         if(_loc8_)
         {
            MAP_SIZEII[0] = _loc8_.width;
            MAP_SIZEII[1] = _loc8_.height;
         }
         else
         {
            MAP_SIZEII[0] = _loc6_.width;
            MAP_SIZEII[1] = _loc6_.height;
         }
         _sceneScene.setHitTester(new PathMapHitTester(_loc9_));
         if(!_sceneMap)
         {
            _sceneMap = new ChristmasScneneMap(_model,_sceneScene,_model.getPlayers(),_model.getObjects(),_loc6_,_loc9_,_loc5_,_loc2_,_loc3_,_loc4_);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(param1)
         {
            _sceneMap.sceneMapVO.defaultPos = param1;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var _loc1_:SceneMapVO = new SceneMapVO();
         _loc1_.mapName = LanguageMgr.GetTranslation("church.churchScene.WeddingMainScene");
         _loc1_.mapW = MAP_SIZEII[0];
         _loc1_.mapH = MAP_SIZEII[1];
         _loc1_.defaultPos = ComponentFactory.Instance.creatCustomObject("christmas.RoomView.sceneMapVOPosII");
         return _loc1_;
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(param1,param2);
         }
      }
      
      public function updatePlayerStauts(param1:int, param2:int, param3:Point = null) : void
      {
         if(_sceneMap)
         {
            _sceneMap.updatePlayersStauts(param1,param2,param3);
         }
      }
      
      public function updateSelfStatus(param1:int) : void
      {
         _sceneMap.updateSelfStatus(param1);
      }
      
      public function playerRevive(param1:int) : void
      {
         if(_sceneMap.selfPlayer && param1 == _sceneMap.selfPlayer.ID)
         {
            if(_roomMenuView)
            {
               _roomMenuView.visible = true;
            }
         }
         _sceneMap.playerRevive(param1);
      }
      
      private function _leaveRoom(param1:Event) : void
      {
         StateManager.setState("main");
         _contoller.dispose();
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
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",updateTip);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         _roomMenuView = null;
         _sceneScene = null;
         _sceneMap = null;
         _chatFrame = null;
      }
   }
}
