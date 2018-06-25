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
      
      public function CollectionTaskSceneMap(model:CollectionTaskModel, scene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, animal:Sprite = null, sky:Sprite = null, article:Sprite = null)
      {
         super();
         _model = model;
         sceneScene = scene;
         _players = data;
         if(bg == null)
         {
            bgLayer = new Sprite();
         }
         else
         {
            bgLayer = bg;
         }
         meshLayer = mesh == null?new Sprite():mesh;
         meshLayer.alpha = 0;
         animalLayer = animal == null?new Sprite():animal;
         articleLayer = article == null?new Sprite():article;
         skyLayer = sky == null?new Sprite():sky;
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
      
      protected function _menuChangeHandler(event:CollectionTaskEvent) : void
      {
         var _loc2_:* = event.type;
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
         for each(var player in _characters)
         {
            if(player.ID != _selfPlayer.ID)
            {
               player.isShowName = _model.playerNameVisible;
            }
         }
      }
      
      public function chatBallVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var player in _characters)
         {
            if(player.ID != _selfPlayer.ID)
            {
               player.isChatBall = _model.playerChatBallVisible;
            }
         }
      }
      
      public function playerVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var player in _characters)
         {
            if(player.ID != _selfPlayer.ID)
            {
               player.isShowPlayer = _model.playerVisible;
            }
         }
      }
      
      protected function __collectHandler(event:MouseEvent) : void
      {
         var x:int = 0;
         var y:int = 0;
         if(CollectionTaskManager.Instance.isTaskComplete || event.currentTarget == _collectMovie && CollectionTaskManager.Instance.isCollecting)
         {
            return;
         }
         var _loc5_:* = event.currentTarget;
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
         _collectMovie = event.currentTarget as MovieClip;
         var targetPoint:Point = _movieClipPosVector[_movieClipId - 1];
         checkPonitDistance(targetPoint);
      }
      
      public function checkPonitDistance(p:Point) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         var fp:Point = _selfPlayer.playerPoint;
         var dis:int = Math.abs(Point.distance(fp,p));
         if(dis > 50)
         {
            if(CollectionTaskManager.Instance.isCollecting)
            {
               _stopCollectFunc();
            }
            _mouseMovie.gotoAndStop(1);
            CollectionTaskManager.Instance.isClickCollection = true;
            _selfPlayer.walk(p,_playCollectMovieFunc);
            sendMyPosition(_selfPlayer.playerVO.walkPath.concat());
         }
         else if(!CollectionTaskManager.Instance.isCollecting)
         {
            _playCollectMovieFunc();
         }
      }
      
      public function setPlayProgressFunc(fun:Function = null) : void
      {
         _playCollectMovieFunc = fun;
      }
      
      public function setStopProgressFunc(fun:Function = null) : void
      {
         _stopCollectFunc = fun;
      }
      
      protected function __removeRebortPlayer(event:CollectionTaskEvent) : void
      {
         var key:String = event.robertNickName;
         var player:CollectionTaskPlayer = _characters[key] as CollectionTaskPlayer;
         _characters.remove(key);
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
      
      protected function __removePlayer(event:DictionaryEvent) : void
      {
         var info:PlayerInfo = (event.data as PlayerVO).playerInfo;
         var id:int = info.ID;
         var player:CollectionTaskPlayer = _characters[id] as CollectionTaskPlayer;
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
      
      protected function __addPlayer(event:DictionaryEvent) : void
      {
         var playerVO:PlayerVO = event.data as PlayerVO;
         _currentLoadingPlayer = new CollectionTaskPlayer(playerVO,addPlayerCallBack);
      }
      
      protected function __click(event:MouseEvent) : void
      {
         var playerTargetPoint:* = null;
         if(!_selfPlayer)
         {
            return;
         }
         var targetPoint:Point = this.globalToLocal(new Point(event.stageX,event.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!sceneScene.hit(targetPoint))
            {
               if(CollectionTaskManager.Instance.isCollecting)
               {
                  _stopCollectFunc();
               }
               CollectionTaskManager.Instance.isClickCollection = false;
               playerTargetPoint = new Point(targetPoint.x,targetPoint.y + 15);
               _selfPlayer.playerVO.walkPath = sceneScene.searchPath(_selfPlayer.playerPoint,playerTargetPoint);
               _selfPlayer.playerVO.walkPath.shift();
               _selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(_selfPlayer.playerPoint,_selfPlayer.playerVO.walkPath[0]);
               _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               sendMyPosition(_selfPlayer.playerVO.walkPath.concat());
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
         SocketManager.Instance.out.sendCollectionSceneMove(p[p.length - 1].x,p[p.length - 1].y,pathStr);
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         var player:* = null;
         if(_characters[id])
         {
            player = _characters[id] as CollectionTaskPlayer;
            player.playerVO.walkPath = p;
            player.playerWalk(p);
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
            if(player.playerVO.playerInfo.ID != _selfPlayer.ID)
            {
               player.isChatBall = _model.playerChatBallVisible;
               player.isShowName = _model.playerNameVisible;
               player.isShowPlayer = _model.playerVisible;
            }
         }
         BuildEntityDepth();
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
      
      public function addRobertPlayer(len:int) : void
      {
         _addRobertCount = 10 - len;
         if(len < 10)
         {
            _addRobertTimer = TimerManager.getInstance().addTimerJuggler(5000,_addRobertCount);
            _addRobertTimer.addEventListener("timer",__addRebortPlayerHandler);
            _addRobertTimer.start();
         }
      }
      
      private function __addRebortPlayerHandler(event:Event) : void
      {
         if(_characters.length >= 10 || _addRobertCount == 0)
         {
            _addRobertTimer.removeEventListener("timer",__addRebortPlayerHandler);
            _addRobertTimer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_addRobertTimer);
            _addRobertTimer = null;
            return;
         }
         var robertInfo:CollectionRobertVo = CollectionTaskManager.Instance.collectionTaskInfoList[_addRobertCount];
         var playerVO:PlayerVO = new PlayerVO();
         var info:PlayerInfo = new PlayerInfo();
         info.NickName = robertInfo.NickName;
         info.Sex = robertInfo.Sex == 0;
         info.Style = robertInfo.Style;
         playerVO.playerInfo = info;
         playerVO.playerPos = sceneMapVO.defaultPos;
         playerVO.isRobert = true;
         _addRobertCount = Number(_addRobertCount) - 1;
         _currentLoadingPlayer = new CollectionTaskPlayer(playerVO,addPlayerCallBack);
      }
      
      public function addSelfPlayer() : void
      {
         var selfPlayerVO:* = null;
         if(!_selfPlayer)
         {
            selfPlayerVO = new PlayerVO();
            selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new CollectionTaskPlayer(selfPlayerVO,addPlayerCallBack);
         }
      }
      
      private function addPlayerCallBack(player:CollectionTaskPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!articleLayer || !player)
            {
               return;
            }
            _currentLoadingPlayer = null;
            player.sceneScene = sceneScene;
            var _loc4_:* = player.playerVO.scenePlayerDirection;
            player.sceneCharacterDirection = _loc4_;
            player.setSceneCharacterDirectionDefault = _loc4_;
            if(!_selfPlayer && player.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               player.playerVO.playerPos = _sceneMapVO.defaultPos;
               _selfPlayer = player;
               articleLayer.addChild(_selfPlayer);
               ajustScreen(_selfPlayer);
               setCenter();
               _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            }
            else
            {
               articleLayer.addChild(player);
            }
            player.playerPoint = player.playerVO.playerPos;
            player.sceneCharacterStateType = "natural";
            if(!player.playerVO.isRobert)
            {
               _characters.add(player.playerVO.playerInfo.ID,player);
            }
            else
            {
               _characters.add(player.playerVO.playerInfo.NickName,player);
               player.robertWalk(_movieClipPosVector);
            }
            player.isShowName = _model.playerNameVisible;
            player.isChatBall = _model.playerChatBallVisible;
            player.isShowPlayer = _model.playerVisible;
         }
      }
      
      public function get characters() : DictionaryData
      {
         return _characters;
      }
      
      public function set sceneMapVO(value:SceneMapVO) : void
      {
         _sceneMapVO = value;
      }
      
      public function get sceneMapVO() : SceneMapVO
      {
         return _sceneMapVO;
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var type:String = evt.data.toString();
         if(type == "naturalStandFront" || type == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
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
            xf = Number(-(_sceneMapVO.defaultPos.x - 1000 / 2));
            yf = Number(-(_sceneMapVO.defaultPos.y - 600 / 2) + 50);
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
      
      protected function ajustScreen(churchPlayer:CollectionTaskPlayer) : void
      {
         if(churchPlayer == null)
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
         reference = churchPlayer;
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
         var i:int = 0;
         var player:* = null;
         removeEvent();
         _sceneMapVO = null;
         if(articleLayer)
         {
            for(i = articleLayer.numChildren; i > 0; )
            {
               player = articleLayer.getChildAt(i - 1) as CollectionTaskPlayer;
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
