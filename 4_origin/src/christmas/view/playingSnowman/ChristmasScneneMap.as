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
      
      public function ChristmasScneneMap(model:ChristmasRoomModel, sceneScene:SceneScene, data:DictionaryData, objData:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null, decoration:Sprite = null, snow:Sprite = null)
      {
         endPoint = new Point();
         super();
         _model = model;
         this.sceneScene = sceneScene;
         this._data = data;
         this._mapObjs = objData;
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
         this.snowLayer = snow == null?new Sprite():snow;
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
      
      private function __onMouseOver(e:MouseEvent) : void
      {
         _snowCenterMc.visible = true;
         _snowCenterMc.gotoAndPlay(1);
      }
      
      private function __onMouseOut(e:MouseEvent) : void
      {
         _snowCenterMc.visible = false;
         _snowCenterMc.gotoAndStop(1);
      }
      
      private function _enterSnowNPC(e:MouseEvent) : void
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
         var hour:int = ServerConfigManager.instance.getChristmasGiftsGetTime()[0];
         var minute:int = ServerConfigManager.instance.getChristmasGiftsGetTime()[1];
         if(TimeManager.Instance.Now().hours < hour)
         {
            return false;
         }
         if(TimeManager.Instance.Now().hours == hour && TimeManager.Instance.Now().minutes < minute)
         {
            return false;
         }
         return true;
      }
      
      private function isPacksComplete(num:int = 1) : void
      {
         SocketManager.Instance.out.getPacksToPlayer(1);
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
      
      public function set enterIng(value:Boolean) : void
      {
         _entering = value;
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
         _monsters = new DictionaryData(true);
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.christmas.room.MouseClickMovie") as Class;
         _mouseMovie = new mvClass() as MovieClip;
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
      
      private function __santaSpeakTimer(e:TimerEvent) : void
      {
         _timeFive = new Timer(1000,5);
         _timeFive.addEventListener("timer",__santaSpeakFiveSeconds);
         _timeFive.addEventListener("timerComplete",__santaSpeakFiveSecondsComplete);
         _timeFive.start();
      }
      
      private function __santaSpeakFiveSeconds(e:TimerEvent) : void
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
      
      private function __santaSpeakFiveSecondsComplete(e:TimerEvent) : void
      {
         (e.target as Timer).removeEventListener("timer",__santaSpeakFiveSeconds);
         (e.target as Timer).removeEventListener("timerComplete",__santaSpeakFiveSecondsComplete);
         (e.target as Timer).stop();
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
      
      private function __getPacks(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var packsCount:Boolean = pkg.readBoolean();
         var indexPacks:int = pkg.readInt();
         var totalCount:int = pkg.readInt();
         var count:int = pkg.readInt();
         var poorCount:int = totalCount - count;
         if(indexPacks >= 2)
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.full"),null,null,this,false);
            return;
         }
         var serTime:Array = ChristmasCoreManager.instance.model.serverTime();
         if(serTime[0] < ServerConfigManager.instance.getChristmasGiftsGetTime()[0] || serTime[0] == ServerConfigManager.instance.getChristmasGiftsGetTime()[0] && serTime[1] < ServerConfigManager.instance.getChristmasGiftsGetTime()[1])
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.unfinished2",String(ServerConfigManager.instance.getChristmasGiftsGetTime()[0]) + ":" + String(ServerConfigManager.instance.getChristmasGiftsGetTime()[1])),null,null,this,false);
            return;
         }
         if(count < totalCount && packsCount && (serTime[0] > ServerConfigManager.instance.getChristmasGiftsGetTime()[0] || serTime[0] == ServerConfigManager.instance.getChristmasGiftsGetTime()[0] && serTime[1] >= ServerConfigManager.instance.getChristmasGiftsGetTime()[1]))
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.unfinished",packsNum < 0?0:packsNum),null,null,this,false);
            return;
         }
         if(!packsCount)
         {
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.room.packs.isFull"),null,null,this,false);
            return;
         }
         if(count >= totalCount && packsCount && (serTime[0] > ServerConfigManager.instance.getChristmasGiftsGetTime()[0] || serTime[0] == ServerConfigManager.instance.getChristmasGiftsGetTime()[0] && serTime[1] >= ServerConfigManager.instance.getChristmasGiftsGetTime()[1]))
         {
            packsNum = Number(packsNum) - 1;
            ChristmasCoreController.instance.showTransactionFrame(LanguageMgr.GetTranslation("christmas.snowPacks.complete",poorCount.toString()),isPacksComplete,null,this,false);
            return;
         }
      }
      
      private function __addMonster(pEvent:DictionaryEvent) : void
      {
         var monster:MonsterInfo = pEvent.data as MonsterInfo;
         var cMonster:ChristmasMonster = new ChristmasMonster(monster,monster.MonsterPos);
         _monsters.add(monster.ID,cMonster);
         articleLayer.addChild(cMonster);
      }
      
      private function __removeMonster(pEvent:DictionaryEvent) : void
      {
         var monsterInfo:MonsterInfo = pEvent.data as MonsterInfo;
         var monster:ChristmasMonster = _monsters[monsterInfo.ID] as ChristmasMonster;
         _monsters.remove(monsterInfo.ID);
         monster.dispose();
      }
      
      private function __onMonsterUpdate(pEvent:DictionaryEvent) : void
      {
         var monsterInfo:MonsterInfo = pEvent.data as MonsterInfo;
         var monster:ChristmasMonster = _monsters[monsterInfo.ID] as ChristmasMonster;
      }
      
      private function __snowSpeak(event:CrazyTankSocketEvent) : void
      {
         _timer = new Timer(1000,10);
         _timer.addEventListener("timer",__timeShowSnowSpeak);
         _timer.addEventListener("timerComplete",__timeSnowSpeakComplete);
         _timer.start();
      }
      
      private function __timeShowSnowSpeak(event:TimerEvent) : void
      {
         _snowSpeak.text = LanguageMgr.GetTranslation("christmas.room.snowSpeakText");
         _snowSpeakPng.visible = true;
         _snowSpeak.visible = true;
      }
      
      private function __timeSnowSpeakComplete(event:TimerEvent) : void
      {
         _timer.removeEventListener("timer",__timeShowSnowSpeak);
         _timer.removeEventListener("timerComplete",__timeSnowSpeakComplete);
         _timer.stop();
         _snowSpeakPng.visible = false;
         _snowSpeak.visible = false;
      }
      
      private function menuChange(evt:ChristmasRoomEvent) : void
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
         for each(var christmasRoomPlayer in _characters)
         {
            christmasRoomPlayer.isShowName = _model.playerNameVisible;
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
         if(!selfPlayer || selfPlayer.playerVO.playerStauts != 0 || !selfPlayer.getCanAction())
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
         SocketManager.Instance.out.sendChristmasRoomMove(p[p.length - 1].x,p[p.length - 1].y,pathStr);
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         var christmasRoomPlayer:* = null;
         if(_characters[id])
         {
            christmasRoomPlayer = _characters[id] as ChristmasRoomPlayer;
            if(!christmasRoomPlayer.getCanAction())
            {
               christmasRoomPlayer.playerVO.playerStauts = 0;
               christmasRoomPlayer.setStatus();
            }
            christmasRoomPlayer.playerVO.walkPath = p;
            christmasRoomPlayer.playerWalk(p);
         }
      }
      
      public function updatePlayersStauts(id:int, stauts:int, point:Point) : void
      {
         var christmasRoomPlayer:* = null;
         if(_characters[id])
         {
            christmasRoomPlayer = _characters[id] as ChristmasRoomPlayer;
            if(stauts == 0)
            {
               christmasRoomPlayer.playerVO.playerStauts = stauts;
               christmasRoomPlayer.playerVO.playerPos = point;
               christmasRoomPlayer.setStatus();
            }
            else if(stauts == 1)
            {
               if(!christmasRoomPlayer.getCanAction())
               {
                  christmasRoomPlayer.playerVO.playerStauts = 0;
                  christmasRoomPlayer.setStatus();
               }
               christmasRoomPlayer.playerVO.playerStauts = stauts;
               christmasRoomPlayer.isReadyFight = true;
               christmasRoomPlayer.addEventListener("readyFight",__otherPlayrStartFight);
               christmasRoomPlayer.playerVO.walkPath = [point];
               christmasRoomPlayer.playerWalk([point]);
            }
            else
            {
               christmasRoomPlayer.playerVO.playerStauts = stauts;
               christmasRoomPlayer.setStatus();
            }
         }
      }
      
      public function __otherPlayrStartFight(evt:ChristmasRoomEvent) : void
      {
         var christmasRoomPlayer:ChristmasRoomPlayer = evt.currentTarget as ChristmasRoomPlayer;
         christmasRoomPlayer.removeEventListener("readyFight",__otherPlayrStartFight);
         christmasRoomPlayer.sceneCharacterDirection = SceneCharacterDirection.getDirection(christmasRoomPlayer.playerPoint,armyPos);
         christmasRoomPlayer.dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         christmasRoomPlayer.isReadyFight = false;
         christmasRoomPlayer.setStatus();
      }
      
      public function updateSelfStatus(value:int) : void
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
            selfPlayer.playerVO.playerStauts = value;
            selfPlayer.setStatus();
         }
      }
      
      public function checkSelfStatus() : int
      {
         return selfPlayer.playerVO.playerStauts;
      }
      
      public function playerRevive(id:int) : void
      {
         var christmasRoomPlayer:* = null;
         if(_characters[id])
         {
            christmasRoomPlayer = _characters[id] as ChristmasRoomPlayer;
            christmasRoomPlayer.revive();
            selfPlayer.playerVO.playerStauts = 0;
            _entering = false;
         }
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
            xf = Number(-(ChristmasCoreController.instance.christmasInfo.playerDefaultPos.x - 1000 / 2));
            yf = Number(-(ChristmasCoreController.instance.christmasInfo.playerDefaultPos.y - 600 / 2) + 50);
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
      }
      
      public function addSelfPlayer() : void
      {
         var selfPlayerVO:* = null;
         if(!selfPlayer)
         {
            selfPlayerVO = ChristmasCoreController.instance.christmasInfo.myPlayerVO;
            selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new ChristmasRoomPlayer(selfPlayerVO,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(christmasRoomPlayer:ChristmasRoomPlayer) : void
      {
         if(christmasRoomPlayer == null)
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
         reference = christmasRoomPlayer;
         reference.addEventListener("characterMovement",setCenter);
      }
      
      protected function __addPlayer(event:DictionaryEvent) : void
      {
         var playerVO:PlayerVO = event.data as PlayerVO;
         _currentLoadingPlayer = new ChristmasRoomPlayer(playerVO,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(christmasRoomPlayer:ChristmasRoomPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!articleLayer || !christmasRoomPlayer)
            {
               return;
            }
            _currentLoadingPlayer = null;
            christmasRoomPlayer.sceneScene = sceneScene;
            var _loc4_:* = christmasRoomPlayer.playerVO.scenePlayerDirection;
            christmasRoomPlayer.sceneCharacterDirection = _loc4_;
            christmasRoomPlayer.setSceneCharacterDirectionDefault = _loc4_;
            if(!selfPlayer && christmasRoomPlayer.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               christmasRoomPlayer.playerVO.playerPos = christmasRoomPlayer.playerVO.playerPos;
               selfPlayer = christmasRoomPlayer;
               articleLayer.addChild(selfPlayer);
               ajustScreen(selfPlayer);
               setCenter();
               selfPlayer.setStatus();
               selfPlayer.addEventListener("characterActionChange",playerActionChange);
            }
            else
            {
               articleLayer.addChild(christmasRoomPlayer);
            }
            christmasRoomPlayer.playerPoint = christmasRoomPlayer.playerVO.playerPos;
            christmasRoomPlayer.sceneCharacterStateType = "natural";
            _characters.add(christmasRoomPlayer.playerVO.playerInfo.ID,christmasRoomPlayer);
            christmasRoomPlayer.isShowName = _model.playerNameVisible;
         }
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var mon:* = null;
         var pos:* = null;
         var type:String = evt.data.toString();
         if(type == "naturalStandFront" || type == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
            mon = ChristmasMonsterManager.Instance.curMonster;
            if(mon && mon.MonsterState <= 0)
            {
               pos = this.localToGlobal(new Point(selfPlayer.playerPoint.x,selfPlayer.playerPoint.y + 50));
               if(mon.hitTestPoint(pos.x,pos.y) || mon.hitTestObject(selfPlayer))
               {
                  mon.StartFight();
               }
            }
         }
      }
      
      protected function __removePlayer(event:DictionaryEvent) : void
      {
         var id:int = (event.data as PlayerVO).playerInfo.ID;
         var player:ChristmasRoomPlayer = _characters[id] as ChristmasRoomPlayer;
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
         var i:int = 0;
         var player:* = null;
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
               player = articleLayer.getChildAt(i - 1) as ChristmasRoomPlayer;
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
         for each(var o in _monsters)
         {
            o.dispose();
            o = null;
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
