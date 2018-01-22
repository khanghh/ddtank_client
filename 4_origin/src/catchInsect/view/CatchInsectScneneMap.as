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
      
      public function CatchInsectScneneMap(param1:CatchInsectRoomModel, param2:SceneScene, param3:DictionaryData, param4:DictionaryData, param5:Sprite, param6:Sprite, param7:Sprite = null, param8:Sprite = null, param9:Sprite = null, param10:Sprite = null)
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
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("catchInsect.room.MouseClickMovie") as Class;
         _mouseMovie = new _loc1_() as MovieClip;
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
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         __click(param1.data[0]);
      }
      
      private function __addMonster(param1:DictionaryEvent) : void
      {
         var _loc2_:InsectInfo = param1.data as InsectInfo;
         var _loc3_:CatchInsectMonster = new CatchInsectMonster(_loc2_,_loc2_.MonsterPos);
         _monsters.add(_loc2_.ID,_loc3_);
         articleLayer.addChild(_loc3_);
      }
      
      private function __removeMonster(param1:DictionaryEvent) : void
      {
         var _loc3_:InsectInfo = param1.data as InsectInfo;
         var _loc2_:CatchInsectMonster = _monsters[_loc3_.ID] as CatchInsectMonster;
         _monsters.remove(_loc3_.ID);
         _loc2_.dispose();
      }
      
      private function __onMonsterUpdate(param1:DictionaryEvent) : void
      {
         var _loc3_:InsectInfo = param1.data as InsectInfo;
         var _loc2_:CatchInsectMonster = _monsters[_loc3_.ID] as CatchInsectMonster;
      }
      
      private function menuChange(param1:CatchInsectRoomEvent) : void
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
         if(new Date().getTime() - _lastClick > _clickInterval)
         {
            _lastClick = new Date().getTime();
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
         SocketManager.Instance.out.sendInsectSceneMove(param1[param1.length - 1].x,param1[param1.length - 1].y,_loc3_);
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         var _loc3_:* = null;
         if(_characters[param1])
         {
            _loc3_ = _characters[param1] as CatchInsectRoomPlayer;
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
            _loc4_ = _characters[param1] as CatchInsectRoomPlayer;
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
      
      public function __otherPlayrStartFight(param1:CatchInsectRoomEvent) : void
      {
         var _loc2_:CatchInsectRoomPlayer = param1.currentTarget as CatchInsectRoomPlayer;
         _loc2_.removeEventListener("readyFight",__otherPlayrStartFight);
         _loc2_.sceneCharacterDirection = SceneCharacterDirection.getDirection(_loc2_.playerPoint,armyPos);
         _loc2_.dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         _loc2_.isReadyFight = false;
         _loc2_.setStatus();
      }
      
      public function updateSelfStatus(param1:int) : void
      {
         if(!selfPlayer)
         {
            _isUpdateComplete = false;
            _updateState = param1;
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
         selfPlayer.playerVO.playerStauts = param1;
         selfPlayer.setStatus();
      }
      
      public function checkSelfStatus() : int
      {
         return selfPlayer.playerVO.playerStauts;
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
            _loc3_ = Number(-(CatchInsectManager.instance.catchInsectInfo.playerDefaultPos.x - 1000 / 2));
            _loc2_ = Number(-(CatchInsectManager.instance.catchInsectInfo.playerDefaultPos.y - 600 / 2) + 50);
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
            _loc1_ = CatchInsectManager.instance.catchInsectInfo.myPlayerVO;
            _loc1_.currentWalkStartPoint = _loc1_.playerPos;
            _loc1_.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new CatchInsectRoomPlayer(_loc1_,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(param1:CatchInsectRoomPlayer) : void
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
         _currentLoadingPlayer = new CatchInsectRoomPlayer(_loc2_,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(param1:CatchInsectRoomPlayer, param2:Boolean, param3:int) : void
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
               selfPlayer.addEventListener("characterArrivedNextStep",__walkEndHandler);
            }
            else
            {
               articleLayer.addChild(param1);
            }
            param1.playerPoint = param1.playerVO.playerPos;
            param1.sceneCharacterStateType = "natural";
            _characters.add(param1.playerVO.playerInfo.ID,param1);
            param1.isShowName = _model.playerNameVisible;
            if(!_isUpdateComplete)
            {
               updateSelfStatus(_updateState);
            }
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
            _loc2_ = CatchInsectMonsterManager.Instance.curMonster;
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
      
      private function __walkEndHandler(param1:SceneCharacterEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Object = _monsters[CatchInsectControl.instance.refMonsID];
         if(_loc2_)
         {
            _loc3_ = _loc2_ as CatchInsectMonster;
            _loc3_.walk(selfPlayer.playerVO.currentWalkStartPoint);
         }
      }
      
      protected function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:int = (param1.data as PlayerVO).playerInfo.ID;
         var _loc3_:CatchInsectRoomPlayer = _characters[_loc2_] as CatchInsectRoomPlayer;
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
         if(selfPlayer)
         {
            selfPlayer.removeEventListener("characterArrivedNextStep",__walkEndHandler);
         }
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
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
               _loc1_ = articleLayer.getChildAt(_loc4_ - 1) as CatchInsectRoomPlayer;
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
