package church.view.churchScene
{
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import church.player.ChurchPlayer;
   import church.view.churchFire.ChurchFireEffectPlayer;
   import church.vo.PlayerVO;
   import church.vo.SceneMapVO;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
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
   
   public class SceneMap extends Sprite
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
      
      protected var _selfPlayer:ChurchPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _mouseMovie:MovieClip;
      
      private var _currentLoadingPlayer:ChurchPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:ChurchRoomModel;
      
      protected var reference:ChurchPlayer;
      
      public function SceneMap(param1:ChurchRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null)
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
         this.skyLayer = param7 == null?new Sprite():param7;
         this.addChild(meshLayer);
         this.addChild(bgLayer);
         this.addChild(articleLayer);
         this.addChild(skyLayer);
         init();
         addEvent();
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
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.church.room.MouseClickMovie") as Class;
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
         _model.addEventListener("playerFireVisible",menuChange);
         addEventListener("click",__click);
         addEventListener("enterFrame",updateMap);
         _data.addEventListener("add",__addPlayer);
         _data.addEventListener("remove",__removePlayer);
      }
      
      private function menuChange(param1:WeddingRoomEvent) : void
      {
         var _loc2_:* = param1.type;
         if("playerNameVisible" !== _loc2_)
         {
            if("playerChatBallVisible" !== _loc2_)
            {
               if("playerFireVisible" === _loc2_)
               {
                  fireVisible();
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
            _loc1_.isShowName = _model.playerNameVisible;
         }
      }
      
      public function chatBallVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var _loc1_ in _characters)
         {
            _loc1_.isChatBall = _model.playerChatBallVisible;
         }
      }
      
      public function fireVisible() : void
      {
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
            _loc2_.isChatBall = _model.playerChatBallVisible;
            _loc2_.isShowName = _model.playerNameVisible;
         }
         BuildEntityDepth();
      }
      
      protected function __click(param1:MouseEvent) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         var _loc2_:Point = this.globalToLocal(new Point(param1.stageX,param1.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!sceneScene.hit(_loc2_))
            {
               _selfPlayer.playerVO.walkPath = sceneScene.searchPath(_selfPlayer.playerPoint,_loc2_);
               _selfPlayer.playerVO.walkPath.shift();
               _selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(_selfPlayer.playerPoint,_selfPlayer.playerVO.walkPath[0]);
               _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               sendMyPosition(_selfPlayer.playerVO.walkPath.concat());
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
         SocketManager.Instance.out.sendChurchMove(param1[param1.length - 1].x,param1[param1.length - 1].y,_loc3_);
      }
      
      public function useFire(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         if(_characters[param1] == null)
         {
            return;
         }
         if(_characters[param1])
         {
            if(param1 == PlayerManager.Instance.Self.ID)
            {
               _model.fireEnable = false;
               if(!_model.playerFireVisible)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.scene.SceneMap.lihua"));
               }
            }
            _loc3_ = new ChurchFireEffectPlayer(param2);
            _loc3_.addEventListener("complete",fireCompleteHandler);
            _loc3_.owerID = param1;
            if(_model.playerFireVisible)
            {
               _loc3_.x = (_characters[param1] as ChurchPlayer).x;
               _loc3_.y = (_characters[param1] as ChurchPlayer).y - 190;
               addChild(_loc3_);
            }
            _loc3_.firePlayer();
         }
      }
      
      protected function fireCompleteHandler(param1:Event) : void
      {
         var _loc2_:ChurchFireEffectPlayer = param1.currentTarget as ChurchFireEffectPlayer;
         _loc2_.removeEventListener("complete",fireCompleteHandler);
         if(_loc2_.owerID == PlayerManager.Instance.Self.ID)
         {
            _model.fireEnable = true;
         }
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      public function movePlayer(param1:int, param2:Array) : void
      {
         var _loc3_:* = null;
         if(_characters[param1])
         {
            _loc3_ = _characters[param1] as ChurchPlayer;
            _loc3_.playerVO.walkPath = param2;
            _loc3_.playerWalk(param2);
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
      
      public function addSelfPlayer() : void
      {
         var _loc1_:* = null;
         if(!_selfPlayer)
         {
            _loc1_ = new PlayerVO();
            _loc1_.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new ChurchPlayer(_loc1_,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(param1:ChurchPlayer) : void
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
         _currentLoadingPlayer = new ChurchPlayer(_loc2_,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(param1:ChurchPlayer, param2:Boolean, param3:int) : void
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
            _characters.add(param1.playerVO.playerInfo.ID,param1);
            param1.isShowName = _model.playerNameVisible;
            param1.isChatBall = _model.playerChatBallVisible;
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
         var _loc3_:ChurchPlayer = _characters[_loc2_] as ChurchPlayer;
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
      
      public function setSalute(param1:int) : void
      {
      }
      
      protected function removeEvent() : void
      {
         _model.removeEventListener("playerNameVisible",menuChange);
         _model.removeEventListener("playerChatBallVisible",menuChange);
         _model.removeEventListener("playerFireVisible",menuChange);
         removeEventListener("click",__click);
         removeEventListener("enterFrame",updateMap);
         _data.removeEventListener("add",__addPlayer);
         _data.removeEventListener("remove",__removePlayer);
         if(reference)
         {
            reference.removeEventListener("characterMovement",setCenter);
         }
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("characterActionChange",playerActionChange);
         }
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
               _loc1_ = articleLayer.getChildAt(_loc3_ - 1) as ChurchPlayer;
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
         sceneScene = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
