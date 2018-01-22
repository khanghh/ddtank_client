package collectionTask.view
{
   import church.vo.SceneMapVO;
   import collectionTask.CollectionTaskManager;
   import collectionTask.event.CollectionTaskEvent;
   import collectionTask.model.CollectionTaskModel;
   import collectionTask.player.CollectionTaskPlayer;
   import collectionTask.vo.CollectionRobertVo;
   import collectionTask.vo.PlayerVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
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
   import flash.utils.getTimer;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CollectionTaskSceneMap extends Sprite implements Disposeable
   {
       
      
      private var _model:CollectionTaskModel;
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      protected var animalLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      private var _sceneMapVO:SceneMapVO;
      
      public var _selfPlayer:CollectionTaskPlayer;
      
      private var _currentLoadingPlayer:CollectionTaskPlayer;
      
      private var _mouseMovie:MovieClip;
      
      protected var _characters:DictionaryData;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _players:DictionaryData;
      
      private var _red_tree:MovieClip;
      
      private var _green_tree:MovieClip;
      
      private var _yellow_tree:MovieClip;
      
      private var _bee_BoxUp:MovieClip;
      
      private var _bee_BoxDown:MovieClip;
      
      private var _movieClipId:int;
      
      private var _collectMovie:MovieClip;
      
      private var _movieClipPosVector:Vector.<Point>;
      
      private var _playCollectMovieFunc:Function;
      
      private var _stopCollectFunc:Function;
      
      private var _addRobertCount:int;
      
      private var _redTxt:FilterFrameText;
      
      private var _yellowTxt:FilterFrameText;
      
      private var _blueTxt:FilterFrameText;
      
      private var _beeTxt:FilterFrameText;
      
      private var _beeTxt1:FilterFrameText;
      
      private var _addRobertTimer:TimerJuggler;
      
      protected var reference:CollectionTaskPlayer;
      
      public function CollectionTaskSceneMap(param1:CollectionTaskModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null, param8:Sprite = null)
      {
         super();
         _model = param1;
         sceneScene = param2;
         _players = param3;
         if(param4 == null)
         {
            bgLayer = new Sprite();
         }
         else
         {
            bgLayer = param4;
         }
         meshLayer = param5 == null?new Sprite():param5;
         meshLayer.alpha = 0;
         animalLayer = param6 == null?new Sprite():param6;
         articleLayer = param8 == null?new Sprite():param8;
         skyLayer = param7 == null?new Sprite():param7;
         addChild(bgLayer);
         addChild(animalLayer);
         addChild(meshLayer);
         addChild(skyLayer);
         addChild(articleLayer);
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _movieClipPosVector = new Vector.<Point>();
         _movieClipPosVector.push(new Point(260,475),new Point(584,500),new Point(480,790),new Point(750,520),new Point(700,820));
         _characters = new DictionaryData(true);
         _mouseMovie = ComponentFactory.Instance.creat("asset.collectionTask.MouseClickMovie");
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         bgLayer.addChild(_mouseMovie);
         _red_tree = skyLayer.getChildByName("red_tree") as MovieClip;
         _green_tree = skyLayer.getChildByName("green_tree") as MovieClip;
         _yellow_tree = skyLayer.getChildByName("yellow_tree") as MovieClip;
         _bee_BoxUp = skyLayer.getChildByName("bee_BoxUp") as MovieClip;
         _bee_BoxDown = skyLayer.getChildByName("bee_BoxDown") as MovieClip;
         _lastClick = 0;
         _redTxt = ComponentFactory.Instance.creatComponentByStylename("collectionTask.redTxt");
         _redTxt.text = LanguageMgr.GetTranslation("collectionTask.text1");
         _yellowTxt = ComponentFactory.Instance.creatComponentByStylename("collectionTask.yellowTxt");
         _yellowTxt.text = LanguageMgr.GetTranslation("collectionTask.text2");
         _blueTxt = ComponentFactory.Instance.creatComponentByStylename("collectionTask.blueTxt");
         _blueTxt.text = LanguageMgr.GetTranslation("collectionTask.text3");
         _beeTxt = ComponentFactory.Instance.creatComponentByStylename("collectionTask.beeTxt");
         _beeTxt.text = LanguageMgr.GetTranslation("collectionTask.text4");
         _beeTxt1 = ComponentFactory.Instance.creatComponentByStylename("collectionTask.beeTxt1");
         _beeTxt1.text = LanguageMgr.GetTranslation("collectionTask.text4");
         bgLayer.addChild(_redTxt);
         bgLayer.addChild(_yellowTxt);
         bgLayer.addChild(_blueTxt);
         bgLayer.addChild(_beeTxt);
         bgLayer.addChild(_beeTxt1);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__click);
         addEventListener("enterFrame",updateMap);
         _red_tree.addEventListener("click",__collectHandler);
         _green_tree.addEventListener("click",__collectHandler);
         _yellow_tree.addEventListener("click",__collectHandler);
         _bee_BoxUp.addEventListener("click",__collectHandler);
         _bee_BoxDown.addEventListener("click",__collectHandler);
         _players.addEventListener("add",__addPlayer);
         _players.addEventListener("remove",__removePlayer);
         CollectionTaskManager.Instance.addEventListener("removeRobert",__removeRebortPlayer);
         _model.addEventListener("playerNameVisible",_menuChangeHandler);
         _model.addEventListener("playerChatBallVisible",_menuChangeHandler);
         _model.addEventListener("playerVisible",_menuChangeHandler);
      }
      
      protected function _menuChangeHandler(param1:CollectionTaskEvent) : void
      {
         var _loc2_:* = param1.type;
         if("playerNameVisible" !== _loc2_)
         {
            if("playerChatBallVisible" !== _loc2_)
            {
               if("playerVisible" === _loc2_)
               {
                  playerVisible();
               }
            }
            else
            {
               chatBallVisible();
            }
         }
         else
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
            if(_loc1_.ID != _selfPlayer.ID)
            {
               _loc1_.isShowName = _model.playerNameVisible;
            }
         }
      }
      
      public function chatBallVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var _loc1_ in _characters)
         {
            if(_loc1_.ID != _selfPlayer.ID)
            {
               _loc1_.isChatBall = _model.playerChatBallVisible;
            }
         }
      }
      
      public function playerVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var _loc1_ in _characters)
         {
            if(_loc1_.ID != _selfPlayer.ID)
            {
               _loc1_.isShowPlayer = _model.playerVisible;
            }
         }
      }
      
      protected function __collectHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(CollectionTaskManager.Instance.isTaskComplete || param1.currentTarget == _collectMovie && CollectionTaskManager.Instance.isCollecting)
         {
            return;
         }
         var _loc5_:* = param1.currentTarget;
         if(_red_tree !== _loc5_)
         {
            if(_green_tree !== _loc5_)
            {
               if(_yellow_tree !== _loc5_)
               {
                  if(_bee_BoxUp !== _loc5_)
                  {
                     if(_bee_BoxDown === _loc5_)
                     {
                        _movieClipId = 5;
                        CollectionTaskManager.Instance.collectedId = 11783;
                     }
                  }
                  else
                  {
                     _movieClipId = 4;
                     CollectionTaskManager.Instance.collectedId = 11783;
                  }
               }
               else
               {
                  _movieClipId = 2;
                  CollectionTaskManager.Instance.collectedId = 11497;
               }
            }
            else
            {
               _movieClipId = 1;
               CollectionTaskManager.Instance.collectedId = 11495;
            }
         }
         else
         {
            _movieClipId = 3;
            CollectionTaskManager.Instance.collectedId = 11499;
         }
         _collectMovie = param1.currentTarget as MovieClip;
         var _loc2_:Point = _movieClipPosVector[_movieClipId - 1];
         checkPonitDistance(_loc2_);
      }
      
      public function checkPonitDistance(param1:Point) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         var _loc3_:Point = _selfPlayer.playerPoint;
         var _loc2_:int = Math.abs(Point.distance(_loc3_,param1));
         if(_loc2_ > 50)
         {
            if(CollectionTaskManager.Instance.isCollecting)
            {
               _stopCollectFunc();
            }
            _mouseMovie.gotoAndStop(1);
            CollectionTaskManager.Instance.isClickCollection = true;
            _selfPlayer.walk(param1,_playCollectMovieFunc);
            sendMyPosition(_selfPlayer.playerVO.walkPath.concat());
         }
         else if(!CollectionTaskManager.Instance.isCollecting)
         {
            _playCollectMovieFunc();
         }
      }
      
      public function setPlayProgressFunc(param1:Function = null) : void
      {
         _playCollectMovieFunc = param1;
      }
      
      public function setStopProgressFunc(param1:Function = null) : void
      {
         _stopCollectFunc = param1;
      }
      
      protected function __removeRebortPlayer(param1:CollectionTaskEvent) : void
      {
         var _loc3_:String = param1.robertNickName;
         var _loc2_:CollectionTaskPlayer = _characters[_loc3_] as CollectionTaskPlayer;
         _characters.remove(_loc3_);
         if(_loc2_)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.removeEventListener("characterMovement",setCenter);
            _loc2_.removeEventListener("characterActionChange",playerActionChange);
            _loc2_.dispose();
         }
         _loc2_ = null;
      }
      
      protected function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc4_:PlayerInfo = (param1.data as PlayerVO).playerInfo;
         var _loc2_:int = _loc4_.ID;
         var _loc3_:CollectionTaskPlayer = _characters[_loc2_] as CollectionTaskPlayer;
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
      
      protected function __addPlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerVO = param1.data as PlayerVO;
         _currentLoadingPlayer = new CollectionTaskPlayer(_loc2_,addPlayerCallBack);
      }
      
      protected function __click(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!_selfPlayer)
         {
            return;
         }
         var _loc3_:Point = this.globalToLocal(new Point(param1.stageX,param1.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!sceneScene.hit(_loc3_))
            {
               if(CollectionTaskManager.Instance.isCollecting)
               {
                  _stopCollectFunc();
               }
               CollectionTaskManager.Instance.isClickCollection = false;
               _loc2_ = new Point(_loc3_.x,_loc3_.y + 15);
               _selfPlayer.playerVO.walkPath = sceneScene.searchPath(_selfPlayer.playerPoint,_loc2_);
               _selfPlayer.playerVO.walkPath.shift();
               _selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(_selfPlayer.playerPoint,_selfPlayer.playerVO.walkPath[0]);
               _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               sendMyPosition(_selfPlayer.playerVO.walkPath.concat());
               _mouseMovie.x = _loc3_.x;
               _mouseMovie.y = _loc3_.y;
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
         SocketManager.Instance.out.sendCollectionSceneMove(param1[param1.length - 1].x,param1[param1.length - 1].y,_loc3_);
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         var _loc3_:* = null;
         if(_characters[param1])
         {
            _loc3_ = _characters[param1] as CollectionTaskPlayer;
            _loc3_.playerVO.walkPath = param2;
            _loc3_.playerWalk(param2);
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
            if(_loc2_.playerVO.playerInfo.ID != _selfPlayer.ID)
            {
               _loc2_.isChatBall = _model.playerChatBallVisible;
               _loc2_.isShowName = _model.playerNameVisible;
               _loc2_.isShowPlayer = _model.playerVisible;
            }
         }
         BuildEntityDepth();
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
      
      public function addRobertPlayer(param1:int) : void
      {
         _addRobertCount = 10 - param1;
         if(param1 < 10)
         {
            _addRobertTimer = TimerManager.getInstance().addTimerJuggler(5000,_addRobertCount);
            _addRobertTimer.addEventListener("timer",__addRebortPlayerHandler);
            _addRobertTimer.start();
         }
      }
      
      private function __addRebortPlayerHandler(param1:Event) : void
      {
         if(_characters.length >= 10 || _addRobertCount == 0)
         {
            _addRobertTimer.removeEventListener("timer",__addRebortPlayerHandler);
            _addRobertTimer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_addRobertTimer);
            _addRobertTimer = null;
            return;
         }
         var _loc2_:CollectionRobertVo = CollectionTaskManager.Instance.collectionTaskInfoList[_addRobertCount];
         var _loc3_:PlayerVO = new PlayerVO();
         var _loc4_:PlayerInfo = new PlayerInfo();
         _loc4_.NickName = _loc2_.NickName;
         _loc4_.Sex = _loc2_.Sex == 0;
         _loc4_.Style = _loc2_.Style;
         _loc3_.playerInfo = _loc4_;
         _loc3_.playerPos = sceneMapVO.defaultPos;
         _loc3_.isRobert = true;
         _addRobertCount = Number(_addRobertCount) - 1;
         _currentLoadingPlayer = new CollectionTaskPlayer(_loc3_,addPlayerCallBack);
      }
      
      public function addSelfPlayer() : void
      {
         var _loc1_:* = null;
         if(!_selfPlayer)
         {
            _loc1_ = new PlayerVO();
            _loc1_.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new CollectionTaskPlayer(_loc1_,addPlayerCallBack);
         }
      }
      
      private function addPlayerCallBack(param1:CollectionTaskPlayer, param2:Boolean, param3:int) : void
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
            if(!_selfPlayer && param1.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               param1.playerVO.playerPos = _sceneMapVO.defaultPos;
               _selfPlayer = param1;
               articleLayer.addChild(_selfPlayer);
               ajustScreen(_selfPlayer);
               setCenter();
               _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            }
            else
            {
               articleLayer.addChild(param1);
            }
            param1.playerPoint = param1.playerVO.playerPos;
            param1.sceneCharacterStateType = "natural";
            if(!param1.playerVO.isRobert)
            {
               _characters.add(param1.playerVO.playerInfo.ID,param1);
            }
            else
            {
               _characters.add(param1.playerVO.playerInfo.NickName,param1);
               param1.robertWalk(_movieClipPosVector);
            }
            param1.isShowName = _model.playerNameVisible;
            param1.isChatBall = _model.playerChatBallVisible;
            param1.isShowPlayer = _model.playerVisible;
         }
      }
      
      public function get characters() : DictionaryData
      {
         return _characters;
      }
      
      public function set sceneMapVO(param1:SceneMapVO) : void
      {
         _sceneMapVO = param1;
      }
      
      public function get sceneMapVO() : SceneMapVO
      {
         return _sceneMapVO;
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "naturalStandFront" || _loc2_ == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
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
            _loc3_ = Number(-(_sceneMapVO.defaultPos.x - 1000 / 2));
            _loc2_ = Number(-(_sceneMapVO.defaultPos.y - 600 / 2) + 50);
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
      
      protected function ajustScreen(param1:CollectionTaskPlayer) : void
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
      
      private function removeEvent() : void
      {
         removeEventListener("click",__click);
         removeEventListener("enterFrame",updateMap);
         _red_tree.removeEventListener("click",__collectHandler);
         _green_tree.removeEventListener("click",__collectHandler);
         _yellow_tree.removeEventListener("click",__collectHandler);
         _bee_BoxUp.removeEventListener("click",__collectHandler);
         _bee_BoxDown.removeEventListener("click",__collectHandler);
         _players.removeEventListener("add",__addPlayer);
         _players.removeEventListener("remove",__removePlayer);
         CollectionTaskManager.Instance.removeEventListener("removeRobert",__removeRebortPlayer);
         _model.removeEventListener("playerNameVisible",_menuChangeHandler);
         _model.removeEventListener("playerChatBallVisible",_menuChangeHandler);
         _model.removeEventListener("playerVisible",_menuChangeHandler);
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         removeEvent();
         _sceneMapVO = null;
         if(articleLayer)
         {
            _loc2_ = articleLayer.numChildren;
            while(_loc2_ > 0)
            {
               _loc1_ = articleLayer.getChildAt(_loc2_ - 1) as CollectionTaskPlayer;
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
                  articleLayer.removeChildAt(_loc2_ - 1);
               }
               catch(e:RangeError)
               {
                  trace(e);
               }
               _loc2_--;
            }
            if(articleLayer && articleLayer.parent)
            {
               articleLayer.parent.removeChild(articleLayer);
            }
         }
         articleLayer = null;
         if(_selfPlayer)
         {
            if(_selfPlayer.parent)
            {
               _selfPlayer.parent.removeChild(_selfPlayer);
            }
            _selfPlayer.dispose();
         }
         _selfPlayer = null;
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
         if(animalLayer && animalLayer.parent)
         {
            animalLayer.parent.removeChild(animalLayer);
         }
         animalLayer = null;
         sceneScene = null;
         ObjectUtils.disposeObject(_collectMovie);
         _collectMovie = null;
         ObjectUtils.disposeObject(_red_tree);
         _red_tree = null;
         ObjectUtils.disposeObject(_green_tree);
         _green_tree = null;
         ObjectUtils.disposeObject(_yellow_tree);
         _yellow_tree = null;
         ObjectUtils.disposeObject(_bee_BoxDown);
         _bee_BoxDown = null;
         ObjectUtils.disposeObject(_bee_BoxUp);
         _bee_BoxUp = null;
         if(_addRobertTimer)
         {
            _addRobertTimer.removeEventListener("timer",__addRebortPlayerHandler);
            _addRobertTimer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_addRobertTimer);
            _addRobertTimer = null;
         }
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
