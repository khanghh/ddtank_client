package hotSpring.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.Helpers;
   import ddt.view.FaceContainer;
   import ddt.view.chat.ChatData;
   import ddt.view.chat.ChatEvent;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Sprite;
   import flash.geom.Point;
   import hotSpring.event.HotSpringRoomPlayerEvent;
   import hotSpring.view.HotSpringRoomView;
   import hotSpring.vo.PlayerVO;
   import vip.VipController;
   
   public class HotSpringPlayer extends HotSpringPlayerBase
   {
       
      
      private var _playerVO:PlayerVO;
      
      private var _wavePlayerAsset:ScaleFrameImage;
      
      private var _inWaterShowAsset:ScaleFrameImage;
      
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
      
      private var _currentWalkStartPoint:Point;
      
      public function HotSpringPlayer(param1:PlayerVO, param2:Function = null)
      {
         _playerVO = param1;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(_playerVO.playerInfo,param2);
         initialize();
         setEvent();
      }
      
      private function initialize() : void
      {
         moveSpeed = _playerVO.playerMoveSpeed;
         initPlayerName();
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
         _face = new FaceContainer(true);
         _face.x = (playerWitdh - _face.width) / 2 - playerWitdh / 2;
         _face.y = -90;
         addChild(_face);
      }
      
      private function initPlayerName() : void
      {
         var _loc1_:int = 0;
         if(!playerVO.playerInfo)
         {
            return;
         }
         if(_isShowName)
         {
            if(!_lblName)
            {
               _lblName = ComponentFactory.Instance.creat("asset.hotSpring.room.playerNickName");
            }
            _lblName.mouseEnabled = false;
            _lblName.text = playerVO && playerVO.playerInfo && playerVO.playerInfo.NickName?playerVO.playerInfo.NickName:"";
            if(_spName && _spName.parent)
            {
               removeChild(_spName);
            }
            _spName = null;
            _spName = new Sprite();
            if(playerVO.playerInfo.IsVIP)
            {
               if(!_vipName)
               {
                  _vipName = VipController.instance.getVipNameTxt(-1,playerVO.playerInfo.typeVIP);
               }
               _vipName.textSize = 16;
               _vipName.x = _lblName.x;
               _vipName.y = _lblName.y;
               _vipName.text = _lblName.text;
               _spName.addChild(_vipName);
               _lblName.visible = false;
               _vipName.visible = true;
            }
            else
            {
               _spName.addChild(_lblName);
               _lblName.visible = true;
               if(_vipName)
               {
                  _vipName.visible = false;
               }
               if(_vipIcon)
               {
                  _vipIcon.visible = false;
               }
            }
            if(playerVO.playerInfo.IsVIP && !_vipIcon)
            {
               _vipIcon = ComponentFactory.Instance.creatCustomObject("asset.hotSpring.VipIcon");
               if(playerVO.playerInfo.typeVIP >= 2)
               {
                  _vipIcon.y = _vipIcon.y - 5;
               }
               _vipIcon.setInfo(playerVO.playerInfo,false);
            }
            if(playerVO.playerInfo.IsVIP && _vipIcon)
            {
               _vipIcon.visible = true;
               _spName.addChild(_vipIcon);
               if(_vipName)
               {
                  _vipName.x = _vipIcon.x + _vipIcon.width;
               }
            }
            _spName.x = (playerWitdh - _spName.width) / 2 - playerWitdh / 2;
            _spName.y = -playerHeight + 10;
            _spName.graphics.beginFill(0,0.5);
            _loc1_ = playerVO.playerInfo.IsVIP && _vipIcon?_lblName.textWidth + _vipIcon.width:Number(_lblName.textWidth + 8);
            if(playerVO.playerInfo.IsVIP)
            {
               _loc1_ = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_vipName.width + 8);
               _spName.x = (playerWitdh - (_vipIcon.width + _vipName.width)) / 2 - playerWitdh / 2;
            }
            _spName.graphics.drawRoundRect(-4,0,_loc1_,22,5,5);
            _spName.graphics.endFill();
            addChild(_spName);
         }
         else
         {
            if(_spName)
            {
               ObjectUtils.disposeObject(_spName);
            }
            _spName = null;
            if(_vipName)
            {
               ObjectUtils.disposeObject(_vipName);
            }
            _vipName = null;
            if(_lblName)
            {
               ObjectUtils.disposeObject(_lblName);
            }
            _lblName = null;
            if(_vipIcon)
            {
               ObjectUtils.disposeObject(_vipIcon);
            }
            _vipIcon = null;
         }
      }
      
      private function setEvent() : void
      {
         addEventListener("characterDirectionChange",characterDirectionChange);
         _playerVO.addEventListener("playerPosChange",__onplayerPosChangeImp);
         ChatManager.Instance.model.addEventListener("addChat",__getChat);
         ChatManager.Instance.addEventListener("addFace",__getFace);
         _playerVO.playerInfo.addEventListener("propertychange",__changeHandler);
      }
      
      private function __changeHandler(param1:PlayerPropertyEvent) : void
      {
         if(!_playerVO)
         {
            return;
         }
         initPlayerName();
      }
      
      private function __onplayerPosChangeImp(param1:HotSpringRoomPlayerEvent) : void
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
               else
               {
                  sceneCharacterActionType = "waterBack";
               }
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               if(sceneCharacterStateType == "natural")
               {
                  sceneCharacterActionType = "naturalWalkFront";
               }
               else
               {
                  sceneCharacterActionType = "waterFront";
               }
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandBack";
            }
            else
            {
               sceneCharacterActionType = "waterStandBack";
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandFront";
            }
            else
            {
               sceneCharacterActionType = "waterFrontEyes";
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
            else
            {
               sceneCharacterActionType = "waterStandBack";
            }
         }
         else if(param1 == SceneCharacterDirection.LB || param1 == SceneCharacterDirection.RB)
         {
            if(sceneCharacterStateType == "natural")
            {
               sceneCharacterActionType = "naturalStandFront";
            }
            else
            {
               sceneCharacterActionType = "waterFrontEyes";
            }
         }
      }
      
      public function updatePlayer() : void
      {
         areaTest();
         characterMirror();
         setPlayer();
         playerWalkPath();
         update();
      }
      
      private function characterMirror() : void
      {
         if(character)
         {
            character.scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            character.x = !!sceneCharacterDirection.isMirror?playerWitdh / 2:Number(-playerWitdh / 2);
            character.y = _playerVO.currentlyArea == 1?-playerHeight + 12:Number(-playerHeight + 63);
         }
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
         if(_playerVO)
         {
            playerWalk(_playerVO.walkPath);
         }
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
      
      private function setPlayer() : void
      {
         if(_playerVO)
         {
            if(_playerVO.currentlyArea == 2)
            {
               if(!_wavePlayerAsset)
               {
                  _wavePlayerAsset = ComponentFactory.Instance.creat("hotSpring.room.wavePlayerAsset");
                  _wavePlayerAsset.setFrame(_wavePlayerAsset.getFrame + 1);
                  _wavePlayerAsset.y = -playerHeight + 103;
               }
               if(!_wavePlayerAsset.parent)
               {
                  addChild(_wavePlayerAsset);
               }
               if(_wavePlayerAsset.getFrame >= _wavePlayerAsset.totalFrames)
               {
                  _wavePlayerAsset.setFrame(1);
               }
               _wavePlayerAsset.setFrame(_wavePlayerAsset.getFrame + 1);
               if(sceneCharacterDirection.isMirror)
               {
                  _wavePlayerAsset.scaleX = !!_playerVO.playerInfo.Sex?-1.1:-1;
                  if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
                  {
                     _wavePlayerAsset.x = !!_playerVO.playerInfo.Sex?playerWitdh / 2 + 4:Number(playerWitdh / 2 - 2);
                  }
                  else
                  {
                     _wavePlayerAsset.x = !!_playerVO.playerInfo.Sex?playerWitdh / 2 + 4:Number(playerWitdh / 2);
                  }
               }
               else
               {
                  _wavePlayerAsset.scaleX = !!_playerVO.playerInfo.Sex?1.1:1;
                  if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
                  {
                     _wavePlayerAsset.x = !!_playerVO.playerInfo.Sex?-playerWitdh / 2 - 4:Number(-playerWitdh / 2 + 2);
                  }
                  else
                  {
                     _wavePlayerAsset.x = !!_playerVO.playerInfo.Sex?-playerWitdh / 2 - 4:Number(-playerWitdh / 2);
                  }
               }
               if(_inWaterShowAsset)
               {
                  _inWaterShowAsset.y = -playerHeight + 63;
               }
               if(_spName)
               {
                  _spName.y = -playerHeight + 63;
               }
               if(_face)
               {
                  _face.y = -38;
               }
               if(_chatBallView)
               {
                  _chatBallView.y = -playerHeight + 90;
               }
               addChildAt(_chatBallView,numChildren);
            }
            else
            {
               if(_wavePlayerAsset)
               {
                  if(_wavePlayerAsset.parent)
                  {
                     _wavePlayerAsset.parent.removeChild(_wavePlayerAsset);
                  }
                  _wavePlayerAsset.setFrame(1);
               }
               if(_inWaterShowAsset)
               {
                  _inWaterShowAsset.y = -playerHeight;
               }
               if(_spName)
               {
                  _spName.y = -playerHeight + 10;
               }
               if(_face)
               {
                  _face.y = -90;
               }
               if(_chatBallView)
               {
                  _chatBallView.y = -playerHeight + 40;
               }
               addChildAt(_chatBallView,numChildren);
            }
         }
      }
      
      private function areaTest() : void
      {
         if(!HotSpringRoomView || !_playerVO)
         {
            return;
         }
         var _loc1_:int = HotSpringRoomView.getCurrentAreaType(x,y);
         if(_loc1_ != _playerVO.currentlyArea)
         {
            playChangeStateMovie();
         }
         else
         {
            checkHidePlayerStageChangeMovie();
         }
         _playerVO.currentlyArea = _loc1_;
         refreshCharacterState();
      }
      
      private function playChangeStateMovie() : void
      {
         if(_inWaterShowAsset)
         {
            ObjectUtils.disposeObject(_inWaterShowAsset);
            _inWaterShowAsset = null;
         }
         character.visible = false;
         if(_spName)
         {
            _spName.visible = false;
         }
         _face.visible = false;
         if(_chatBallView && _chatBallView.parent)
         {
            _chatBallView.parent.removeChild(_chatBallView);
         }
         _inWaterShowAsset = ComponentFactory.Instance.creat("hotSpring.room.inWaterAsset");
         _inWaterShowAsset.x = -(playerWitdh / 2);
         _inWaterShowAsset.y = -playerHeight;
         addChild(_inWaterShowAsset);
      }
      
      private function checkHidePlayerStageChangeMovie() : void
      {
         if(_inWaterShowAsset)
         {
            _inWaterShowAsset.setFrame(_inWaterShowAsset.getFrame + 1);
            if(_inWaterShowAsset.getFrame >= _inWaterShowAsset.totalFrames)
            {
               showPlayer();
               ObjectUtils.disposeObject(_inWaterShowAsset);
               _inWaterShowAsset = null;
            }
         }
      }
      
      public function refreshCharacterState() : void
      {
         if(_playerVO.currentlyArea == 1)
         {
            sceneCharacterStateType = "natural";
            if((sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT) && _tween.isPlaying)
            {
               sceneCharacterActionType = "naturalWalkBack";
            }
            else if((sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB) && _tween.isPlaying)
            {
               sceneCharacterActionType = "naturalWalkFront";
            }
         }
         else
         {
            sceneCharacterStateType = "water";
            if((sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT) && _tween.isPlaying)
            {
               sceneCharacterActionType = "waterBack";
            }
            else if((sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB) && _tween.isPlaying)
            {
               sceneCharacterActionType = "waterFront";
            }
         }
         moveSpeed = _playerVO.playerMoveSpeed;
      }
      
      private function showPlayer() : void
      {
         if(_playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            character.visible = true;
         }
         else
         {
            character.visible = _isShowPlayer;
         }
         initPlayerName();
         _face.visible = true;
         if(_isChatBall)
         {
            addChildAt(_chatBallView,0);
         }
         else if(_chatBallView && _chatBallView.parent)
         {
            _chatBallView.parent.removeChild(_chatBallView);
         }
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
         initPlayerName();
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
            addChildAt(_chatBallView,0);
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
      
      override public function dispose() : void
      {
         removeEventListener("characterDirectionChange",characterDirectionChange);
         ChatManager.Instance.model.removeEventListener("addChat",__getChat);
         ChatManager.Instance.removeEventListener("addFace",__getFace);
         if(_playerVO)
         {
            _playerVO.removeEventListener("playerPosChange",__onplayerPosChangeImp);
         }
         if(_playerVO && _playerVO.playerInfo)
         {
            _playerVO.playerInfo.removeEventListener("propertychange",__changeHandler);
         }
         _sceneScene = null;
         ObjectUtils.disposeObject(_inWaterShowAsset);
         _inWaterShowAsset = null;
         ObjectUtils.disposeObject(_wavePlayerAsset);
         _wavePlayerAsset = null;
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
         ObjectUtils.disposeObject(_lblName);
         _lblName = null;
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         if(_spName && _spName.parent)
         {
            _spName.parent.removeChild(_spName);
         }
         _spName = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
