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
      
      public function CollectionTaskPlayer(playerVO:PlayerVO, callBack:Function = null)
      {
         _playerVO = playerVO;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(playerVO.playerInfo,callBack);
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
         var spWidth:int = !!_vipIcon?_lblName.textWidth + _vipIcon.width:Number(_lblName.textWidth + 8);
         if(playerVO.playerInfo.IsVIP)
         {
            spWidth = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_vipName.width + 8);
            _spName.x = (playerWitdh - (_vipIcon.width + _vipName.width)) / 2 - playerWitdh / 2;
         }
         _spName.graphics.drawRoundRect(-4,0,spWidth,22,5,5);
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
      
      public function walk(p:Point, fun:Function = null) : void
      {
         if(!_sceneScene)
         {
            return;
         }
         _destinationPos = p;
         playerVO.walkPath = _sceneScene.searchPath(playerPoint,p);
         playerVO.walkPath.shift();
         playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(playerPoint,playerVO.walkPath[0]);
         playerVO.currentWalkStartPoint = currentWalkStartPoint;
         isWalkPathChange = true;
         _walkOverHander = fun;
      }
      
      public function robertWalk(vector:Vector.<Point>) : void
      {
         _robertWalkVector = vector;
         walk(_robertWalkVector[int(Math.random() * 5)]);
      }
      
      private function characterDirectionChange(evt:SceneCharacterEvent) : void
      {
         _playerVO.scenePlayerDirection = sceneCharacterDirection;
         if(evt.data)
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
      
      protected function __robertCollectCompleteHandler(event:Event) : void
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
      
      public function set setSceneCharacterDirectionDefault(value:SceneCharacterDirection) : void
      {
         if(value == SceneCharacterDirection.LT || value == SceneCharacterDirection.RT)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandBack";
            }
         }
         else if(value == SceneCharacterDirection.LB || value == SceneCharacterDirection.RB)
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
         var tmpSprite:Sprite = character;
         if(!isDefaultCharacter)
         {
            tmpSprite.scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            tmpSprite.x = !!sceneCharacterDirection.isMirror?playerWitdh / 2:Number(-playerWitdh / 2);
         }
         else
         {
            tmpSprite.scaleX = 1;
            tmpSprite.x = -playerWitdh / 2;
         }
         tmpSprite.y = -playerHeight + 12;
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
      
      override public function playerWalk(walkPath:Array) : void
      {
         var dis:Number = NaN;
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
            dis = Point.distance(_currentWalkStartPoint,playerPoint);
            _tween.start(dis / _moveSpeed,"x",_currentWalkStartPoint.x,"y",_currentWalkStartPoint.y);
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      private function fixPlayerPath() : void
      {
         var i:int = 0;
         var lastPath:* = null;
         if(_playerVO.currentWalkStartPoint == null)
         {
            return;
         }
         var startPointIndex:* = -1;
         for(i = 0; i < _walkPath.length; )
         {
            if(_walkPath[i].x == _playerVO.currentWalkStartPoint.x && _walkPath[i].y == _playerVO.currentWalkStartPoint.y)
            {
               startPointIndex = i;
               break;
            }
            i++;
         }
         if(startPointIndex > 0)
         {
            lastPath = _walkPath.slice(0,startPointIndex);
            _playerVO.walkPath = lastPath.concat(_playerVO.walkPath);
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
      
      private function __getChat(evt:ChatEvent) : void
      {
         if(!_isChatBall || !evt.data)
         {
            return;
         }
         var data:ChatData = ChatData(evt.data).clone();
         if(!data)
         {
            return;
         }
         data.msg = Helpers.deCodeString(data.msg);
         if(data.channel == 2 || data.channel == 3)
         {
            return;
         }
         if(data && _playerVO.playerInfo && data.senderID == _playerVO.playerInfo.ID)
         {
            _chatBallView.setText(data.msg,_playerVO.playerInfo.paopaoType);
            if(!_chatBallView.parent)
            {
               addChildAt(_chatBallView,this.getChildIndex(character) + 1);
            }
         }
      }
      
      private function __getFace(evt:ChatEvent) : void
      {
         var data:Object = evt.data;
         if(data["playerid"] == _playerVO.playerInfo.ID)
         {
            _face.setFace(data["faceid"]);
         }
      }
      
      public function get playerVO() : PlayerVO
      {
         return _playerVO;
      }
      
      public function set playerVO(value:PlayerVO) : void
      {
         _playerVO = value;
      }
      
      public function get isShowName() : Boolean
      {
         return _isShowName;
      }
      
      public function set isShowName(value:Boolean) : void
      {
         _isShowName = value;
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
      
      public function set isChatBall(value:Boolean) : void
      {
         if(_isChatBall == value || !_chatBallView)
         {
            return;
         }
         _isChatBall = value;
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
      
      public function set isShowPlayer(value:Boolean) : void
      {
         if(_isShowPlayer == value)
         {
            return;
         }
         _isShowPlayer = value;
         this.visible = _isShowPlayer;
      }
      
      public function get sceneScene() : SceneScene
      {
         return _sceneScene;
      }
      
      public function set sceneScene(value:SceneScene) : void
      {
         _sceneScene = value;
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
