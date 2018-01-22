package collectionTask.player
{
   import collectionTask.CollectionTaskManager;
   import collectionTask.event.CollectionTaskEvent;
   import collectionTask.vo.PlayerVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.ChatManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import vip.VipController;
   
   public class CollectionTaskPlayer extends CollectionTaskPlayerBase
   {
       
      
      private var _playerVO:PlayerVO;
      
      private var _sceneScene:SceneScene;
      
      private var _spName:Sprite;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _isShowPlayer:Boolean = true;
      
      private var _chatBallView:ChatBallPlayer;
      
      private var _face:FaceContainer;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _walkOverHander:Function;
      
      private var _destinationPos:Point;
      
      private var _robertWalkVector:Vector.<Point>;
      
      private var _robertCollectTimer:TimerJuggler;
      
      private var _robertCollectCount:int;
      
      private var _currentWalkStartPoint:Point;
      
      public function CollectionTaskPlayer(param1:PlayerVO, param2:Function = null)
      {
         _playerVO = param1;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(param1.playerInfo,param2);
         initialize();
      }
      
      private function initialize() : void
      {
         moveSpeed = _playerVO.playerMoveSpeed;
         if(_isChatBall)
         {
            if(!_chatBallView)
            {
               _chatBallView = new ChatBallPlayer();
            }
            _chatBallView.x = (playerWitdh - _chatBallView.width) / 2 - playerWitdh / 2;
            _chatBallView.y = -playerHeight + 40;
            addChild(_chatBallView);
         }
         else
         {
            if(_chatBallView)
            {
               _chatBallView.clear();
               if(_chatBallView.parent)
               {
                  _chatBallView.parent.removeChild(_chatBallView);
               }
               _chatBallView.dispose();
            }
            _chatBallView = null;
         }
         if(!_lblName)
         {
            _lblName = ComponentFactory.Instance.creat("asset.collectionTask.characterPlayerNameAsset");
         }
         _lblName.mouseEnabled = false;
         _lblName.text = playerVO && playerVO.playerInfo && playerVO.playerInfo.NickName?playerVO.playerInfo.NickName:"";
         if(!_spName)
         {
            _spName = new Sprite();
         }
         _spName.addChild(_lblName);
         if(playerVO.playerInfo.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(-1,playerVO.playerInfo.typeVIP);
            _vipName.textSize = 16;
            _vipName.x = _lblName.x;
            _vipName.y = _lblName.y;
            _vipName.text = _lblName.text;
            _spName.addChild(_vipName);
         }
         PositionUtils.adaptNameStyle(_playerVO.playerInfo,_lblName,_vipName);
         if(playerVO.playerInfo.IsVIP && !_vipIcon)
         {
            _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.collectionTask.VipIcon");
            if(playerVO.playerInfo.typeVIP >= 2)
            {
               _vipIcon.y = _vipIcon.y - 5;
            }
            _vipIcon.setInfo(playerVO.playerInfo,false);
         }
         if(_vipIcon)
         {
            _spName.addChild(_vipIcon);
            _lblName.x = _vipIcon.x + _vipIcon.width;
            if(_vipName)
            {
               _vipName.x = _lblName.x;
            }
         }
         _spName.x = (playerWitdh - _spName.width) / 2 - playerWitdh / 2;
         _spName.y = -playerHeight;
         _spName.graphics.beginFill(0,0.5);
         var _loc1_:int = !!_vipIcon?_lblName.textWidth + _vipIcon.width:Number(_lblName.textWidth + 8);
         if(playerVO.playerInfo.IsVIP)
         {
            _loc1_ = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_vipName.width + 8);
            _spName.x = (playerWitdh - (_vipIcon.width + _vipName.width)) / 2 - playerWitdh / 2;
         }
         _spName.graphics.drawRoundRect(-4,0,_loc1_,22,5,5);
         _spName.graphics.endFill();
         addChildAt(_spName,0);
         _spName.visible = _isShowName;
         _face = new FaceContainer(true);
         _face.x = (playerWitdh - _face.width) / 2 - playerWitdh / 2;
         _face.y = -90;
         addChild(_face);
         setEvent();
      }
      
      private function setEvent() : void
      {
         addEventListener("characterDirectionChange",characterDirectionChange);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ChatManager.Instance.addEventListener("addFace",__getFace);
      }
      
      public function walk(param1:Point, param2:Function = null) : void
      {
         if(!_sceneScene)
         {
            return;
         }
         _destinationPos = param1;
         playerVO.walkPath = _sceneScene.searchPath(playerPoint,param1);
         playerVO.walkPath.shift();
         playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(playerPoint,playerVO.walkPath[0]);
         playerVO.currentWalkStartPoint = currentWalkStartPoint;
         isWalkPathChange = true;
         _walkOverHander = param2;
      }
      
      public function robertWalk(param1:Vector.<Point>) : void
      {
         _robertWalkVector = param1;
         walk(_robertWalkVector[int(Math.random() * 5)]);
      }
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void
      {
         _playerVO.scenePlayerDirection = sceneCharacterDirection;
         if(param1.data)
         {
            if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalWalkBack";
               }
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalWalkFront";
               }
            }
         }
         else
         {
            if(_playerVO.isRobert && _walkOverHander == null)
            {
               _robertCollectTimer = TimerManager.getInstance().addTimerJuggler(5000);
               _robertCollectTimer.addEventListener("timer",__robertCollectCompleteHandler);
               _robertCollectTimer.start();
            }
            else if(_walkOverHander != null && CollectionTaskManager.Instance.isClickCollection && Math.abs(Point.distance(playerPoint,_destinationPos)) == 0)
            {
               _walkOverHander();
            }
            if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalStandBack";
               }
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalStandFront";
               }
            }
         }
      }
      
      protected function __robertCollectCompleteHandler(param1:Event) : void
      {
         _robertCollectCount = Number(_robertCollectCount) + 1;
         _robertCollectTimer.removeEventListener("timer",__robertCollectCompleteHandler);
         _robertCollectTimer.stop();
         TimerManager.getInstance().removeJugglerByTimer(_robertCollectTimer);
         _robertCollectTimer = null;
         if(_robertCollectCount == 5)
         {
            CollectionTaskManager.Instance.dispatchEvent(new CollectionTaskEvent("removeRobert",_playerVO.playerInfo.NickName));
         }
         else
         {
            walk(_robertWalkVector[int(Math.random() * 5)]);
         }
      }
      
      public function set setSceneCharacterDirectionDefault(param1:SceneCharacterDirection) : void
      {
         if(param1 == SceneCharacterDirection.LT || param1 == SceneCharacterDirection.RT)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandBack";
            }
         }
         else if(param1 == SceneCharacterDirection.LB || param1 == SceneCharacterDirection.RB)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandFront";
            }
         }
      }
      
      public function updatePlayer() : void
      {
         refreshCharacterState();
         characterMirror();
         playerWalkPath();
         update();
      }
      
      private function characterMirror() : void
      {
         var _loc1_:Sprite = character;
         if(!isDefaultCharacter)
         {
            _loc1_.scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            _loc1_.x = !!sceneCharacterDirection.isMirror?playerWitdh / 2:Number(-playerWitdh / 2);
         }
         else
         {
            _loc1_.scaleX = 1;
            _loc1_.x = -playerWitdh / 2;
         }
         _loc1_.y = -playerHeight + 12;
      }
      
      private function playerWalkPath() : void
      {
         if(_walkPath != null && _walkPath.length > 0 && _playerVO.walkPath.length > 0 && _walkPath != _playerVO.walkPath)
         {
            fixPlayerPath();
         }
         if(_playerVO && _playerVO.walkPath && _playerVO.walkPath.length <= 0 && !_tween.isPlaying)
         {
            return;
         }
         playerWalk(_playerVO.walkPath);
      }
      
      override public function playerWalk(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         if(_walkPath != null && _tween.isPlaying && _walkPath == _playerVO.walkPath)
         {
            return;
         }
         _walkPath = _playerVO.walkPath;
         if(_walkPath.length > 0)
         {
            _currentWalkStartPoint = _walkPath[0];
            sceneCharacterDirection = SceneCharacterDirection.getDirection(playerPoint,_currentWalkStartPoint);
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",true));
            _loc2_ = Point.distance(_currentWalkStartPoint,playerPoint);
            _tween.start(_loc2_ / _moveSpeed,"x",_currentWalkStartPoint.x,"y",_currentWalkStartPoint.y);
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      private function fixPlayerPath() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(_playerVO.currentWalkStartPoint == null)
         {
            return;
         }
         var _loc2_:* = -1;
         _loc3_ = 0;
         while(_loc3_ < _walkPath.length)
         {
            if(_walkPath[_loc3_].x == _playerVO.currentWalkStartPoint.x && _walkPath[_loc3_].y == _playerVO.currentWalkStartPoint.y)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ > 0)
         {
            _loc1_ = _walkPath.slice(0,_loc2_);
            _playerVO.walkPath = _loc1_.concat(_playerVO.walkPath);
         }
      }
      
      public function get currentWalkStartPoint() : Point
      {
         return _currentWalkStartPoint;
      }
      
      public function refreshCharacterState() : void
      {
         if((sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT) && _tween.isPlaying)
         {
            sceneCharacterActionType = "naturalWalkBack";
         }
         else if((sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB) && _tween.isPlaying)
         {
            sceneCharacterActionType = "naturalWalkFront";
         }
         moveSpeed = _playerVO.playerMoveSpeed;
      }
      
      private function __getChat(param1:ChatEvent) : void
      {
         if(!_isChatBall || !param1.data)
         {
            return;
         }
         var _loc2_:ChatData = ChatData(param1.data).clone();
         if(!_loc2_)
         {
            return;
         }
         _loc2_.msg = Helpers.deCodeString(_loc2_.msg);
         if(_loc2_.channel == 2 || _loc2_.channel == 3)
         {
            return;
         }
         if(_loc2_ && _playerVO.playerInfo && _loc2_.senderID == _playerVO.playerInfo.ID)
         {
            _chatBallView.setText(_loc2_.msg,_playerVO.playerInfo.paopaoType);
            if(!_chatBallView.parent)
            {
               addChildAt(_chatBallView,this.getChildIndex(character) + 1);
            }
         }
      }
      
      private function __getFace(param1:ChatEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_["playerid"] == _playerVO.playerInfo.ID)
         {
            _face.setFace(_loc2_["faceid"]);
         }
      }
      
      public function get playerVO() : PlayerVO
      {
         return _playerVO;
      }
      
      public function set playerVO(param1:PlayerVO) : void
      {
         _playerVO = param1;
      }
      
      public function get isShowName() : Boolean
      {
         return _isShowName;
      }
      
      public function set isShowName(param1:Boolean) : void
      {
         _isShowName = param1;
         if(!_spName)
         {
            return;
         }
         _spName.visible = _isShowName;
      }
      
      public function get isChatBall() : Boolean
      {
         return _isChatBall;
      }
      
      public function set isChatBall(param1:Boolean) : void
      {
         if(_isChatBall == param1 || !_chatBallView)
         {
            return;
         }
         _isChatBall = param1;
         if(_isChatBall)
         {
            addChildAt(_chatBallView,this.getChildIndex(character) + 1);
         }
         else if(_chatBallView && _chatBallView.parent)
         {
            _chatBallView.parent.removeChild(_chatBallView);
         }
      }
      
      public function get isShowPlayer() : Boolean
      {
         return _isShowPlayer;
      }
      
      public function set isShowPlayer(param1:Boolean) : void
      {
         if(_isShowPlayer == param1)
         {
            return;
         }
         _isShowPlayer = param1;
         this.visible = _isShowPlayer;
      }
      
      public function get sceneScene() : SceneScene
      {
         return _sceneScene;
      }
      
      public function set sceneScene(param1:SceneScene) : void
      {
         _sceneScene = param1;
      }
      
      public function get ID() : int
      {
         return _playerVO.playerInfo.ID;
      }
      
      override public function dispose() : void
      {
         removeEventListener("characterDirectionChange",characterDirectionChange);
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         if(_robertCollectTimer)
         {
            _robertCollectTimer.removeEventListener("timer",__robertCollectCompleteHandler);
            _robertCollectTimer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_robertCollectTimer);
            _robertCollectTimer = null;
         }
         _sceneScene = null;
         if(_lblName && _lblName.parent)
         {
            _lblName.parent.removeChild(_lblName);
         }
         _lblName = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         if(_chatBallView)
         {
            _chatBallView.clear();
            if(_chatBallView.parent)
            {
               _chatBallView.parent.removeChild(_chatBallView);
            }
            _chatBallView.dispose();
         }
         _chatBallView = null;
         if(_face)
         {
            _face.clearFace();
            if(_face.parent)
            {
               _face.parent.removeChild(_face);
            }
            _face.dispose();
         }
         _face = null;
         if(_vipIcon)
         {
            _vipIcon.dispose();
         }
         _vipIcon = null;
         if(_playerVO)
         {
            _playerVO.dispose();
         }
         _playerVO = null;
         if(_spName && _spName.parent)
         {
            _spName.parent.removeChild(_spName);
         }
         _spName = null;
         super.dispose();
      }
   }
}
