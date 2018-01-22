package christmas.view.playingSnowman
{
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.event.ChristmasRoomEvent;
   import christmas.info.MonsterInfo;
   import christmas.manager.ChristmasMonsterManager;
   import christmas.model.ChristmasRoomModel;
   import christmas.player.ChristmasMonster;
   import christmas.player.ChristmasRoomPlayer;
   import christmas.player.PlayerVO;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class ChristmasScneneMap extends Sprite implements Disposeable
   {
      
      private static var selectSpeek:int = 1;
      
      public static var packsNum:int = 2;
       
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      protected var snowLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      public var selfPlayer:ChristmasRoomPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _currentLoadingPlayer:ChristmasRoomPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:ChristmasRoomModel;
      
      private var armyPos:Point;
      
      private var decorationLayer:Sprite;
      
      protected var _mapObjs:DictionaryData;
      
      protected var _monsters:DictionaryData;
      
      private var _snowMC:MovieClip;
      
      private var _snowCenterMc:MovieClip;
      
      private var _snowSpeakPng:Bitmap;
      
      private var _snowSpeak:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _mouseMovie:MovieClip;
      
      private var r:int = 250;
      
      private var auto:Point;
      
      private var autoMove:Boolean = false;
      
      private var _entering:Boolean = false;
      
      private var _speakTimer:Timer;
      
      private var _timeFive:Timer;
      
      private var endPoint:Point;
      
      protected var reference:ChristmasRoomPlayer;
      
      public function ChristmasScneneMap(param1:ChristmasRoomModel, param2:SceneScene, param3:DictionaryData, param4:DictionaryData, param5:Sprite, param6:Sprite, param7:Sprite = null, param8:Sprite = null, param9:Sprite = null, param10:Sprite = null)
      {
         endPoint = new Point();
         super();
         _model = param1;
         this.sceneScene = param2;
         this._data = param3;
         this._mapObjs = param4;
         if(param5 == null)
         {
            this.bgLayer = new Sprite();
         }
         else
         {
            this.bgLayer = param5;
         }
         this.meshLayer = param6 == null?new Sprite():param6;
         this.meshLayer.alpha = 0;
         this.articleLayer = param7 == null?new Sprite():param7;
         this.decorationLayer = param9 == null?new Sprite():param9;
         this.skyLayer = param8 == null?new Sprite():param8;
         this.snowLayer = param10 == null?new Sprite():param10;
         var _loc11_:Boolean = false;
         this.decorationLayer.mouseEnabled = _loc11_;
         this.decorationLayer.mouseChildren = _loc11_;
         this.addChild(bgLayer);
         this.addChild(snowLayer);
         this.addChild(articleLayer);
         this.addChild(decorationLayer);
         this.addChild(meshLayer);
         this.addChild(skyLayer);
         init();
         addEvent();
         initSnow();
      }
      
      private function initSnow() : void
      {
         if(bgLayer != null && articleLayer != null)
         {
            _snowCenterMc = snowLayer.getChildByName("snowCenter_MC") as MovieClip;
            _snowCenterMc.visible = false;
            _snowCenterMc.buttonMode = false;
            _snowCenterMc.mouseEnabled = false;
            _snowCenterMc.mouseChildren = false;
            _snowCenterMc.gotoAndStop(1);
            _snowMC = skyLayer.getChildByName("snow_mc") as MovieClip;
            _snowMC.addEventListener("click",_enterSnowNPC);
            _snowMC.addEventListener("mouseOver",__onMouseOver);
            _snowMC.addEventListener("mouseOut",__onMouseOut);
            _snowMC.buttonMode = true;
         }
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         _snowCenterMc.visible = true;
         _snowCenterMc.gotoAndPlay(1);
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         _snowCenterMc.visible = false;
         _snowCenterMc.gotoAndStop(1);
      }
      
      private function _enterSnowNPC(param1:MouseEvent) : void
      {
         if(!isAwradActOpen())
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.notOpen",String(ServerConfigManager.instance.getChristmasGiftsGetTime()[0]) + ":" + String(ServerConfigManager.instance.getChristmasGiftsGetTime()[1])),null,null,this,false);
            return;
         }
         SocketManager.Instance.out.getPacksToPlayer(0);
      }
      
      private function isAwradActOpen() : Boolean
      {
         var _loc2_:int = ServerConfigManager.instance.getChristmasGiftsGetTime()[0];
         var _loc1_:int = ServerConfigManager.instance.getChristmasGiftsGetTime()[1];
         if(TimeManager.Instance.Now().hours < _loc2_)
         {
            return false;
         }
         if(TimeManager.Instance.Now().hours == _loc2_ && TimeManager.Instance.Now().minutes < _loc1_)
         {
            return false;
         }
         return true;
      }
      
      private function isPacksComplete(param1:int = 1) : void
      {
         SocketManager.Instance.out.getPacksToPlayer(1);
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
      
      public function set enterIng(param1:Boolean) : void
      {
         _entering = param1;
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
         _monsters = new DictionaryData(true);
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.christmas.room.MouseClickMovie") as Class;
         _mouseMovie = new _loc1_() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         bgLayer.addChild(_mouseMovie);
         _snowSpeakPng = ComponentFactory.Instance.creatBitmap("asset.christmas.room.snowSpeakImg");
         _snowSpeakPng.visible = false;
         _snowSpeak = ComponentFactory.Instance.creatComponentByStylename("christmas.room.snowSpeakTxt");
         _snowSpeak.visible = false;
         addChild(_snowSpeakPng);
         addChild(_snowSpeak);
         last_click = 0;
         if(bgLayer != null && articleLayer != null)
         {
            armyPos = new Point(bgLayer.getChildByName("armyPos").x,bgLayer.getChildByName("armyPos").y);
         }
         _speakTimer = new Timer(300000,0);
         _speakTimer.addEventListener("timer",__santaSpeakTimer);
         _speakTimer.start();
      }
      
      private function __santaSpeakTimer(param1:TimerEvent) : void
      {
         _timeFive = new Timer(1000,5);
         _timeFive.addEventListener("timer",__santaSpeakFiveSeconds);
         _timeFive.addEventListener("timerComplete",__santaSpeakFiveSecondsComplete);
         _timeFive.start();
      }
      
      private function __santaSpeakFiveSeconds(param1:TimerEvent) : void
      {
         if(selectSpeek % 2 == 0)
         {
            _snowSpeak.text = LanguageMgr.GetTranslation("christmas.room.santaSpeakFiveSecondsText");
         }
         else
         {
            _snowSpeak.text = LanguageMgr.GetTranslation("christmas.room.santaSpeakFiveSecondsText2");
         }
         _snowSpeak.text = LanguageMgr.GetTranslation("christmas.room.santaSpeakFiveSecondsText");
         _snowSpeakPng.visible = true;
         _snowSpeak.visible = true;
         selectSpeek = Number(selectSpeek) + 1;
      }
      
      public function stopAllTimer() : void
      {
         if(_timeFive)
         {
            _timeFive.stop();
            _timeFive.removeEventListener("timer",__santaSpeakFiveSeconds);
            _timeFive.removeEventListener("timerComplete",__santaSpeakFiveSecondsComplete);
         }
         if(_speakTimer)
         {
            _speakTimer.stop();
            _speakTimer.removeEventListener("timer",__santaSpeakTimer);
         }
      }
      
      private function __santaSpeakFiveSecondsComplete(param1:TimerEvent) : void
      {
         (param1.target as Timer).removeEventListener("timer",__santaSpeakFiveSeconds);
         (param1.target as Timer).removeEventListener("timerComplete",__santaSpeakFiveSecondsComplete);
         (param1.target as Timer).stop();
         _snowSpeakPng.visible = false;
         _snowSpeak.visible = false;
      }
      
      protected function addEvent() : void
      {
         _model.addEventListener("playerNameVisible",menuChange);
         _model.addEventListener("playerChatBallVisible",menuChange);
         addEventListener("click",__click);
         addEventListener("enterFrame",updateMap);
         _data.addEventListener("add",__addPlayer);
         _data.addEventListener("remove",__removePlayer);
         _mapObjs.addEventListener("add",__addMonster);
         _mapObjs.addEventListener("remove",__removeMonster);
         _mapObjs.addEventListener("update",__onMonsterUpdate);
         ChristmasCoreManager.instance.addEventListener("getpackstoplayer",__getPacks);
         ChristmasCoreManager.instance.addEventListener("christmas_room_speak",__snowSpeak);
      }
      
      private function __getPacks(param1:CrazyTankSocketEvent) : void
      {
         var _loc8_:PackageIn = param1.pkg;
         var _loc7_:Boolean = _loc8_.readBoolean();
         var _loc6_:int = _loc8_.readInt();
         var _loc5_:int = _loc8_.readInt();
         var _loc4_:int = _loc8_.readInt();
         var _loc2_:int = _loc5_ - _loc4_;
         if(_loc6_ >= 2)
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.full"),null,null,this,false);
            return;
         }
         var _loc3_:Array = ChristmasCoreManager.instance.model.serverTime();
         if(_loc3_[0] < ServerConfigManager.instance.getChristmasGiftsGetTime()[0] || _loc3_[0] == ServerConfigManager.instance.getChristmasGiftsGetTime()[0] && _loc3_[1] < ServerConfigManager.instance.getChristmasGiftsGetTime()[1])
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.unfinished2",String(ServerConfigManager.instance.getChristmasGiftsGetTime()[0]) + ":" + String(ServerConfigManager.instance.getChristmasGiftsGetTime()[1])),null,null,this,false);
            return;
         }
         if(_loc4_ < _loc5_ && _loc7_ && (_loc3_[0] > ServerConfigManager.instance.getChristmasGiftsGetTime()[0] || _loc3_[0] == ServerConfigManager.instance.getChristmasGiftsGetTime()[0] && _loc3_[1] >= ServerConfigManager.instance.getChristmasGiftsGetTime()[1]))
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.unfinished",packsNum < 0?0:packsNum),null,null,this,false);
            return;
         }
         if(!_loc7_)
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.room.packs.isFull"),null,null,this,false);
            return;
         }
         if(_loc4_ >= _loc5_ && _loc7_ && (_loc3_[0] > ServerConfigManager.instance.getChristmasGiftsGetTime()[0] || _loc3_[0] == ServerConfigManager.instance.getChristmasGiftsGetTime()[0] && _loc3_[1] >= ServerConfigManager.instance.getChristmasGiftsGetTime()[1]))
         {
            packsNum = Number(packsNum) - 1;
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.complete",_loc2_.toString()),isPacksComplete,null,this,false);
            return;
         }
      }
      
      private function __addMonster(param1:DictionaryEvent) : void
      {
         var _loc2_:MonsterInfo = param1.data as MonsterInfo;
         var _loc3_:ChristmasMonster = new ChristmasMonster(_loc2_,_loc2_.MonsterPos);
         _monsters.add(_loc2_.ID,_loc3_);
         articleLayer.addChild(_loc3_);
      }
      
      private function __removeMonster(param1:DictionaryEvent) : void
      {
         var _loc3_:MonsterInfo = param1.data as MonsterInfo;
         var _loc2_:ChristmasMonster = _monsters[_loc3_.ID] as ChristmasMonster;
         _monsters.remove(_loc3_.ID);
         _loc2_.dispose();
      }
      
      private function __onMonsterUpdate(param1:DictionaryEvent) : void
      {
         var _loc3_:MonsterInfo = param1.data as MonsterInfo;
         var _loc2_:ChristmasMonster = _monsters[_loc3_.ID] as ChristmasMonster;
      }
      
      private function __snowSpeak(param1:CrazyTankSocketEvent) : void
      {
         _timer = new Timer(1000,10);
         _timer.addEventListener("timer",__timeShowSnowSpeak);
         _timer.addEventListener("timerComplete",__timeSnowSpeakComplete);
         _timer.start();
      }
      
      private function __timeShowSnowSpeak(param1:TimerEvent) : void
      {
         _snowSpeak.text = LanguageMgr.GetTranslation("christmas.room.snowSpeakText");
         _snowSpeakPng.visible = true;
         _snowSpeak.visible = true;
      }
      
      private function __timeSnowSpeakComplete(param1:TimerEvent) : void
      {
         _timer.removeEventListener("timer",__timeShowSnowSpeak);
         _timer.removeEventListener("timerComplete",__timeSnowSpeakComplete);
         _timer.stop();
         _snowSpeakPng.visible = false;
         _snowSpeak.visible = false;
      }
      
      private function menuChange(param1:ChristmasRoomEvent) : void
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
         if(!selfPlayer || selfPlayer.playerVO.playerStauts != 0 || !selfPlayer.getCanAction())
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
         SocketManager.Instance.out.sendChristmasRoomMove(param1[param1.length - 1].x,param1[param1.length - 1].y,_loc3_);
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         var _loc3_:* = null;
         if(_characters[param1])
         {
            _loc3_ = _characters[param1] as ChristmasRoomPlayer;
            if(!_loc3_.getCanAction())
            {
               _loc3_.playerVO.playerStauts = 0;
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
            _loc4_ = _characters[param1] as ChristmasRoomPlayer;
            if(param2 == 0)
            {
               _loc4_.playerVO.playerStauts = param2;
               _loc4_.playerVO.playerPos = param3;
               _loc4_.setStatus();
            }
            else if(param2 == 1)
            {
               if(!_loc4_.getCanAction())
               {
                  _loc4_.playerVO.playerStauts = 0;
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
      
      public function __otherPlayrStartFight(param1:ChristmasRoomEvent) : void
      {
         var _loc2_:ChristmasRoomPlayer = param1.currentTarget as ChristmasRoomPlayer;
         _loc2_.removeEventListener("readyFight",__otherPlayrStartFight);
         _loc2_.sceneCharacterDirection = SceneCharacterDirection.getDirection(_loc2_.playerPoint,armyPos);
         _loc2_.dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         _loc2_.isReadyFight = false;
         _loc2_.setStatus();
      }
      
      public function updateSelfStatus(param1:int) : void
      {
         if(selfPlayer)
         {
            if(selfPlayer.playerVO.playerStauts == 2)
            {
               selfPlayer.playerVO.playerPos = ChristmasCoreController.instance.christmasInfo.playerDefaultPos;
               ajustScreen(selfPlayer);
               setCenter();
               _entering = false;
            }
            selfPlayer.playerVO.playerStauts = param1;
            selfPlayer.setStatus();
         }
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
            _loc2_ = _characters[param1] as ChristmasRoomPlayer;
            _loc2_.revive();
            selfPlayer.playerVO.playerStauts = 0;
            _entering = false;
         }
      }
      
      public function setCenter(param1:SceneCharacterEvent = null) : void
      {
         var _loc3_:* = NaN;
         var _loc2_:* = NaN;
         if(reference)
         {
            _loc3_ = Number(-(reference.x - 1000 / 2));
            _loc2_ = Number(-(reference.y - 600 / 2) + 50);
         }
         else
         {
            _loc3_ = Number(-(ChristmasCoreController.instance.christmasInfo.playerDefaultPos.x - 1000 / 2));
            _loc2_ = Number(-(ChristmasCoreController.instance.christmasInfo.playerDefaultPos.y - 600 / 2) + 50);
         }
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < 1000 - _sceneMapVO.mapW)
         {
            _loc3_ = Number(1000 - _sceneMapVO.mapW);
         }
         if(_loc2_ > 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ < 600 - _sceneMapVO.mapH)
         {
            _loc2_ = Number(600 - _sceneMapVO.mapH);
         }
         x = _loc3_;
         y = _loc2_;
      }
      
      public function addSelfPlayer() : void
      {
         var _loc1_:* = null;
         if(!selfPlayer)
         {
            _loc1_ = ChristmasCoreController.instance.christmasInfo.myPlayerVO;
            _loc1_.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new ChristmasRoomPlayer(_loc1_,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(param1:ChristmasRoomPlayer) : void
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
         _currentLoadingPlayer = new ChristmasRoomPlayer(_loc2_,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(param1:ChristmasRoomPlayer, param2:Boolean, param3:int) : void
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
               selfPlayer.setStatus();
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
         }
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:String = param1.data.toString();
         if(_loc3_ == "naturalStandFront" || _loc3_ == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
            _loc2_ = ChristmasMonsterManager.Instance.curMonster;
            if(_loc2_ && _loc2_.MonsterState <= 0)
            {
               _loc4_ = this.localToGlobal(new Point(selfPlayer.playerPoint.x,selfPlayer.playerPoint.y + 50));
               if(_loc2_.hitTestPoint(_loc4_.x,_loc4_.y) || _loc2_.hitTestObject(selfPlayer))
               {
                  _loc2_.StartFight();
               }
            }
         }
      }
      
      protected function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:int = (param1.data as PlayerVO).playerInfo.ID;
         var _loc3_:ChristmasRoomPlayer = _characters[_loc2_] as ChristmasRoomPlayer;
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
         _mapObjs.removeEventListener("add",__addMonster);
         _mapObjs.removeEventListener("remove",__removeMonster);
         _mapObjs.removeEventListener("update",__onMonsterUpdate);
         if(reference)
         {
            reference.removeEventListener("characterMovement",setCenter);
         }
         if(selfPlayer)
         {
            selfPlayer.removeEventListener("characterActionChange",playerActionChange);
         }
         _snowMC.removeEventListener("click",_enterSnowNPC);
         ChristmasCoreManager.instance.removeEventListener("getpackstoplayer",__getPacks);
         ChristmasCoreManager.instance.removeEventListener("christmas_room_speak",__snowSpeak);
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         removeEvent();
         if(_mapObjs)
         {
            _mapObjs.clear();
            _mapObjs = null;
         }
         if(_data)
         {
            _data.clear();
            _data = null;
         }
         _sceneMapVO = null;
         var _loc6_:int = 0;
         var _loc5_:* = _characters;
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
            _loc4_ = articleLayer.numChildren;
            while(_loc4_ > 0)
            {
               _loc1_ = articleLayer.getChildAt(_loc4_ - 1) as ChristmasRoomPlayer;
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
                  articleLayer.removeChildAt(_loc4_ - 1);
               }
               catch(e:RangeError)
               {
                  trace(e);
               }
               _loc4_--;
            }
            if(articleLayer && articleLayer.parent)
            {
               articleLayer.parent.removeChild(articleLayer);
            }
         }
         articleLayer = null;
         if(selfPlayer)
         {
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
         var _loc8_:int = 0;
         var _loc7_:* = _monsters;
         for each(var _loc3_ in _monsters)
         {
            _loc3_.dispose();
            _loc3_ = null;
         }
         _monsters.clear();
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
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
