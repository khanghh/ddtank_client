package worldboss.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.ChatManager;
   import ddt.utils.Helpers;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import hall.player.HallPlayerBase;
   import vip.VipController;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.event.WorldBossScenePlayerEvent;
   
   public class WorldRoomPlayer extends HallPlayerBase
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
      
      private var _fightIcon:MovieClip;
      
      private var _tombstone:MovieClip;
      
      private var _isReadyFight:Boolean;
      
      private var _isInitialized:Boolean = false;
      
      private var _walkSpeed:Number;
      
      private var _currentWalkStartPoint:Point;
      
      public function WorldRoomPlayer(playerVO:PlayerVO, callBack:Function = null)
      {
         _playerVO = playerVO;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(playerVO.playerInfo,callBack);
         initialize();
         setPlayerWalkSpeed();
      }
      
      private function setPlayerWalkSpeed() : void
      {
         if(_playerVO.playerInfo.MountsType > 0)
         {
            _walkSpeed = 0.25;
         }
         else
         {
            _walkSpeed = 0.15;
         }
      }
      
      public function get isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      public function set isInitialized(value:Boolean) : void
      {
         _isInitialized = value;
      }
      
      private function initialize() : void
      {
         var spWidth:int = 0;
         moveSpeed = _playerVO.playerMoveSpeed;
         if(_isChatBall)
         {
            if(!_chatBallView)
            {
               _chatBallView = new ChatBallPlayer();
            }
            _chatBallView.x = (playerWidth - _chatBallView.width) / 2 - playerWidth / 2;
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
         if(_isShowName)
         {
            if(!_lblName)
            {
               _lblName = ComponentFactory.Instance.creat("asset.worldbossroom.characterPlayerNameAsset");
            }
            _lblName.mouseEnabled = false;
            _lblName.text = playerVO && playerVO.playerInfo && playerVO.playerInfo.NickName?playerVO.playerInfo.NickName:"";
            _lblName.textColor = 6029065;
            if(!_spName)
            {
               _spName = new Sprite();
            }
            if(playerVO.playerInfo.IsVIP)
            {
               _vipName = VipController.instance.getVipNameTxt(-1,playerVO.playerInfo.typeVIP);
               _vipName.textSize = 16;
               _vipName.x = _lblName.x;
               _vipName.y = _lblName.y;
               _vipName.text = _lblName.text;
               _spName.addChild(_vipName);
               DisplayUtils.removeDisplay(_lblName);
            }
            else
            {
               _spName.addChild(_lblName);
               DisplayUtils.removeDisplay(_vipName);
            }
            if(playerVO.playerInfo.IsVIP && !_vipIcon)
            {
               _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.worldboss.VipIcon");
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
            _spName.x = (playerWidth - _spName.width) / 2 - playerWidth / 2;
            _spName.y = -playerHeight;
            _spName.graphics.beginFill(0,0.5);
            spWidth = !!_vipIcon?_lblName.textWidth + _vipIcon.width:Number(_lblName.textWidth + 8);
            if(playerVO.playerInfo.IsVIP)
            {
               spWidth = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_vipName.width + 8);
               _spName.x = (playerWidth - (_vipIcon.width + _vipName.width)) / 2 - playerWidth / 2;
            }
            _spName.graphics.drawRoundRect(-4,0,spWidth,22,5,5);
            _spName.graphics.endFill();
            addChildAt(_spName,0);
            _spName.visible = _isShowName;
         }
         else
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = null;
            ObjectUtils.disposeObject(_lblName);
            _lblName = null;
         }
         _face = new FaceContainer(true);
         _face.x = (playerWidth - _face.width) / 2 - playerWidth / 2;
         _face.y = -90;
         addChild(_face);
         _fightIcon = ComponentFactory.Instance.creat("asset.worldBoss.fighting");
         addChild(_fightIcon);
         _fightIcon.visible = false;
         _fightIcon.gotoAndStop(1);
         _tombstone = ComponentFactory.Instance.creat("asset.worldBoos.tombstone");
         addChild(_tombstone);
         _tombstone.visible = false;
         _tombstone.gotoAndStop(1);
         setStatus();
         setEvent();
         isInitialized = true;
      }
      
      public function setStatus() : void
      {
         switch(int(_playerVO.playerStauts) - 1)
         {
            case 0:
               this.character.visible = true;
               _fightIcon.visible = false;
               _fightIcon.gotoAndStop(1);
               _tombstone.visible = false;
               _spName.y = -playerHeight;
               _tombstone.gotoAndStop(1);
               break;
            case 1:
               this.character.visible = true;
               _fightIcon.visible = true;
               _fightIcon.gotoAndPlay(1);
               _tombstone.visible = false;
               _spName.y = -playerHeight;
               _tombstone.gotoAndStop(1);
               break;
            case 2:
               this.character.visible = false;
               _fightIcon.visible = false;
               _fightIcon.gotoAndStop(1);
               _tombstone.visible = true;
               _tombstone.gotoAndPlay(1);
               _spName.y = -playerHeight + 75;
         }
      }
      
      public function revive() : void
      {
         this.character.visible = true;
         _fightIcon.visible = false;
         _fightIcon.gotoAndStop(1);
         _tombstone.visible = false;
         _spName.y = -playerHeight;
         _tombstone.gotoAndStop(1);
         var effot:MovieClip = ComponentFactory.Instance.creat("asset.worldboss.resurrect");
         effot.addEventListener("complete",__reviveComplete);
         addChildAt(effot,0);
      }
      
      private function __reviveComplete(e:Event) : void
      {
         var effot:MovieClip = e.currentTarget as MovieClip;
         effot.parent.removeChild(effot);
         effot = null;
      }
      
      private function setEvent() : void
      {
         addEventListener("characterDirectionChange",characterDirectionChange);
         _playerVO.addEventListener("playerPosChange",__onplayerPosChangeImp);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ChatManager.Instance.addEventListener("addFace",__getFace);
      }
      
      private function __onplayerPosChangeImp(event:WorldBossScenePlayerEvent) : void
      {
         playerPoint = _playerVO.playerPos;
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
            if(isReadyFight)
            {
               dispatchEvent(new WorldBossRoomEvent("readyFight"));
            }
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
         if(!isDefaultCharacter)
         {
            this.character.scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            this.character.x = !!sceneCharacterDirection.isMirror?playerWidth / 2:Number(-playerWidth / 2);
         }
         else
         {
            this.character.scaleX = 1;
            this.character.x = -playerWidth / 2;
         }
         this.character.y = -playerHeight + 12;
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
         if(_walkPath && _walkPath.length > 0)
         {
            _currentWalkStartPoint = _walkPath[0];
            sceneCharacterDirection = setPlayerDirection();
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",true));
            dis = Point.distance(_currentWalkStartPoint,playerPoint);
            _tween.start(dis / _walkSpeed,"x",_currentWalkStartPoint.x,"y",_currentWalkStartPoint.y);
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      private function setPlayerDirection() : SceneCharacterDirection
      {
         var direction:* = null;
         direction = SceneCharacterDirection.getDirection(playerPoint,_currentWalkStartPoint);
         if(_playerVO.playerInfo.IsMounts)
         {
            if(direction == SceneCharacterDirection.LT)
            {
               direction = SceneCharacterDirection.LB;
            }
            else if(direction == SceneCharacterDirection.RT)
            {
               direction = SceneCharacterDirection.RB;
            }
         }
         return direction;
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
      
      private function playChangeStateMovie() : void
      {
         this.character.visible = false;
         _spName.visible = false;
         _face.visible = false;
         if(_chatBallView && _chatBallView.parent)
         {
            _chatBallView.parent.removeChild(_chatBallView);
         }
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
         if(_isShowPlayer == value || !_isShowPlayer)
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
      
      public function get isReadyFight() : Boolean
      {
         return _isReadyFight;
      }
      
      public function set isReadyFight(value:Boolean) : void
      {
         _isReadyFight = value;
      }
      
      public function getCanAction() : Boolean
      {
         return !_tombstone.visible;
      }
      
      override public function dispose() : void
      {
         removeEventListener("characterDirectionChange",characterDirectionChange);
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         if(_playerVO)
         {
            _playerVO.removeEventListener("playerPosChange",__onplayerPosChangeImp);
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
         if(_fightIcon && _fightIcon.parent)
         {
            _fightIcon.parent.removeChild(_fightIcon);
         }
         _fightIcon = null;
         if(_tombstone && _tombstone.parent)
         {
            _tombstone.parent.removeChild(_tombstone);
         }
         _tombstone = null;
         super.dispose();
      }
   }
}
