package worldboss.view
{
   import church.vo.SceneMapVO;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.DailyButtunBar;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.model.WorldBossRoomModel;
   import worldboss.player.PlayerVO;
   import worldboss.player.WorldRoomPlayer;
   
   public class WorldBossScneneMap extends Sprite implements Disposeable
   {
      
      public static const SCENE_ALLOW_FIRES:int = 6;
       
      
      private const CLICK_INTERVAL:Number = 200;
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      public var selfPlayer:WorldRoomPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _mouseMovie:MovieClip;
      
      private var _currentLoadingPlayer:WorldRoomPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:WorldBossRoomModel;
      
      private var _worldboss:MovieClip;
      
      private var _worldboss_mc:MovieClip;
      
      private var _worldboss_sky:MovieClip;
      
      private var armyPos:Point;
      
      private var decorationLayer:Sprite;
      
      private var _isShowOther:Boolean = true;
      
      private var _beforeTimeView:WorldBossBeforeTimer;
      
      private var r:int = 250;
      
      private var auto:Point;
      
      private var autoMove:Boolean = false;
      
      private var clickAgain:Boolean = false;
      
      private var _entering:Boolean = false;
      
      private var _isFight:Boolean = false;
      
      private var _frame_name:String = "stand";
      
      protected var reference:WorldRoomPlayer;
      
      public function WorldBossScneneMap(param1:WorldBossRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null, param8:Sprite = null)
      {
         super();
         _model = param1;
         this.sceneScene = param2;
         this._data = param3;
         if(param4 == null)
         {
            this.bgLayer = new Sprite();
         }
         else
         {
            this.bgLayer = param4;
         }
         this.meshLayer = param5 == null?new Sprite():param5;
         this.meshLayer.alpha = 0;
         this.articleLayer = param6 == null?new Sprite():param6;
         this.decorationLayer = param8 == null?new Sprite():param8;
         this.skyLayer = param7 == null?new Sprite():param7;
         var _loc9_:Boolean = false;
         this.decorationLayer.mouseEnabled = _loc9_;
         this.decorationLayer.mouseChildren = _loc9_;
         this.addChild(bgLayer);
         this.addChild(articleLayer);
         this.addChild(decorationLayer);
         this.addChild(meshLayer);
         this.addChild(skyLayer);
         _isShowOther = !DailyButtunBar.Insance.hideFlag;
         init();
         addEvent();
         initBoss();
         initBeforeTimeView();
      }
      
      private function initBeforeTimeView() : void
      {
         var _loc1_:int = WorldBossManager.Instance.beforeStartTime;
         if(_loc1_ > 0)
         {
            hideBoss();
            _beforeTimeView = new WorldBossBeforeTimer(_loc1_);
            _beforeTimeView.addEventListener("complete",beforeTimeEndHandler,false,0,true);
            LayerManager.Instance.addToLayer(_beforeTimeView,3,true);
         }
      }
      
      private function beforeTimeEndHandler(param1:Event) : void
      {
         disposeBeforeTimeView();
         showBoss();
      }
      
      private function disposeBeforeTimeView() : void
      {
         if(_beforeTimeView)
         {
            _beforeTimeView.removeEventListener("complete",beforeTimeEndHandler);
            ObjectUtils.disposeObject(_beforeTimeView);
            _beforeTimeView = null;
         }
      }
      
      private function hideBoss() : void
      {
         if(_worldboss)
         {
            _worldboss.visible = false;
         }
         if(_worldboss_mc)
         {
            _worldboss_mc.visible = false;
         }
         if(_worldboss_sky)
         {
            _worldboss_sky.visible = false;
         }
         if(bgLayer && bgLayer.getChildByName("prompt"))
         {
            bgLayer.getChildByName("prompt").visible = false;
         }
      }
      
      private function showBoss() : void
      {
         if(_worldboss)
         {
            _worldboss.visible = true;
         }
         if(_worldboss_mc)
         {
            _worldboss_mc.visible = true;
         }
         if(_worldboss_sky)
         {
            _worldboss_sky.visible = true;
         }
         if(bgLayer && bgLayer.getChildByName("prompt"))
         {
            bgLayer.getChildByName("prompt").visible = true;
         }
      }
      
      private function initBoss() : void
      {
         if(bgLayer != null && articleLayer != null)
         {
            _worldboss = skyLayer.getChildByName("worldboss_mc") as MovieClip;
            _worldboss.addEventListener("click",_enterWorldBossGame);
            _worldboss.buttonMode = true;
            _worldboss_mc = bgLayer.getChildByName("worldboss") as MovieClip;
            _worldboss_sky = bgLayer.getChildByName("worldboss_sky") as MovieClip;
            armyPos = new Point(bgLayer.getChildByName("armyPos").x,bgLayer.getChildByName("armyPos").y);
         }
         if(WorldBossManager.Instance.bossInfo.fightOver)
         {
            _worldboss.parent.removeChild(_worldboss);
            _worldboss_mc.parent.removeChild(_worldboss_mc);
            _worldboss_sky.visible = false;
            removePrompt();
         }
      }
      
      private function _enterWorldBossGame(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(autoMove || selfPlayer.playerVO.playerStauts != 1 || !selfPlayer.getCanAction() || _entering)
         {
            return;
         }
         CheckWeaponManager.instance.setFunction(this,_enterWorldBossGame,[param1]);
         if(checkCanStartGame() && getTimer() - _lastClick > _clickInterval)
         {
            SoundManager.instance.play("008");
            _mouseMovie.gotoAndStop(1);
            _lastClick = getTimer();
            if(checkDistance())
            {
               CreateStartGame();
            }
            else if(auto && !sceneScene.hit(auto))
            {
               autoMove = true;
               selfPlayer.addEventListener("characterArrivedNextStep",__arrive);
               selfPlayer.playerVO.walkPath = sceneScene.searchPath(selfPlayer.playerPoint,auto);
               selfPlayer.playerVO.walkPath.shift();
               selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(selfPlayer.playerPoint,selfPlayer.playerVO.walkPath[0]);
               selfPlayer.playerVO.currentWalkStartPoint = selfPlayer.currentWalkStartPoint;
               sendMyPosition(selfPlayer.playerVO.walkPath.concat());
            }
         }
      }
      
      private function checkDistance() : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = selfPlayer.x - armyPos.x;
         var _loc1_:Number = selfPlayer.y - armyPos.y;
         if(Math.pow(_loc2_,2) + Math.pow(_loc1_,2) > Math.pow(r,2))
         {
            _loc3_ = Math.atan2(_loc1_,_loc2_);
            auto = new Point(armyPos.x,armyPos.y);
            auto.x = auto.x + (_loc2_ > 0?1:-1) * Math.abs(Math.cos(_loc3_) * r);
            auto.y = auto.y + (_loc1_ > 0?1:-1) * Math.abs(Math.sin(_loc3_) * r);
            return false;
         }
         return true;
      }
      
      private function checkCanStartGame() : Boolean
      {
         var _loc1_:Boolean = true;
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function set enterIng(param1:Boolean) : void
      {
         _entering = param1;
      }
      
      public function removePrompt() : void
      {
         if(bgLayer.getChildByName("prompt"))
         {
            bgLayer.removeChild(bgLayer.getChildByName("prompt"));
         }
      }
      
      private function CreateStartGame() : void
      {
         if(_entering)
         {
            return;
         }
         if(WorldBossManager.Instance.bossInfo.need_ticket_count == 0)
         {
            _entering = true;
            startGame();
            return;
         }
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.tickets.propInfo",WorldBossManager.Instance.bossInfo.need_ticket_count),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _loc1_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         switch(int(param1.responseCode))
         {
            case 0:
               _loc2_.dispose();
               autoMove = false;
               break;
            default:
               _loc2_.dispose();
               autoMove = false;
               break;
            default:
               _loc2_.dispose();
               autoMove = false;
               break;
            case 3:
            case 4:
               if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(WorldBossManager.Instance.bossInfo.ticketID) > 0)
               {
                  startGame();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worldboss.tickets.none"),0,true);
                  autoMove = false;
               }
               _loc2_.dispose();
         }
      }
      
      private function startGame() : void
      {
         if(!WorldBossManager.Instance.isLoadingState)
         {
            SocketManager.Instance.out.createUserGuide(14);
         }
      }
      
      protected function __startFight(param1:Event) : void
      {
         _isFight = true;
         selfPlayer.removeEventListener("characterArrivedNextStep",__arrive);
      }
      
      private function __stopFight(param1:Event) : void
      {
         enterIng = false;
      }
      
      private function __arrive(param1:SceneCharacterEvent) : void
      {
         if(autoMove)
         {
            CreateStartGame();
         }
      }
      
      public function gameOver() : void
      {
         _worldboss.mouseEnabled = false;
         _worldboss.removeEventListener("click",_enterWorldBossGame);
         if(!WorldBossManager.Instance.bossInfo.isLiving)
         {
            _worldboss_mc.gotoAndPlay("out");
         }
         else
         {
            _worldboss_mc.gotoAndPlay("outB");
         }
         _worldboss_sky.visible = false;
         removePrompt();
      }
      
      public function get sceneMapVO() : SceneMapVO
      {
         return _sceneMapVO;
      }
      
      public function set sceneMapVO(param1:SceneMapVO) : void
      {
         _sceneMapVO = param1;
      }
      
      protected function init() : void
      {
         _characters = new DictionaryData(true);
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.worldboss.room.MouseClickMovie") as Class;
         _mouseMovie = new _loc1_() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         bgLayer.addChild(_mouseMovie);
         last_click = 0;
      }
      
      protected function addEvent() : void
      {
         _model.addEventListener("playerNameVisible",menuChange);
         _model.addEventListener("playerChatBallVisible",menuChange);
         addEventListener("click",__click);
         addEventListener("enterFrame",updateMap);
         _data.addEventListener("add",__addPlayer);
         _data.addEventListener("remove",__removePlayer);
         WorldBossManager.Instance.addEventListener("worldBossRoomFull",__onRoomFull);
         WorldBossManager.Instance.addEventListener("stopFight",__stopFight);
         WorldBossManager.Instance.addEventListener("startFight",__startFight);
         WorldBossManager.Instance.addEventListener("worldBossHidePlayerChange",_hideOtherPlayer);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         __click(param1.data[0]);
      }
      
      private function _hideOtherPlayer(param1:WorldBossRoomEvent) : void
      {
         _isShowOther = param1.data as Boolean;
         if(_characters)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _characters;
            for each(var _loc2_ in _characters)
            {
               if(_loc2_.ID != PlayerManager.Instance.Self.ID)
               {
                  _loc2_.visible = _isShowOther;
               }
            }
         }
      }
      
      private function __onRoomFull(param1:WorldBossRoomEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worldboss.room.roomFull"),0,true);
         _entering = false;
      }
      
      private function menuChange(param1:WorldBossRoomEvent) : void
      {
         var _loc2_:* = param1.type;
         if("playerNameVisible" === _loc2_)
         {
            nameVisible();
         }
      }
      
      public function nameVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var _loc1_ in _characters)
         {
            _loc1_.isShowName = _model.playerNameVisible;
         }
      }
      
      protected function updateMap(param1:Event) : void
      {
         if(!_characters || _characters.length <= 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _characters;
         for each(var _loc2_ in _characters)
         {
            _loc2_.updatePlayer();
            _loc2_.isShowName = _model.playerNameVisible;
         }
         BuildEntityDepth();
      }
      
      protected function __click(param1:MouseEvent) : void
      {
         if(!selfPlayer || selfPlayer.playerVO.playerStauts != 1 || !selfPlayer.getCanAction())
         {
            return;
         }
         var _loc2_:Point = this.globalToLocal(new Point(param1.stageX,param1.stageY));
         autoMove = false;
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!sceneScene.hit(_loc2_))
            {
               selfPlayer.playerVO.walkPath = sceneScene.searchPath(selfPlayer.playerPoint,_loc2_);
               selfPlayer.playerVO.walkPath.shift();
               selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(selfPlayer.playerPoint,selfPlayer.playerVO.walkPath[0]);
               selfPlayer.playerVO.currentWalkStartPoint = selfPlayer.currentWalkStartPoint;
               sendMyPosition(selfPlayer.playerVO.walkPath.concat());
               _mouseMovie.x = _loc2_.x;
               _mouseMovie.y = _loc2_.y;
               _mouseMovie.play();
            }
         }
      }
      
      public function sendMyPosition(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         while(_loc4_ < param1.length)
         {
            _loc2_.push(int(param1[_loc4_].x),int(param1[_loc4_].y));
            _loc4_++;
         }
         var _loc3_:String = _loc2_.toString();
         SocketManager.Instance.out.sendWorldBossRoomMove(param1[param1.length - 1].x,param1[param1.length - 1].y,_loc3_);
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         var _loc3_:* = null;
         if(_characters[param1])
         {
            _loc3_ = _characters[param1] as WorldRoomPlayer;
            if(!_loc3_.getCanAction())
            {
               _loc3_.playerVO.playerStauts = 1;
               _loc3_.setStatus();
            }
            _loc3_.playerVO.walkPath = param2;
            _loc3_.playerWalk(param2);
         }
      }
      
      public function updatePlayersStauts(param1:int, param2:int, param3:Point) : void
      {
         var _loc4_:* = null;
         if(_characters[param1])
         {
            _loc4_ = _characters[param1] as WorldRoomPlayer;
            if(param2 == 1 && _loc4_.playerVO.playerStauts == 3)
            {
               _loc4_.playerVO.playerStauts = param2;
               _loc4_.playerVO.playerPos = WorldBossManager.Instance.bossInfo.playerDefaultPos;
               _loc4_.setStatus();
            }
            else if(param2 == 2)
            {
               if(!_loc4_.getCanAction())
               {
                  _loc4_.playerVO.playerStauts = 1;
                  _loc4_.setStatus();
               }
               _loc4_.playerVO.playerStauts = param2;
               _loc4_.isReadyFight = true;
               _loc4_.addEventListener("readyFight",__otherPlayrStartFight);
               _loc4_.playerVO.walkPath = [param3];
               _loc4_.playerWalk([param3]);
            }
            else
            {
               _loc4_.playerVO.playerStauts = param2;
               _loc4_.setStatus();
            }
         }
      }
      
      public function __otherPlayrStartFight(param1:WorldBossRoomEvent) : void
      {
         var _loc2_:WorldRoomPlayer = param1.currentTarget as WorldRoomPlayer;
         _loc2_.removeEventListener("readyFight",__otherPlayrStartFight);
         _loc2_.sceneCharacterDirection = SceneCharacterDirection.getDirection(_loc2_.playerPoint,armyPos);
         _loc2_.dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         _loc2_.isReadyFight = false;
         _loc2_.setStatus();
      }
      
      public function updateSelfStatus(param1:int) : void
      {
         if(selfPlayer.playerVO.playerStauts == 3)
         {
            selfPlayer.playerVO.playerPos = WorldBossManager.Instance.bossInfo.playerDefaultPos;
            ajustScreen(selfPlayer);
            setCenter();
            _entering = false;
         }
         selfPlayer.playerVO.playerStauts = param1;
         selfPlayer.setStatus();
         SocketManager.Instance.out.sendWorldBossRoomStauts(param1);
         checkGameOver();
      }
      
      public function checkSelfStatus() : int
      {
         return selfPlayer.playerVO.playerStauts;
      }
      
      public function playerRevive(param1:int) : void
      {
         var _loc2_:* = null;
         if(_characters[param1])
         {
            _loc2_ = _characters[param1] as WorldRoomPlayer;
            _loc2_.revive();
            selfPlayer.playerVO.playerStauts = 1;
            _entering = false;
         }
         if(_isFight)
         {
            SocketManager.Instance.out.createUserGuide(14);
            _isFight = false;
         }
      }
      
      private function worldBoss_mc_gotoAndplay() : void
      {
         _worldboss_mc.gotoAndPlay(_frame_name);
      }
      
      private function checkGameOver() : Boolean
      {
         if(WorldBossManager.Instance.bossInfo.fightOver && _worldboss)
         {
            _worldboss.mouseEnabled = false;
            _worldboss.removeEventListener("click",_enterWorldBossGame);
            if(!WorldBossManager.Instance.bossInfo.isLiving)
            {
               _frame_name = "out";
            }
            else if(WorldBossManager.Instance.bossInfo.getLeftTime() == 0)
            {
               _frame_name = "outB";
            }
            setTimeout(worldBoss_mc_gotoAndplay,1500);
            _worldboss_sky.visible = false;
         }
         return WorldBossManager.Instance.bossInfo.fightOver;
      }
      
      public function setCenter(param1:SceneCharacterEvent = null) : void
      {
         var _loc4_:* = NaN;
         var _loc3_:* = NaN;
         if(reference)
         {
            _loc4_ = Number(-(reference.x - 1000 / 2));
            _loc3_ = Number(-(reference.y - 600 / 2) + 50);
         }
         else
         {
            _loc4_ = Number(-(WorldBossManager.Instance.bossInfo.playerDefaultPos.x - 1000 / 2));
            _loc3_ = Number(-(WorldBossManager.Instance.bossInfo.playerDefaultPos.y - 600 / 2) + 50);
         }
         if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ < 1000 - _sceneMapVO.mapW)
         {
            _loc4_ = Number(1000 - _sceneMapVO.mapW);
         }
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < 600 - _sceneMapVO.mapH)
         {
            _loc3_ = Number(600 - _sceneMapVO.mapH);
         }
         x = _loc4_;
         y = _loc3_;
         var _loc2_:Point = this.globalToLocal(new Point(700,300));
         _worldboss_sky.x = _loc2_.x;
         _worldboss_sky.y = _loc2_.y;
      }
      
      public function addSelfPlayer() : void
      {
         var _loc1_:* = null;
         if(!selfPlayer)
         {
            _loc1_ = WorldBossManager.Instance.bossInfo.myPlayerVO;
            _loc1_.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new WorldRoomPlayer(_loc1_,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(param1:WorldRoomPlayer) : void
      {
         if(param1 == null)
         {
            if(reference)
            {
               reference.removeEventListener("characterMovement",setCenter);
               reference = null;
            }
            return;
         }
         if(reference)
         {
            reference.removeEventListener("characterMovement",setCenter);
         }
         reference = param1;
         reference.addEventListener("characterMovement",setCenter);
      }
      
      protected function __addPlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerVO = param1.data as PlayerVO;
         _currentLoadingPlayer = new WorldRoomPlayer(_loc2_,addPlayerCallBack);
         if(_loc2_.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            _currentLoadingPlayer.visible = _isShowOther;
         }
      }
      
      private function addPlayerCallBack(param1:WorldRoomPlayer, param2:Boolean, param3:int) : void
      {
         if(param3 == 0)
         {
            if(!articleLayer || !param1)
            {
               return;
            }
            _currentLoadingPlayer = null;
            param1.sceneScene = sceneScene;
            var _loc4_:* = param1.playerVO.scenePlayerDirection;
            param1.sceneCharacterDirection = _loc4_;
            param1.setSceneCharacterDirectionDefault = _loc4_;
            if(!selfPlayer && param1.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               param1.playerVO.playerPos = param1.playerVO.playerPos;
               selfPlayer = param1;
               articleLayer.addChild(selfPlayer);
               ajustScreen(selfPlayer);
               setCenter();
               if(selfPlayer.isInitialized)
               {
                  selfPlayer.setStatus();
               }
               selfPlayer.addEventListener("characterActionChange",playerActionChange);
            }
            else
            {
               articleLayer.addChild(param1);
            }
            param1.playerPoint = param1.playerVO.playerPos;
            param1.sceneCharacterStateType = "natural";
            _characters.add(param1.playerVO.playerInfo.ID,param1);
            param1.isShowName = _model.playerNameVisible;
            if(param1.playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               param1.visible = _isShowOther;
            }
         }
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "naturalStandFront" || _loc2_ == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
         }
      }
      
      protected function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:int = (param1.data as PlayerVO).playerInfo.ID;
         var _loc3_:WorldRoomPlayer = _characters[_loc2_] as WorldRoomPlayer;
         _characters.remove(_loc2_);
         if(_loc3_)
         {
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc3_.removeEventListener("characterMovement",setCenter);
            _loc3_.removeEventListener("characterActionChange",playerActionChange);
            _loc3_.dispose();
         }
         _loc3_ = null;
      }
      
      protected function BuildEntityDepth() : void
      {
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc8_:Number = NaN;
         var _loc7_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Number = NaN;
         var _loc2_:int = articleLayer.numChildren;
         _loc9_ = 0;
         while(_loc9_ < _loc2_ - 1)
         {
            _loc4_ = articleLayer.getChildAt(_loc9_);
            _loc8_ = this.getPointDepth(_loc4_.x,_loc4_.y);
            _loc5_ = 1.79769313486232e308;
            _loc6_ = _loc9_ + 1;
            while(_loc6_ < _loc2_)
            {
               _loc3_ = articleLayer.getChildAt(_loc6_);
               _loc1_ = this.getPointDepth(_loc3_.x,_loc3_.y);
               if(_loc1_ < _loc5_)
               {
                  _loc7_ = _loc6_;
                  _loc5_ = _loc1_;
               }
               _loc6_++;
            }
            if(_loc8_ > _loc5_)
            {
               articleLayer.swapChildrenAt(_loc9_,_loc7_);
            }
            _loc9_++;
         }
      }
      
      protected function getPointDepth(param1:Number, param2:Number) : Number
      {
         return sceneMapVO.mapW * param2 + param1;
      }
      
      protected function removeEvent() : void
      {
         _model.removeEventListener("playerNameVisible",menuChange);
         _model.removeEventListener("playerChatBallVisible",menuChange);
         removeEventListener("click",__click);
         removeEventListener("enterFrame",updateMap);
         _data.removeEventListener("add",__addPlayer);
         _data.removeEventListener("remove",__removePlayer);
         if(reference)
         {
            reference.removeEventListener("characterMovement",setCenter);
         }
         if(selfPlayer)
         {
            selfPlayer.removeEventListener("characterActionChange",playerActionChange);
         }
         WorldBossManager.Instance.removeEventListener("worldBossRoomFull",__onRoomFull);
         WorldBossManager.Instance.removeEventListener("stopFight",__stopFight);
         WorldBossManager.Instance.removeEventListener("startFight",__startFight);
         WorldBossManager.Instance.removeEventListener("worldBossHidePlayerChange",_hideOtherPlayer);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         removeEvent();
         _data.clear();
         _data = null;
         _sceneMapVO = null;
         var _loc5_:int = 0;
         var _loc4_:* = _characters;
         for each(var _loc2_ in _characters)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.removeEventListener("characterMovement",setCenter);
            _loc2_.removeEventListener("characterActionChange",playerActionChange);
            _loc2_.dispose();
            _loc2_ = null;
         }
         _characters.clear();
         _characters = null;
         if(articleLayer)
         {
            _loc3_ = articleLayer.numChildren;
            while(_loc3_ > 0)
            {
               _loc1_ = articleLayer.getChildAt(_loc3_ - 1) as WorldRoomPlayer;
               if(_loc1_)
               {
                  _loc1_.removeEventListener("characterMovement",setCenter);
                  _loc1_.removeEventListener("characterActionChange",playerActionChange);
                  if(_loc1_.parent)
                  {
                     _loc1_.parent.removeChild(_loc1_);
                  }
                  _loc1_.dispose();
               }
               _loc1_ = null;
               try
               {
                  articleLayer.removeChildAt(_loc3_ - 1);
               }
               catch(e:RangeError)
               {
                  trace(e);
               }
               _loc3_--;
            }
            if(articleLayer && articleLayer.parent)
            {
               articleLayer.parent.removeChild(articleLayer);
            }
         }
         articleLayer = null;
         if(selfPlayer)
         {
            selfPlayer.removeEventListener("characterArrivedNextStep",__arrive);
            if(selfPlayer.parent)
            {
               selfPlayer.parent.removeChild(selfPlayer);
            }
            selfPlayer.dispose();
         }
         selfPlayer = null;
         if(_currentLoadingPlayer)
         {
            if(_currentLoadingPlayer.parent)
            {
               _currentLoadingPlayer.parent.removeChild(_currentLoadingPlayer);
            }
            _currentLoadingPlayer.dispose();
         }
         _currentLoadingPlayer = null;
         if(_mouseMovie && _mouseMovie.parent)
         {
            _mouseMovie.parent.removeChild(_mouseMovie);
         }
         _mouseMovie = null;
         if(meshLayer && meshLayer.parent)
         {
            meshLayer.parent.removeChild(meshLayer);
         }
         meshLayer = null;
         if(bgLayer && bgLayer.parent)
         {
            bgLayer.parent.removeChild(bgLayer);
         }
         bgLayer = null;
         if(skyLayer && skyLayer.parent)
         {
            skyLayer.parent.removeChild(skyLayer);
         }
         skyLayer = null;
         sceneScene = null;
         disposeBeforeTimeView();
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
