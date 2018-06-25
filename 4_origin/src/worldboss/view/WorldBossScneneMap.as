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
      
      public function WorldBossScneneMap(model:WorldBossRoomModel, sceneScene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null, decoration:Sprite = null)
      {
         super();
         _model = model;
         this.sceneScene = sceneScene;
         this._data = data;
         if(bg == null)
         {
            this.bgLayer = new Sprite();
         }
         else
         {
            this.bgLayer = bg;
         }
         this.meshLayer = mesh == null?new Sprite():mesh;
         this.meshLayer.alpha = 0;
         this.articleLayer = acticle == null?new Sprite():acticle;
         this.decorationLayer = decoration == null?new Sprite():decoration;
         this.skyLayer = sky == null?new Sprite():sky;
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
         var tmpTime:int = WorldBossManager.Instance.beforeStartTime;
         if(tmpTime > 0)
         {
            hideBoss();
            _beforeTimeView = new WorldBossBeforeTimer(tmpTime);
            _beforeTimeView.addEventListener("complete",beforeTimeEndHandler,false,0,true);
            LayerManager.Instance.addToLayer(_beforeTimeView,3,true);
         }
      }
      
      private function beforeTimeEndHandler(event:Event) : void
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
      
      private function _enterWorldBossGame(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         if(autoMove || selfPlayer.playerVO.playerStauts != 1 || !selfPlayer.getCanAction() || _entering)
         {
            return;
         }
         CheckWeaponManager.instance.setFunction(this,_enterWorldBossGame,[e]);
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
         var k:Number = NaN;
         var disX:Number = selfPlayer.x - armyPos.x;
         var disY:Number = selfPlayer.y - armyPos.y;
         if(Math.pow(disX,2) + Math.pow(disY,2) > Math.pow(r,2))
         {
            k = Math.atan2(disY,disX);
            auto = new Point(armyPos.x,armyPos.y);
            auto.x = auto.x + (disX > 0?1:-1) * Math.abs(Math.cos(k) * r);
            auto.y = auto.y + (disY > 0?1:-1) * Math.abs(Math.sin(k) * r);
            return false;
         }
         return true;
      }
      
      private function checkCanStartGame() : Boolean
      {
         var result:Boolean = true;
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            result = false;
         }
         return result;
      }
      
      public function set enterIng(value:Boolean) : void
      {
         _entering = value;
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
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worldboss.tickets.propInfo",WorldBossManager.Instance.bossInfo.need_ticket_count),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onAlertResponse);
         switch(int(evt.responseCode))
         {
            case 0:
               alert.dispose();
               autoMove = false;
               break;
            default:
               alert.dispose();
               autoMove = false;
               break;
            default:
               alert.dispose();
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
               alert.dispose();
         }
      }
      
      private function startGame() : void
      {
         if(!WorldBossManager.Instance.isLoadingState)
         {
            SocketManager.Instance.out.createUserGuide(14);
         }
      }
      
      protected function __startFight(event:Event) : void
      {
         _isFight = true;
         selfPlayer.removeEventListener("characterArrivedNextStep",__arrive);
      }
      
      private function __stopFight(e:Event) : void
      {
         enterIng = false;
      }
      
      private function __arrive(e:SceneCharacterEvent) : void
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
      
      public function set sceneMapVO(value:SceneMapVO) : void
      {
         _sceneMapVO = value;
      }
      
      protected function init() : void
      {
         _characters = new DictionaryData(true);
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.worldboss.room.MouseClickMovie") as Class;
         _mouseMovie = new mvClass() as MovieClip;
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
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         __click(event.data[0]);
      }
      
      private function _hideOtherPlayer(event:WorldBossRoomEvent) : void
      {
         _isShowOther = event.data as Boolean;
         if(_characters)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _characters;
            for each(var worldRoomPlayer in _characters)
            {
               if(worldRoomPlayer.ID != PlayerManager.Instance.Self.ID)
               {
                  worldRoomPlayer.visible = _isShowOther;
               }
            }
         }
      }
      
      private function __onRoomFull(pEvent:WorldBossRoomEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worldboss.room.roomFull"),0,true);
         _entering = false;
      }
      
      private function menuChange(evt:WorldBossRoomEvent) : void
      {
         var _loc2_:* = evt.type;
         if("playerNameVisible" === _loc2_)
         {
            nameVisible();
         }
      }
      
      public function nameVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var worldRoomPlayer in _characters)
         {
            worldRoomPlayer.isShowName = _model.playerNameVisible;
         }
      }
      
      protected function updateMap(event:Event) : void
      {
         if(!_characters || _characters.length <= 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _characters;
         for each(var player in _characters)
         {
            player.updatePlayer();
            player.isShowName = _model.playerNameVisible;
         }
         BuildEntityDepth();
      }
      
      protected function __click(event:MouseEvent) : void
      {
         if(!selfPlayer || selfPlayer.playerVO.playerStauts != 1 || !selfPlayer.getCanAction())
         {
            return;
         }
         var targetPoint:Point = this.globalToLocal(new Point(event.stageX,event.stageY));
         autoMove = false;
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!sceneScene.hit(targetPoint))
            {
               selfPlayer.playerVO.walkPath = sceneScene.searchPath(selfPlayer.playerPoint,targetPoint);
               selfPlayer.playerVO.walkPath.shift();
               selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(selfPlayer.playerPoint,selfPlayer.playerVO.walkPath[0]);
               selfPlayer.playerVO.currentWalkStartPoint = selfPlayer.currentWalkStartPoint;
               sendMyPosition(selfPlayer.playerVO.walkPath.concat());
               _mouseMovie.x = targetPoint.x;
               _mouseMovie.y = targetPoint.y;
               _mouseMovie.play();
            }
         }
      }
      
      public function sendMyPosition(p:Array) : void
      {
         var i:int = 0;
         var arr:Array = [];
         while(i < p.length)
         {
            arr.push(int(p[i].x),int(p[i].y));
            i++;
         }
         var pathStr:String = arr.toString();
         SocketManager.Instance.out.sendWorldBossRoomMove(p[p.length - 1].x,p[p.length - 1].y,pathStr);
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         var worldRoomPlayer:* = null;
         if(_characters[id])
         {
            worldRoomPlayer = _characters[id] as WorldRoomPlayer;
            if(!worldRoomPlayer.getCanAction())
            {
               worldRoomPlayer.playerVO.playerStauts = 1;
               worldRoomPlayer.setStatus();
            }
            worldRoomPlayer.playerVO.walkPath = p;
            worldRoomPlayer.playerWalk(p);
         }
      }
      
      public function updatePlayersStauts(id:int, stauts:int, point:Point) : void
      {
         var worldRoomPlayer:* = null;
         if(_characters[id])
         {
            worldRoomPlayer = _characters[id] as WorldRoomPlayer;
            if(stauts == 1 && worldRoomPlayer.playerVO.playerStauts == 3)
            {
               worldRoomPlayer.playerVO.playerStauts = stauts;
               worldRoomPlayer.playerVO.playerPos = WorldBossManager.Instance.bossInfo.playerDefaultPos;
               worldRoomPlayer.setStatus();
            }
            else if(stauts == 2)
            {
               if(!worldRoomPlayer.getCanAction())
               {
                  worldRoomPlayer.playerVO.playerStauts = 1;
                  worldRoomPlayer.setStatus();
               }
               worldRoomPlayer.playerVO.playerStauts = stauts;
               worldRoomPlayer.isReadyFight = true;
               worldRoomPlayer.addEventListener("readyFight",__otherPlayrStartFight);
               worldRoomPlayer.playerVO.walkPath = [point];
               worldRoomPlayer.playerWalk([point]);
            }
            else
            {
               worldRoomPlayer.playerVO.playerStauts = stauts;
               worldRoomPlayer.setStatus();
            }
         }
      }
      
      public function __otherPlayrStartFight(evt:WorldBossRoomEvent) : void
      {
         var worldRoomPlayer:WorldRoomPlayer = evt.currentTarget as WorldRoomPlayer;
         worldRoomPlayer.removeEventListener("readyFight",__otherPlayrStartFight);
         worldRoomPlayer.sceneCharacterDirection = SceneCharacterDirection.getDirection(worldRoomPlayer.playerPoint,armyPos);
         worldRoomPlayer.dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         worldRoomPlayer.isReadyFight = false;
         worldRoomPlayer.setStatus();
      }
      
      public function updateSelfStatus(value:int) : void
      {
         if(selfPlayer.playerVO.playerStauts == 3)
         {
            selfPlayer.playerVO.playerPos = WorldBossManager.Instance.bossInfo.playerDefaultPos;
            ajustScreen(selfPlayer);
            setCenter();
            _entering = false;
         }
         selfPlayer.playerVO.playerStauts = value;
         selfPlayer.setStatus();
         SocketManager.Instance.out.sendWorldBossRoomStauts(value);
         checkGameOver();
      }
      
      public function checkSelfStatus() : int
      {
         return selfPlayer.playerVO.playerStauts;
      }
      
      public function playerRevive(id:int) : void
      {
         var worldRoomPlayer:* = null;
         if(_characters[id])
         {
            worldRoomPlayer = _characters[id] as WorldRoomPlayer;
            worldRoomPlayer.revive();
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
      
      public function setCenter(event:SceneCharacterEvent = null) : void
      {
         var xf:* = NaN;
         var yf:* = NaN;
         if(reference)
         {
            xf = Number(-(reference.x - 1000 / 2));
            yf = Number(-(reference.y - 600 / 2) + 50);
         }
         else
         {
            xf = Number(-(WorldBossManager.Instance.bossInfo.playerDefaultPos.x - 1000 / 2));
            yf = Number(-(WorldBossManager.Instance.bossInfo.playerDefaultPos.y - 600 / 2) + 50);
         }
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - _sceneMapVO.mapW)
         {
            xf = Number(1000 - _sceneMapVO.mapW);
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < 600 - _sceneMapVO.mapH)
         {
            yf = Number(600 - _sceneMapVO.mapH);
         }
         x = xf;
         y = yf;
         var point:Point = this.globalToLocal(new Point(700,300));
         _worldboss_sky.x = point.x;
         _worldboss_sky.y = point.y;
      }
      
      public function addSelfPlayer() : void
      {
         var selfPlayerVO:* = null;
         if(!selfPlayer)
         {
            selfPlayerVO = WorldBossManager.Instance.bossInfo.myPlayerVO;
            selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new WorldRoomPlayer(selfPlayerVO,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(worldRoomPlayer:WorldRoomPlayer) : void
      {
         if(worldRoomPlayer == null)
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
         reference = worldRoomPlayer;
         reference.addEventListener("characterMovement",setCenter);
      }
      
      protected function __addPlayer(event:DictionaryEvent) : void
      {
         var playerVO:PlayerVO = event.data as PlayerVO;
         _currentLoadingPlayer = new WorldRoomPlayer(playerVO,addPlayerCallBack);
         if(playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID)
         {
            _currentLoadingPlayer.visible = _isShowOther;
         }
      }
      
      private function addPlayerCallBack(worldRoomPlayer:WorldRoomPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!articleLayer || !worldRoomPlayer)
            {
               return;
            }
            _currentLoadingPlayer = null;
            worldRoomPlayer.sceneScene = sceneScene;
            var _loc4_:* = worldRoomPlayer.playerVO.scenePlayerDirection;
            worldRoomPlayer.sceneCharacterDirection = _loc4_;
            worldRoomPlayer.setSceneCharacterDirectionDefault = _loc4_;
            if(!selfPlayer && worldRoomPlayer.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               worldRoomPlayer.playerVO.playerPos = worldRoomPlayer.playerVO.playerPos;
               selfPlayer = worldRoomPlayer;
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
               articleLayer.addChild(worldRoomPlayer);
            }
            worldRoomPlayer.playerPoint = worldRoomPlayer.playerVO.playerPos;
            worldRoomPlayer.sceneCharacterStateType = "natural";
            _characters.add(worldRoomPlayer.playerVO.playerInfo.ID,worldRoomPlayer);
            worldRoomPlayer.isShowName = _model.playerNameVisible;
            if(worldRoomPlayer.playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               worldRoomPlayer.visible = _isShowOther;
            }
         }
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var type:String = evt.data.toString();
         if(type == "naturalStandFront" || type == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
         }
      }
      
      protected function __removePlayer(event:DictionaryEvent) : void
      {
         var id:int = (event.data as PlayerVO).playerInfo.ID;
         var player:WorldRoomPlayer = _characters[id] as WorldRoomPlayer;
         _characters.remove(id);
         if(player)
         {
            if(player.parent)
            {
               player.parent.removeChild(player);
            }
            player.removeEventListener("characterMovement",setCenter);
            player.removeEventListener("characterActionChange",playerActionChange);
            player.dispose();
         }
         player = null;
      }
      
      protected function BuildEntityDepth() : void
      {
         var i:int = 0;
         var obj:* = null;
         var depth:Number = NaN;
         var minIndex:* = 0;
         var minDepth:* = NaN;
         var j:int = 0;
         var temp:* = null;
         var tempDepth:Number = NaN;
         var count:int = articleLayer.numChildren;
         for(i = 0; i < count - 1; )
         {
            obj = articleLayer.getChildAt(i);
            depth = this.getPointDepth(obj.x,obj.y);
            minDepth = 1.79769313486232e308;
            for(j = i + 1; j < count; )
            {
               temp = articleLayer.getChildAt(j);
               tempDepth = this.getPointDepth(temp.x,temp.y);
               if(tempDepth < minDepth)
               {
                  minIndex = j;
                  minDepth = tempDepth;
               }
               j++;
            }
            if(depth > minDepth)
            {
               articleLayer.swapChildrenAt(i,minIndex);
            }
            i++;
         }
      }
      
      protected function getPointDepth(x:Number, y:Number) : Number
      {
         return sceneMapVO.mapW * y + x;
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
         var i:int = 0;
         var player:* = null;
         removeEvent();
         _data.clear();
         _data = null;
         _sceneMapVO = null;
         var _loc5_:int = 0;
         var _loc4_:* = _characters;
         for each(var p in _characters)
         {
            if(p.parent)
            {
               p.parent.removeChild(p);
            }
            p.removeEventListener("characterMovement",setCenter);
            p.removeEventListener("characterActionChange",playerActionChange);
            p.dispose();
            p = null;
         }
         _characters.clear();
         _characters = null;
         if(articleLayer)
         {
            for(i = articleLayer.numChildren; i > 0; )
            {
               player = articleLayer.getChildAt(i - 1) as WorldRoomPlayer;
               if(player)
               {
                  player.removeEventListener("characterMovement",setCenter);
                  player.removeEventListener("characterActionChange",playerActionChange);
                  if(player.parent)
                  {
                     player.parent.removeChild(player);
                  }
                  player.dispose();
               }
               player = null;
               try
               {
                  articleLayer.removeChildAt(i - 1);
               }
               catch(e:RangeError)
               {
                  trace(e);
               }
               i--;
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
