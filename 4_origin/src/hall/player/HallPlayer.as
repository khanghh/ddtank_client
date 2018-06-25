package hall.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import road7th.DDTAssetManager;
   import vip.VipController;
   
   public class HallPlayer extends HallPlayerBase
   {
       
      
      private var _playerVO:PlayerVO;
      
      private var _currentWalkStartPoint:Point;
      
      private var _spName:Sprite;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _sceneScene:SceneScene;
      
      private var _badgeSprite:Sprite;
      
      private var _badge:Badge;
      
      private var _consortiaName:FilterFrameText;
      
      private var _titleSprite:Sprite;
      
      private var _title:Bitmap;
      
      private var _walkSpeed:Number;
      
      private var isHiedTitle:Boolean;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _posTimer:Timer;
      
      private var _randomPathX:int;
      
      private var _randomPathY:int;
      
      private var _randomPathMap:Object;
      
      public function HallPlayer(playerVO:PlayerVO, callBack:Function = null)
      {
         _playerVO = playerVO;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(playerVO.playerInfo,callBack);
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
      
      public function showPlayerInfo(petsDis:int) : void
      {
         showVipName();
      }
      
      public function showVipName() : void
      {
         var name:String = playerVO && playerVO.playerInfo && playerVO.playerInfo.NickName?playerVO.playerInfo.NickName:"";
         moveSpeed = _playerVO.playerMoveSpeed;
         if(!_spName)
         {
            _spName = new Sprite();
         }
         addChildAt(_spName,0);
         if(playerVO.playerInfo.IsVIP)
         {
            if(!_vipName)
            {
               _vipName = VipController.instance.getVipNameTxt(-1,playerVO.playerInfo.typeVIP);
               _vipName.textSize = 16;
               _vipName.text = name;
            }
            _spName.addChild(_vipName);
            DisplayUtils.removeDisplay(_lblName);
            if(!_vipIcon)
            {
               _vipIcon = new VipLevelIcon();
               if(playerVO.playerInfo.typeVIP >= 2)
               {
                  _vipIcon.y = _vipIcon.y - 5;
               }
               _vipIcon.setInfo(playerVO.playerInfo,false);
               _spName.addChild(_vipIcon);
               _vipName.x = _vipIcon.x + _vipIcon.width;
            }
         }
         else
         {
            if(!_lblName)
            {
               _lblName = ComponentFactory.Instance.creat("asset.hall.playerInfo.lblName");
               _lblName.mouseEnabled = false;
               _lblName.text = name;
            }
            _spName.addChild(_lblName);
            DisplayUtils.removeDisplay(_vipName);
         }
         var spWidth:int = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_lblName.textWidth + 8);
         _spName.graphics.beginFill(0,0.5);
         _spName.graphics.drawRoundRect(-4,0,spWidth,22,5,5);
         _spName.graphics.endFill();
         _spName.x = -spWidth / 2;
         _spName.y = -playerHeight;
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(playerVO.playerInfo.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _attestBtn.buttonMode = true;
            _spName.addChild(_attestBtn);
            if(playerVO.playerInfo.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _lblName.x + _lblName.width;
               _attestBtn.y = _lblName.y;
            }
         }
      }
      
      public function showPlayerTitle() : void
      {
         var titleModel:* = null;
         removePlayerTitle();
         if(_playerVO.playerInfo.IsShowConsortia && _playerVO.playerInfo.ConsortiaID > 0)
         {
            if(!_badgeSprite)
            {
               _badgeSprite = new Sprite();
               _badgeSprite.y = -playerHeight - 40;
               addChild(_badgeSprite);
            }
            if(_playerVO.playerInfo.badgeID > 0 && !_badge)
            {
               _badge = new Badge();
               _badge.badgeID = _playerVO.playerInfo.badgeID;
               _badgeSprite.addChild(_badge);
            }
            if(!_consortiaName)
            {
               _consortiaName = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.consortiaName");
               _consortiaName.text = _playerVO.playerInfo.ConsortiaName;
               if(_badge)
               {
                  _consortiaName.x = 32;
               }
               _badgeSprite.addChild(_consortiaName);
            }
            _badgeSprite.x = -_badgeSprite.width / 2;
         }
         else if(_playerVO.playerInfo.honor.length > 0)
         {
            titleModel = NewTitleManager.instance.titleInfo[_playerVO.playerInfo.honorId];
            if(titleModel && titleModel.Show != "0" && titleModel.Pic != "0")
            {
               loadIcon(titleModel.Pic);
            }
         }
      }
      
      private function loadIcon(pic:String) : void
      {
         var bmd:BitmapData = DDTAssetManager.instance.nativeAsset.getBitmapData("image_title_" + pic);
         setTitleSprite(bmd);
      }
      
      private function setTitleSprite(bitmapdata:BitmapData) : void
      {
         if(_spName)
         {
            _titleSprite = new Sprite();
            if(bitmapdata)
            {
               _title = new Bitmap(bitmapdata);
               _titleSprite.addChild(_title);
            }
            _titleSprite.x = -_titleSprite.width / 2;
            _titleSprite.y = _spName.y - _titleSprite.height;
            _titleSprite.visible = !isHiedTitle;
            addChild(_titleSprite);
         }
      }
      
      public function removePlayerTitle() : void
      {
         if(_badgeSprite)
         {
            ObjectUtils.disposeAllChildren(_badgeSprite);
            _badge = null;
            _consortiaName = null;
            _badgeSprite = null;
         }
         if(_titleSprite)
         {
            ObjectUtils.disposeAllChildren(_titleSprite);
            _titleSprite = null;
            _title = null;
         }
      }
      
      override protected function __onMouseClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         event.stopPropagation();
         if(!_playerVO.playerInfo.isSelf)
         {
            _playerVO.opposePos = this.parent.localToGlobal(new Point(this.x,this.y));
            PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[_playerVO]));
         }
      }
      
      private function characterDirectionChange(actionFlag:Boolean) : void
      {
         _playerVO.scenePlayerDirection = sceneCharacterDirection;
         if(actionFlag)
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
            dispatchEvent(new NewHallEvent("newhallbtnclick"));
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
      
      public function updatePlayer() : void
      {
         refreshCharacterState();
         characterMirror();
         playerWalkPath();
         update();
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
      
      private function characterMirror() : void
      {
         var height:int = playerHeight;
         if(!isDefaultCharacter)
         {
            this.character.scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            this.character.x = !!sceneCharacterDirection.isMirror?playerWidth / 2:Number(-playerWidth / 2);
            this.playerHitArea.scaleX = this.character.scaleX;
            this.playerHitArea.x = this.character.x;
         }
         else
         {
            this.character.scaleX = 1;
            this.character.x = -60;
            this.playerHitArea.scaleX = 1;
            this.playerHitArea.x = this.character.x;
            height = 175;
         }
         this.character.y = -height + 12;
         this.playerHitArea.y = this.character.y;
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
         var dirction:* = null;
         var dis:Number = NaN;
         if(_walkPath != null && _tween.isPlaying && _walkPath == _playerVO.walkPath)
         {
            return;
         }
         _walkPath = _playerVO.walkPath;
         if(_walkPath && _walkPath.length > 0)
         {
            _currentWalkStartPoint = _walkPath[0];
            dirction = setPlayerDirection();
            if(dirction != sceneCharacterDirection)
            {
               sceneCharacterDirection = dirction;
            }
            characterDirectionChange(true);
            dis = Point.distance(_currentWalkStartPoint,playerPoint);
            _tween.start(dis / _walkSpeed,"x",_currentWalkStartPoint.x,"y",_currentWalkStartPoint.y);
            _walkPath.shift();
         }
         else
         {
            characterDirectionChange(false);
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
      
      public function get playerVO() : PlayerVO
      {
         return _playerVO;
      }
      
      public function set playerVO(value:PlayerVO) : void
      {
         _playerVO = value;
      }
      
      public function get sceneScene() : SceneScene
      {
         return _sceneScene;
      }
      
      public function set sceneScene(value:SceneScene) : void
      {
         _sceneScene = value;
      }
      
      public function hideTitle(value:Boolean) : void
      {
         isHiedTitle = value;
         if(_spName)
         {
            _spName.visible = !isHiedTitle;
         }
         if(_lblName)
         {
            _lblName.visible = !isHiedTitle;
         }
         if(_vipName)
         {
            _vipName.visible = !isHiedTitle;
         }
         if(_vipIcon)
         {
            _vipIcon.visible = !isHiedTitle;
         }
         if(_badgeSprite)
         {
            _badgeSprite.visible = !isHiedTitle;
         }
         if(_badge)
         {
            _badge.visible = !isHiedTitle;
         }
         if(_consortiaName)
         {
            _consortiaName.visible = !isHiedTitle;
         }
         if(_titleSprite)
         {
            _titleSprite.visible = !isHiedTitle;
         }
         if(_title)
         {
            _title.visible = !isHiedTitle;
         }
      }
      
      public function startRandomWalk(randomPathX:int, randomPathY:int, randomPathMap:Object) : void
      {
         _randomPathMap = randomPathMap;
         _randomPathX = randomPathX;
         _randomPathY = randomPathY;
         _posTimer = new Timer(getRandomDelayTime(),1);
         _posTimer.addEventListener("timerComplete",onControlWalk);
         _posTimer.start();
      }
      
      private function onControlWalk(evt:TimerEvent) : void
      {
         var newStartPointIndex:int = 0;
         var newEndPointIndex:int = 0;
         var walkPath:* = null;
         if(_tween.isPlaying)
         {
            stopWalk();
         }
         else if(_walkPath == null || _walkPath.length == 0)
         {
            newStartPointIndex = playerVO.randomEndPointIndex;
            newEndPointIndex = getEndPointIndex(newStartPointIndex);
            playerVO.randomStartPointIndex = newStartPointIndex;
            playerVO.randomEndPointIndex = newEndPointIndex;
            walkPath = getPointPath(newStartPointIndex,newEndPointIndex);
            walkPath.unshift();
            playerVO.walkPath = walkPath;
            playerVO.currentWalkStartPoint = _currentWalkStartPoint;
         }
         _posTimer.reset();
         _posTimer.delay = getRandomDelayTime();
         _posTimer.repeatCount = 1;
         _posTimer.start();
      }
      
      private function getRandomDelayTime() : int
      {
         return 2000 + Math.random() * 2000;
      }
      
      private function getEndPointIndex(startPointIndex:int) : int
      {
         var dir:int = 0;
         var col:int = startPointIndex / _randomPathY;
         if(col == _randomPathX - 1)
         {
            dir = -1;
         }
         else if(col == 0)
         {
            dir = 1;
         }
         else
         {
            dir = Math.random() > 0.5?1:-1;
         }
         var newEndPointIndex:int = (col + dir) * _randomPathY + int(Math.random() * _randomPathY);
         return newEndPointIndex;
      }
      
      private function getPointPath(newStartPointIndex:int, newEndPointIndex:int) : Array
      {
         var path:* = null;
         var i:int = 0;
         var pointPath:Array = [];
         if(newStartPointIndex < newEndPointIndex)
         {
            path = _randomPathMap[newStartPointIndex + "_" + newEndPointIndex];
            for(i = 0; i < path.length / 2; )
            {
               pointPath.push(new Point(path[i * 2],path[i * 2 + 1]));
               i++;
            }
         }
         else
         {
            path = _randomPathMap[newEndPointIndex + "_" + newStartPointIndex];
            for(i = path.length / 2 - 1; i > -1; )
            {
               pointPath.push(new Point(path[i * 2],path[i * 2 + 1]));
               i--;
            }
         }
         return pointPath;
      }
      
      public function stopWalk() : void
      {
         characterDirectionChange(false);
         if(_walkPath)
         {
            _walkPath = [];
            _walkPath = [];
         }
         _playerVO.walkPath = _walkPath;
         _tween.stop();
      }
      
      override public function dispose() : void
      {
         stopWalk();
         _posTimer && _posTimer.removeEventListener("timerComplete",onControlWalk);
         _posTimer = null;
         _randomPathMap = null;
         if(_badge)
         {
            _badge.dispose();
            _badge = null;
            _badgeSprite = null;
         }
         if(_consortiaName)
         {
            _consortiaName.dispose();
            _consortiaName = null;
         }
         if(_playerVO)
         {
            _playerVO = null;
         }
         if(_currentWalkStartPoint)
         {
            _currentWalkStartPoint = null;
         }
         if(_spName)
         {
            ObjectUtils.disposeObject(_spName);
            _spName = null;
         }
         if(_lblName)
         {
            _lblName.dispose();
            _lblName = null;
         }
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         if(_vipIcon)
         {
            _vipIcon.dispose();
            _vipIcon = null;
         }
         if(_sceneScene)
         {
            _sceneScene.dispose();
            _sceneScene = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         removePlayerTitle();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      public function set walkSpeed(value:Number) : void
      {
         _walkSpeed = value;
      }
      
      public function get walkSpeed() : Number
      {
         return _walkSpeed;
      }
   }
}
