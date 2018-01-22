package worldboss.view
{
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import worldboss.WorldBossManager;
   import worldboss.WorldBossRoomController;
   import worldboss.model.WorldBossRoomModel;
   
   public class WorldBossRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZEII:Array = [1738,1300];
       
      
      private var _contoller:WorldBossRoomController;
      
      private var _model:WorldBossRoomModel;
      
      private var _sceneScene:SceneScene;
      
      private var _sceneMap:WorldBossScneneMap;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _bossHP:WorldBossHPScript;
      
      private var _totalContainer:WorldBossRoomTotalInfoView;
      
      private var _resurrectFrame:WorldBossResurrectView;
      
      private var _buffIcon:WorldBossBuffIcon;
      
      private var _buffIconArr:Array;
      
      private var _timer:Timer;
      
      private var _diff:int;
      
      private var _hideBtn:WorldBossHideBtn;
      
      public function WorldBossRoomView(param1:WorldBossRoomController, param2:WorldBossRoomModel)
      {
         _buffIconArr = [];
         super();
         this._contoller = param1;
         this._model = param2;
         initialize();
      }
      
      public static function getImagePath(param1:int) : String
      {
         return PathManager.solveWorldbossBuffPath() + param1 + ".png";
      }
      
      public function show() : void
      {
         _contoller.addChild(this);
      }
      
      private function initialize() : void
      {
         SoundManager.instance.playMusic("worldbossroom-" + WorldBossManager.Instance.BossResourceId);
         _sceneScene = new SceneScene();
         ChatManager.Instance.state = 28;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
         _roomMenuView = ComponentFactory.Instance.creat("worldboss.room.menuView");
         addChild(_roomMenuView);
         _roomMenuView.addEventListener("close",_leaveRoom);
         _bossHP = ComponentFactory.Instance.creat("worldboss.room.bossHP");
         addChild(_bossHP);
         refreshHpScript();
         _diff = !!WorldBossManager.Instance.bossInfo.fightOver?0:WorldBossManager.Instance.bossInfo.getLeftTime();
         _totalContainer = ComponentFactory.Instance.creat("worldboss.room.infoView");
         addChildAt(_totalContainer,0);
         _totalContainer.updata_yourSelf_damage();
         _totalContainer.setTimeCount(_diff);
         _buffIcon = ComponentFactory.Instance.creat("worldboss.room.buffIcon");
         addChild(_buffIcon);
         _buffIcon.visible = !WorldBossManager.Instance.bossInfo.fightOver;
         _buffIcon.addEventListener("change",showBuff);
         _hideBtn = new WorldBossHideBtn();
         addChild(_hideBtn);
         setMap();
         _timer = new Timer(1000,_diff);
         _timer.addEventListener("timer",__timeOne);
         _timer.start();
      }
      
      public function refreshHpScript() : void
      {
         if(!_bossHP)
         {
            return;
         }
         if(WorldBossManager.Instance.isShowBlood && (!WorldBossManager.Instance.bossInfo.fightOver || !WorldBossManager.Instance.bossInfo.isLiving))
         {
            _bossHP.visible = true;
            _bossHP.refreshBossName();
            _bossHP.refreshBlood();
         }
         else
         {
            _bossHP.visible = false;
         }
      }
      
      public function setViewAgain() : void
      {
         SoundManager.instance.playMusic("worldbossroom-" + WorldBossManager.Instance.BossResourceId);
         ChatManager.Instance.state = 28;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
         _totalContainer.updata_yourSelf_damage();
         _sceneMap.enterIng = false;
         _sceneMap.removePrompt();
         _buffIcon.visible = !WorldBossManager.Instance.bossInfo.fightOver;
         refreshHpScript();
      }
      
      public function __timeOne(param1:TimerEvent) : void
      {
         _diff = Number(_diff) - 1;
         if(_diff < 0)
         {
            timeComplete();
         }
         else
         {
            _totalContainer.setTimeCount(_diff);
         }
      }
      
      public function timeComplete() : void
      {
         _timer.removeEventListener("timer",__timeOne);
         if(_timer.running)
         {
            _timer.reset();
         }
         if(WorldBossManager.Instance.bossInfo.isLiving && _bossHP)
         {
            removeChild(_bossHP);
            _bossHP.dispose();
            _bossHP = null;
         }
      }
      
      public function setMap(param1:Point = null) : void
      {
         clearMap();
         var _loc6_:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(getMapRes()) as Class)() as MovieClip;
         var _loc4_:Sprite = _loc6_.getChildByName("articleLayer") as Sprite;
         var _loc2_:Sprite = _loc6_.getChildByName("worldbossMouse") as Sprite;
         var _loc8_:Sprite = _loc6_.getChildByName("mesh") as Sprite;
         var _loc5_:Sprite = _loc6_.getChildByName("bg") as Sprite;
         var _loc7_:Sprite = _loc6_.getChildByName("bgSize") as Sprite;
         var _loc3_:Sprite = _loc6_.getChildByName("decoration") as Sprite;
         if(_loc7_)
         {
            MAP_SIZEII[0] = _loc7_.width;
            MAP_SIZEII[1] = _loc7_.height;
         }
         else
         {
            MAP_SIZEII[0] = _loc5_.width;
            MAP_SIZEII[1] = _loc5_.height;
         }
         _sceneScene.setHitTester(new PathMapHitTester(_loc8_));
         if(!_sceneMap)
         {
            _sceneMap = new WorldBossScneneMap(_model,_sceneScene,_model.getPlayers(),_loc5_,_loc8_,_loc4_,_loc2_,_loc3_);
            addChildAt(_sceneMap,0);
         }
         _sceneMap.sceneMapVO = getSceneMapVO();
         if(param1)
         {
            _sceneMap.sceneMapVO.defaultPos = param1;
         }
         _sceneMap.addSelfPlayer();
         _sceneMap.setCenter();
         SocketManager.Instance.out.sendAddPlayer(WorldBossManager.Instance.bossInfo.myPlayerVO.playerPos);
         if(WorldBossManager.Instance.bossInfo.myPlayerVO.reviveCD > 0)
         {
            showResurrectFrame(WorldBossManager.Instance.bossInfo.myPlayerVO.reviveCD);
         }
      }
      
      public function getSceneMapVO() : SceneMapVO
      {
         var _loc1_:SceneMapVO = new SceneMapVO();
         _loc1_.mapName = LanguageMgr.GetTranslation("church.churchScene.WeddingMainScene");
         _loc1_.mapW = MAP_SIZEII[0];
         _loc1_.mapH = MAP_SIZEII[1];
         _loc1_.defaultPos = ComponentFactory.Instance.creatCustomObject("worldboss.RoomView.sceneMapVOPosII");
         return _loc1_;
      }
      
      public function clearBuff() : void
      {
         var _loc1_:* = null;
         while(_buffIconArr.length > 0)
         {
            _loc1_ = _buffIconArr[0] as BuffItem;
            _buffIconArr.shift();
            removeChild(_loc1_);
            _loc1_.dispose();
         }
      }
      
      public function showBuff(param1:Event = null) : void
      {
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
      
      public function checkSelfStatus() : void
      {
         if(_sceneMap.checkSelfStatus() == 3 || !WorldBossManager.Instance.bossInfo.fightOver && WorldBossManager.IsSuccessStartGame)
         {
            showResurrectFrame(WorldBossManager.Instance.bossInfo.timeCD);
         }
         else
         {
            _sceneMap.updateSelfStatus(1);
         }
      }
      
      private function showResurrectFrame(param1:int) : void
      {
         _resurrectFrame = new WorldBossResurrectView(param1);
         PositionUtils.setPos(_resurrectFrame,"worldRoom.resurrectView.pos");
         addChild(_resurrectFrame);
         _resurrectFrame.addEventListener("complete",__resurrectTimeOver);
      }
      
      public function playerRevive(param1:int) : void
      {
         if(_sceneMap.selfPlayer && param1 == _sceneMap.selfPlayer.ID)
         {
            if(_resurrectFrame)
            {
               removeFrame();
            }
            if(_roomMenuView)
            {
               _roomMenuView.visible = true;
            }
         }
         _sceneMap.playerRevive(param1);
      }
      
      private function __resurrectTimeOver(param1:Event = null) : void
      {
         removeFrame();
         _roomMenuView.visible = true;
         _sceneMap.updateSelfStatus(1);
      }
      
      private function removeFrame() : void
      {
         if(_resurrectFrame)
         {
            _resurrectFrame.removeEventListener("complete",__resurrectTimeOver);
            if(_resurrectFrame.parent)
            {
               removeChild(_resurrectFrame);
            }
            _resurrectFrame.dispose();
            _resurrectFrame = null;
         }
      }
      
      private function _leaveRoom(param1:Event) : void
      {
         StateManager.setState("main");
         _contoller.dispose();
      }
      
      public function gameOver() : void
      {
         _sceneMap.gameOver();
         _buffIcon.visible = false;
         _totalContainer.restTimeInfo();
      }
      
      public function updataRanking(param1:Array) : void
      {
         _totalContainer.updataRanking(param1);
      }
      
      public function getMapRes() : String
      {
         return "tank.WorldBoss.Map-" + WorldBossManager.Instance.BossResourceId;
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
         WorldBossManager.Instance.bossInfo.myPlayerVO.buffs = [];
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timeOne);
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _buffIcon = null;
         _roomMenuView = null;
         _totalContainer = null;
         _bossHP = null;
         _resurrectFrame = null;
         _sceneScene = null;
         _sceneMap = null;
         _chatFrame = null;
         _hideBtn = null;
      }
   }
}
