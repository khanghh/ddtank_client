package catchInsect.view
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.CatchInsectMonsterManager;
   import catchInsect.CatchInsectRoomModel;
   import catchInsect.PlayerVO;
   import catchInsect.data.InsectInfo;
   import catchInsect.event.CatchInsectRoomEvent;
   import catchInsect.player.CatchInsectMonster;
   import catchInsect.player.CatchInsectRoomPlayer;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class CatchInsectScneneMap extends Sprite implements Disposeable
   {
      
      public static var packsNum:int = 1;
       
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      protected var snowLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      public var selfPlayer:CatchInsectRoomPlayer;
      
      private var _isUpdateComplete:Boolean;
      
      private var _updateState:int;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _currentLoadingPlayer:CatchInsectRoomPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:CatchInsectRoomModel;
      
      private var armyPos:Point;
      
      private var decorationLayer:Sprite;
      
      protected var _mapObjs:DictionaryData;
      
      protected var _monsters:DictionaryData;
      
      private var _mouseMovie:MovieClip;
      
      private var r:int = 250;
      
      private var auto:Point;
      
      private var autoMove:Boolean = false;
      
      private var _entering:Boolean = false;
      
      private var endPoint:Point;
      
      protected var reference:CatchInsectRoomPlayer;
      
      public function CatchInsectScneneMap(model:CatchInsectRoomModel, sceneScene:SceneScene, data:DictionaryData, objData:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null, decoration:Sprite = null, snow:Sprite = null)
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
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("catchInsect.room.MouseClickMovie") as Class;
         _mouseMovie = new mvClass() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         bgLayer.addChild(_mouseMovie);
         last_click = 0;
         if(bgLayer != null && articleLayer != null)
         {
            armyPos = new Point(bgLayer.getChildByName("armyPos").x,bgLayer.getChildByName("armyPos").y);
         }
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
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         __click(event.data[0]);
      }
      
      private function __addMonster(pEvent:DictionaryEvent) : void
      {
         var monster:InsectInfo = pEvent.data as InsectInfo;
         var cMonster:CatchInsectMonster = new CatchInsectMonster(monster,monster.MonsterPos);
         _monsters.add(monster.ID,cMonster);
         articleLayer.addChild(cMonster);
      }
      
      private function __removeMonster(pEvent:DictionaryEvent) : void
      {
         var monsterInfo:InsectInfo = pEvent.data as InsectInfo;
         var monster:CatchInsectMonster = _monsters[monsterInfo.ID] as CatchInsectMonster;
         _monsters.remove(monsterInfo.ID);
         monster.dispose();
      }
      
      private function __onMonsterUpdate(pEvent:DictionaryEvent) : void
      {
         var monsterInfo:InsectInfo = pEvent.data as InsectInfo;
         var monster:CatchInsectMonster = _monsters[monsterInfo.ID] as CatchInsectMonster;
      }
      
      private function menuChange(evt:CatchInsectRoomEvent) : void
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
         if(new Date().getTime() - _lastClick > _clickInterval)
         {
            _lastClick = new Date().getTime();
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
         SocketManager.Instance.out.sendInsectSceneMove(p[p.length - 1].x,p[p.length - 1].y,pathStr);
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         var christmasRoomPlayer:* = null;
         if(_characters[id])
         {
            christmasRoomPlayer = _characters[id] as CatchInsectRoomPlayer;
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
         var roomPlayer:* = null;
         if(_characters[id])
         {
            roomPlayer = _characters[id] as CatchInsectRoomPlayer;
            if(stauts == 0)
            {
               roomPlayer.playerVO.playerStauts = stauts;
               roomPlayer.playerVO.playerPos = point;
               roomPlayer.setStatus();
            }
            else if(stauts == 1)
            {
               if(!roomPlayer.getCanAction())
               {
                  roomPlayer.playerVO.playerStauts = 0;
                  roomPlayer.setStatus();
               }
               roomPlayer.playerVO.playerStauts = stauts;
               roomPlayer.isReadyFight = true;
               roomPlayer.addEventListener("readyFight",__otherPlayrStartFight);
               roomPlayer.playerVO.walkPath = [point];
               roomPlayer.playerWalk([point]);
            }
            else
            {
               roomPlayer.playerVO.playerStauts = stauts;
               roomPlayer.setStatus();
            }
         }
      }
      
      public function __otherPlayrStartFight(evt:CatchInsectRoomEvent) : void
      {
         var roomPlayer:CatchInsectRoomPlayer = evt.currentTarget as CatchInsectRoomPlayer;
         roomPlayer.removeEventListener("readyFight",__otherPlayrStartFight);
         roomPlayer.sceneCharacterDirection = SceneCharacterDirection.getDirection(roomPlayer.playerPoint,armyPos);
         roomPlayer.dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         roomPlayer.isReadyFight = false;
         roomPlayer.setStatus();
      }
      
      public function updateSelfStatus(value:int) : void
      {
         if(!selfPlayer)
         {
            _isUpdateComplete = false;
            _updateState = value;
            return;
         }
         _isUpdateComplete = true;
         if(selfPlayer.playerVO.playerStauts == 2)
         {
            selfPlayer.playerVO.playerPos = CatchInsectManager.instance.catchInsectInfo.playerDefaultPos;
            ajustScreen(selfPlayer);
            setCenter();
            _entering = false;
         }
         selfPlayer.playerVO.playerStauts = value;
         selfPlayer.setStatus();
      }
      
      public function checkSelfStatus() : int
      {
         return selfPlayer.playerVO.playerStauts;
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
            xf = Number(-(CatchInsectManager.instance.catchInsectInfo.playerDefaultPos.x - 1000 / 2));
            yf = Number(-(CatchInsectManager.instance.catchInsectInfo.playerDefaultPos.y - 600 / 2) + 50);
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
            selfPlayerVO = CatchInsectManager.instance.catchInsectInfo.myPlayerVO;
            selfPlayerVO.currentWalkStartPoint = selfPlayerVO.playerPos;
            selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new CatchInsectRoomPlayer(selfPlayerVO,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(christmasRoomPlayer:CatchInsectRoomPlayer) : void
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
         _currentLoadingPlayer = new CatchInsectRoomPlayer(playerVO,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(roomPlayer:CatchInsectRoomPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!articleLayer || !roomPlayer)
            {
               return;
            }
            _currentLoadingPlayer = null;
            roomPlayer.sceneScene = sceneScene;
            var _loc4_:* = roomPlayer.playerVO.scenePlayerDirection;
            roomPlayer.sceneCharacterDirection = _loc4_;
            roomPlayer.setSceneCharacterDirectionDefault = _loc4_;
            if(!selfPlayer && roomPlayer.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               roomPlayer.playerVO.playerPos = roomPlayer.playerVO.playerPos;
               selfPlayer = roomPlayer;
               articleLayer.addChild(selfPlayer);
               ajustScreen(selfPlayer);
               setCenter();
               selfPlayer.setStatus();
               selfPlayer.addEventListener("characterActionChange",playerActionChange);
               selfPlayer.addEventListener("characterArrivedNextStep",__walkEndHandler);
            }
            else
            {
               articleLayer.addChild(roomPlayer);
            }
            roomPlayer.playerPoint = roomPlayer.playerVO.playerPos;
            roomPlayer.sceneCharacterStateType = "natural";
            _characters.add(roomPlayer.playerVO.playerInfo.ID,roomPlayer);
            roomPlayer.isShowName = _model.playerNameVisible;
            if(!_isUpdateComplete)
            {
               updateSelfStatus(_updateState);
            }
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
            mon = CatchInsectMonsterManager.Instance.curMonster;
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
      
      private function __walkEndHandler(event:SceneCharacterEvent) : void
      {
         var monster:* = null;
         var monsObj:Object = _monsters[CatchInsectControl.instance.refMonsID];
         if(monsObj)
         {
            monster = monsObj as CatchInsectMonster;
            monster.walk(selfPlayer.playerVO.currentWalkStartPoint);
         }
      }
      
      protected function __removePlayer(event:DictionaryEvent) : void
      {
         var id:int = (event.data as PlayerVO).playerInfo.ID;
         var player:CatchInsectRoomPlayer = _characters[id] as CatchInsectRoomPlayer;
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
         if(selfPlayer)
         {
            selfPlayer.removeEventListener("characterArrivedNextStep",__walkEndHandler);
         }
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
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
               player = articleLayer.getChildAt(i - 1) as CatchInsectRoomPlayer;
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
