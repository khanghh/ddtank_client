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
      
      public function WorldRoomPlayer(param1:PlayerVO, param2:Function = null)
      {
         _playerVO = param1;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(param1.playerInfo,param2);
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
      
      public function set isInitialized(param1:Boolean) : void
      {
         _isInitialized = param1;
      }
      
      private function initialize() : void
      {
         var _loc1_:int = 0;
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
            _loc1_ = !!_vipIcon?_lblName.textWidth + _vipIcon.width:Number(_lblName.textWidth + 8);
            if(playerVO.playerInfo.IsVIP)
            {
               _loc1_ = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_vipName.width + 8);
               _spName.x = (playerWidth - (_vipIcon.width + _vipName.width)) / 2 - playerWidth / 2;
            }
            _spName.graphics.drawRoundRect(-4,0,_loc1_,22,5,5);
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
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.worldboss.resurrect");
         _loc1_.addEventListener("complete",__reviveComplete);
         addChildAt(_loc1_,0);
      }
      
      private function __reviveComplete(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.parent.removeChild(_loc2_);
         _loc2_ = null;
      }
      
      private function setEvent() : void
      {
         addEventListener("characterDirectionChange",characterDirectionChange);
         _playerVO.addEventListener("playerPosChange",__onplayerPosChangeImp);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ChatManager.Instance.addEventListener("addFace",__getFace);
      }
      
      private function __onplayerPosChangeImp(param1:WorldBossScenePlayerEvent) : void
      {
         playerPoint = _playerVO.playerPos;
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
      
      override public function playerWalk(param1:Array) : void
      {
         var _loc2_:Number = NaN;
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
            _loc2_ = Point.distance(_currentWalkStartPoint,playerPoint);
            _tween.start(_loc2_ / _walkSpeed,"x",_currentWalkStartPoint.x,"y",_currentWalkStartPoint.y);
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      private function setPlayerDirection() : SceneCharacterDirection
      {
         var _loc1_:* = null;
         _loc1_ = SceneCharacterDirection.getDirection(playerPoint,_currentWalkStartPoint);
         if(_playerVO.playerInfo.IsMounts)
         {
            if(_loc1_ == SceneCharacterDirection.LT)
            {
               _loc1_ = SceneCharacterDirection.LB;
            }
            else if(_loc1_ == SceneCharacterDirection.RT)
            {
               _loc1_ = SceneCharacterDirection.RB;
            }
         }
         return _loc1_;
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
         if(_isShowPlayer == param1 || !_isShowPlayer)
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
      
      public function get isReadyFight() : Boolean
      {
         return _isReadyFight;
      }
      
      public function set isReadyFight(param1:Boolean) : void
      {
         _isReadyFight = param1;
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
