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
      
      public function ChristmasRoomView(controller:ChristmasRoomController, model:ChristmasRoomModel)
      {
         super();
         this._contoller = controller;
         this._model = model;
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
      
      private function __updateRoomTimes(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var begin:Date = pkg.readDate();
         ChristmasCoreController.instance.model.gameEndTime = pkg.readDate();
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
      
      private function updateTip(e:Event) : void
      {
         firestGetTime();
      }
      
      private function firestGetTime() : void
      {
         var now:Date = TimeManager.Instance.Now();
         var nowNum:Number = now.getTime();
         var endTime:Number = ChristmasCoreController.instance.model.gameEndTime.getTime();
         var bettwentime:Number = endTime - nowNum;
         var hours:int = bettwentime / 3600000;
         var minitues:int = (bettwentime - hours * 1000 * 60 * 60) / 60000;
         if(minitues >= 0)
         {
            _activeTimeTxt.text = LanguageMgr.GetTranslation("christmas.flushTimecut",hours,minitues + 1);
         }
         else
         {
            _activeTimeTxt.text = LanguageMgr.GetTranslation("christmas.flushTimecut",0,0);
         }
         _snowPackNumTxt.text = ChristmasCoreController.instance.getBagSnowPacksCount() + "";
      }
      
      public function setMap(localPos:Point = null) : void
      {
         ChristmasCoreController.isFrameChristmas = true;
         clearMap();
         var mapRes:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(LoaderChristmasUIModule.Instance.getMapRes()) as Class)() as MovieClip;
         var entity:Sprite = mapRes.getChildByName("articleLayer") as Sprite;
         var sky:Sprite = mapRes.getChildByName("NPCMouse") as Sprite;
         var mesh:Sprite = mapRes.getChildByName("mesh") as Sprite;
         var bg:Sprite = mapRes.getChildByName("bg") as Sprite;
         var bgSize:Sprite = mapRes.getChildByName("bgSize") as Sprite;
         var snow:Sprite = mapRes.getChildByName("snowCenter") as Sprite;
         var decoration:Sprite = mapRes.getChildByName("decoration") as Sprite;
         if(bgSize)
         {
            MAP_SIZEII[0] = bgSize.width;
            MAP_SIZEII[1] = bgSize.height;
         }
         else
         {
            MAP_SIZEII[0] = bg.width;
            MAP_SIZEII[1] = bg.height;
         }
         _sceneScene.setHitTester(new PathMapHitTester(mesh));
         if(!_sceneMap)
         {
            _sceneMap = new ChristmasScneneMap(_model,_sceneScene,_model.getPlayers(),_model.getObjects(),bg,mesh,entity,sky,decoration,snow);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(localPos)
         {
            _sceneMap.sceneMapVO.defaultPos = localPos;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var sceneMapVO:SceneMapVO = new SceneMapVO();
         sceneMapVO.mapName = LanguageMgr.GetTranslation("church.churchScene.WeddingMainScene");
         sceneMapVO.mapW = MAP_SIZEII[0];
         sceneMapVO.mapH = MAP_SIZEII[1];
         sceneMapVO.defaultPos = ComponentFactory.Instance.creatCustomObject("christmas.RoomView.sceneMapVOPosII");
         return sceneMapVO;
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         if(_sceneMap)
         {
            _sceneMap.movePlayer(id,p);
         }
      }
      
      public function updatePlayerStauts(id:int, status:int, point:Point = null) : void
      {
         if(_sceneMap)
         {
            _sceneMap.updatePlayersStauts(id,status,point);
         }
      }
      
      public function updateSelfStatus(value:int) : void
      {
         _sceneMap.updateSelfStatus(value);
      }
      
      public function playerRevive(id:int) : void
      {
         if(_sceneMap.selfPlayer && id == _sceneMap.selfPlayer.ID)
         {
            if(_roomMenuView)
            {
               _roomMenuView.visible = true;
            }
         }
         _sceneMap.playerRevive(id);
      }
      
      private function _leaveRoom(e:Event) : void
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
