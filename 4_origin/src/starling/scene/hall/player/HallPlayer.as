package starling.scene.hall.player
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import road7th.StarlingMain;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilter;
   import starling.scene.hall.event.NewHallEventStarling;
   import starling.text.TextField;
   import starlingui.core.text.TextLabel;
   
   public class HallPlayer extends HallPlayerBase
   {
      
      private static const HIT_WIDTH:int = 90;
      
      private static const HIT_HEIGHT:int = 140;
       
      
      protected var _playerVO:PlayerVO;
      
      private var _currentWalkStartPoint:Point;
      
      protected var _nameSprite:Sprite;
      
      private var _namePos:Point;
      
      protected var _titleSprite:Sprite;
      
      private var _titlePos:Point;
      
      private var _petFollow:BoneMovieFastStarling;
      
      private var _isHideTitle:Boolean;
      
      protected var _posTimer:Timer;
      
      private var _randomPathX:int;
      
      private var _randomPathY:int;
      
      private var _randomPathMap:Object;
      
      public function HallPlayer(param1:PlayerVO)
      {
         _playerVO = param1;
         _currentWalkStartPoint = _playerVO.playerPos;
         super(_playerVO);
         updatePlayerWalk();
         updatePlayerName();
         updateTitle();
         updatePetsFollow();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _characterTouch = new Quad(90,140,0);
         _characterTouch.alpha = 0;
         _characterTouch.useHandCursor = true;
         addChild(_characterTouch);
      }
      
      override protected function resetPlayerAsset() : void
      {
         super.resetPlayerAsset();
         updatePlayerWalk();
         updatePlayerLocal();
      }
      
      public function updatePlayer() : void
      {
         playerWalkPath();
         update();
      }
      
      private function updatePlayerWalk() : void
      {
         if(_playerVO.playerInfo.IsMounts)
         {
            _moveSpeed = 0.25;
         }
         else
         {
            _moveSpeed = 0.15;
         }
      }
      
      public function updatePlayerLocal(param1:Point = null) : void
      {
         var _loc2_:* = null;
         if(_isDefaultCharacter)
         {
            _loc2_ = HallPlayerPos.MOUNT_0;
         }
         else
         {
            _loc2_ = param1 || HallPlayerPos["MOUNT_" + _playerVO.playerInfo.MountsType];
         }
         _nameSprite.x = _namePos.x + _loc2_.x;
         _nameSprite.y = _namePos.y + _loc2_.y;
         _titleSprite.x = _titlePos.x + _loc2_.x;
         _titleSprite.y = _titlePos.y + _loc2_.y;
         _characterPlayer.x = _loc2_.x;
         _characterPlayer.y = _loc2_.y;
         if(_characterTouch)
         {
            _characterTouch.x = _loc2_.x + 15;
            _characterTouch.y = _loc2_.y + 15;
         }
         changeCharacterDirection();
      }
      
      public function updatePlayerName() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _loc3_ = null;
         var _loc5_:* = null;
         if(_nameSprite == null)
         {
            _namePos = new Point();
            _nameSprite = new Sprite();
            _nameSprite.touchable = false;
            _nameSprite.y = -4;
            addChild(_nameSprite);
         }
         else
         {
            StarlingObjectUtils.disposeAllChildren(_nameSprite);
         }
         var _loc6_:* = 0;
         var _loc4_:Sprite = new Sprite();
         _nameSprite.addChild(_loc4_);
         if(_playerVO.playerInfo.IsVIP)
         {
            _loc3_ = new TextLabel("asset.hall.playerInfo.lblNameVIP");
            _loc3_.text = _playerVO.playerInfo.NickName;
            _loc3_.x = 5;
            _nameSprite.addChild(_loc3_);
            _loc6_ = Number(_loc6_ + (_loc3_.width + 10));
            _loc1_ = "image_vipGrade_small" + _playerVO.playerInfo.VIPLevel;
            _loc2_ = StarlingMain.instance.createImage(_loc1_);
            _loc2_.x = 5;
            _loc2_.y = -10;
            _nameSprite.addChild(_loc2_);
            _loc3_.x = _loc2_.width + 5;
            _loc6_ = Number(_loc6_ + (_loc2_.width + 5));
         }
         else
         {
            _loc3_ = new TextLabel("asset.hall.playerInfo.lblName");
            _loc3_.text = _playerVO.playerInfo.NickName;
            _loc3_.x = 5;
            _nameSprite.addChild(_loc3_);
            _loc6_ = Number(_loc6_ + (_loc3_.width + 10));
         }
         if(playerVO.playerInfo.isAttest)
         {
            _loc5_ = StarlingMain.instance.createImage("image_player_girlAttest");
            _nameSprite.addChild(_loc5_);
            _loc5_.x = _loc6_;
            _loc5_.y = -5;
            _loc6_ = Number(_loc6_ + (_loc5_.width + 5));
         }
         _loc4_.graphics.beginFill(0,0.5);
         _loc4_.graphics.drawRect(0,0,_loc6_,20);
         _loc4_.graphics.endFill();
         _nameSprite.x = 60 - _loc6_ / 2;
         _namePos.setTo(_nameSprite.x,_nameSprite.y);
      }
      
      public function updateTitle() : void
      {
         var _loc5_:Number = NaN;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(_titleSprite == null)
         {
            _titlePos = new Point();
            _titleSprite = new Sprite();
            _titleSprite.touchable = false;
            addChild(_titleSprite);
         }
         else
         {
            StarlingObjectUtils.disposeAllChildren(_titleSprite);
         }
         if(!_isHideTitle)
         {
            return;
         }
         if(_playerVO.playerInfo.IsShowConsortia && _playerVO.playerInfo.ConsortiaID > 0)
         {
            _loc5_ = FilterFrameText.getStringWidthByTextField(_playerVO.playerInfo.ConsortiaName,13);
            _loc3_ = new TextField(_loc5_,20,_playerVO.playerInfo.ConsortiaName,"Arial",12,3002359,true);
            if(_playerVO.playerInfo.badgeID > 0)
            {
               _loc1_ = StarlingMain.instance.createImage("image_badge_" + _playerVO.playerInfo.badgeID);
               var _loc6_:int = 25;
               _loc1_.height = _loc6_;
               _loc1_.width = _loc6_;
               _titleSprite.addChild(_loc1_);
               _loc3_.x = 25;
            }
            _titleSprite.y = -30;
            _titleSprite.addChild(_loc3_);
         }
         else if(_playerVO.playerInfo.honor.length > 0)
         {
            _loc4_ = NewTitleManager.instance.titleInfo[_playerVO.playerInfo.honorId];
            if(_loc4_ && _loc4_.Show != "0" && _loc4_.Pic != "0")
            {
               _loc2_ = StarlingMain.instance.createImage("image_title_" + _loc4_.Pic);
               _titleSprite.y = -(_loc2_.height + 5);
               _titleSprite.addChild(_loc2_);
            }
         }
         _titleSprite.x = 60 - _titleSprite.width / 2;
         _titlePos.setTo(_titleSprite.x,_titleSprite.y);
      }
      
      public function get playerVO() : PlayerVO
      {
         return _playerVO;
      }
      
      override protected function __onTouch(param1:TouchEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         super.__onTouch(param1);
         var _loc2_:Touch = param1.getTouch(_characterTouch,"ended");
         if(_characterPlayer)
         {
            _loc4_ = _characterPlayer.filter;
            _loc4_ && _loc4_.dispose();
            if(param1.getTouch(_characterTouch,"hover"))
            {
               _characterPlayer.filter = BlurFilter.createGlow(16776960,1,8,0.5);
            }
            else
            {
               _characterPlayer.filter = null;
            }
         }
         if(_loc2_)
         {
            _loc3_ = _loc2_.getLocation(_characterTouch);
            if(_characterTouch.hitTest(_loc3_,true))
            {
               SoundManager.instance.playButtonSound();
               if(!_playerVO.playerInfo.isSelf)
               {
                  _playerVO.opposePos = this.parent.localToGlobal(new Point(this.x,this.y));
                  PlayerManager.Instance.dispatchEvent(new NewHallEvent("newhallsetplayertippos",[_playerVO]));
               }
            }
         }
      }
      
      public function get isHideTitle() : Boolean
      {
         return _isHideTitle;
      }
      
      public function set isHideTitle(param1:Boolean) : void
      {
         if(_isHideTitle != param1)
         {
            _isHideTitle = param1;
            updateTitle();
            updatePlayerLocal();
         }
      }
      
      override protected function __onStyleChange(param1:PlayerPropertyEvent) : void
      {
         if(_isDefaultCharacter)
         {
            return;
         }
         if(param1.changedProperties["petsID"])
         {
            updatePetsFollow();
         }
         if(param1.changedProperties["IsShowConsortia"] || !_playerVO.playerInfo.IsShowConsortia && param1.changedProperties["honor"])
         {
            updateTitle();
            updatePlayerLocal();
         }
         super.__onStyleChange(param1);
         if(param1.changedProperties["mountsType"])
         {
            updatePetsFollowPos();
            updatePlayerLocal();
         }
         updatePlayerWalk();
      }
      
      protected function updatePetsFollow() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         removePetsFollow();
         if(_playerVO.playerInfo.isPetsFollow)
         {
            _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_playerVO.playerInfo.PetsID);
            if(_loc2_ != -1)
            {
               _loc3_ = PetsAdvancedManager.Instance.formDataList[_loc2_].Resource;
               _loc1_ = "game.living.L" + _loc3_.slice(1,_loc3_.length);
               _petFollow = BoneMovieFactory.instance.creatBoneMovieFast(_loc1_);
               updatePetsFollowPos();
               addChildAt(_petFollow,0);
               changeCharacterDirection();
            }
         }
      }
      
      private function updatePetsFollowPos() : void
      {
         if(_petFollow)
         {
            if(HallPlayerPos.FLY_PETS.indexOf(_playerVO.playerInfo.PetsID) != -1)
            {
               _petFollow.y = -85;
            }
            else
            {
               _petFollow.y = 0;
            }
         }
      }
      
      private function removePetsFollow() : void
      {
         if(_petFollow && _petFollow.parent)
         {
            _petFollow.stop();
            _petFollow.parent.removeChild(_petFollow,true);
            _petFollow = null;
         }
      }
      
      override protected function changeCharacterDirection() : void
      {
         var _loc1_:int = 0;
         super.changeCharacterDirection();
         if(_petFollow)
         {
            if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.LB)
            {
               _petFollow.scaleX = 1;
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.RT || sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               _petFollow.scaleX = -1;
            }
            _loc1_ = _petFollow.scaleX * HallPlayerPos["PET_X_" + _playerVO.playerInfo.MountsType];
            TweenLite.killTweensOf(_petFollow);
            TweenLite.to(_petFollow,1.2,{"x":_loc1_});
            if(_playerVO.playerInfo.IsMounts || sceneCharacterDirection == SceneCharacterDirection.RB || sceneCharacterDirection == SceneCharacterDirection.LB)
            {
               _petFollow.play("standA");
            }
            else
            {
               _petFollow.play("standB");
            }
         }
      }
      
      override public function playerWalk(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         if(_walkPath != null && _isPlaying && _walkPath == _playerVO.walkPath)
         {
            return;
         }
         _walkPath = _playerVO.walkPath;
         if(_walkPath && _walkPath.length > 0)
         {
            _currentWalkStartPoint = _walkPath[0];
            _loc2_ = setPlayerDirection();
            if(_loc2_ != sceneCharacterDirection)
            {
               sceneCharacterDirection = _loc2_;
            }
            characterDirectionChange(true);
            _loc4_ = Point.distance(_currentWalkStartPoint,playerPoint);
            _loc3_ = _loc4_ / _moveSpeed / 1000;
            resetTween(_loc3_);
            _tween.animate("x",_currentWalkStartPoint.x);
            _tween.animate("y",_currentWalkStartPoint.y);
            Starling.juggler.add(_tween);
            _isPlaying = true;
            _walkPath.shift();
         }
         else
         {
            characterDirectionChange(false);
            dispatchEvent(new NewHallEventStarling("newhallbtnclick"));
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
      
      public function stopWalk(param1:Boolean = true) : void
      {
         characterDirectionChange(false);
         param1 && dispatchEvent(new NewHallEventStarling("newhallbtnclick"));
         if(_walkPath)
         {
            _walkPath = [];
            _walkPath = [];
         }
         _playerVO.walkPath = _walkPath;
         Starling.juggler.remove(_tween);
         _isPlaying = false;
      }
      
      private function playerWalkPath() : void
      {
         if(_walkPath != null && _walkPath.length > 0 && _playerVO.walkPath && _playerVO.walkPath.length > 0 && _walkPath != _playerVO.walkPath)
         {
            fixPlayerPath();
         }
         if(_playerVO && _playerVO.walkPath == null && !_isPlaying)
         {
            return;
         }
         if(_playerVO && _playerVO.walkPath && _playerVO.walkPath.length <= 0 && !_isPlaying)
         {
            return;
         }
         playerWalk(_playerVO.walkPath);
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
      
      public function startRandomWalk(param1:int, param2:int, param3:Object) : void
      {
         _randomPathMap = param3;
         _randomPathX = param1;
         _randomPathY = param2;
         _posTimer = new Timer(getRandomDelayTime(),1);
         _posTimer.addEventListener("timerComplete",onControlWalk);
         _posTimer.start();
      }
      
      protected function onControlWalk(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(_isPlaying)
         {
            stopWalk();
         }
         else if(_walkPath == null || _walkPath.length == 0)
         {
            _loc3_ = playerVO.randomEndPointIndex;
            _loc4_ = getEndPointIndex(_loc3_);
            playerVO.randomStartPointIndex = _loc3_;
            playerVO.randomEndPointIndex = _loc4_;
            _loc2_ = getPointPath(_loc3_,_loc4_);
            _loc2_.unshift();
            playerVO.walkPath = _loc2_;
            playerVO.currentWalkStartPoint = _currentWalkStartPoint;
         }
         _posTimer.reset();
         _posTimer.delay = getRandomDelayTime();
         _posTimer.repeatCount = 1;
         _posTimer.start();
      }
      
      protected function getRandomDelayTime() : int
      {
         return 2000 + Math.random() * 2000;
      }
      
      private function getEndPointIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1 / _randomPathY;
         if(_loc2_ == _randomPathX - 1)
         {
            _loc3_ = -1;
         }
         else if(_loc2_ == 0)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = Math.random() > 0.5?1:-1;
         }
         var _loc4_:int = (_loc2_ + _loc3_) * _randomPathY + int(Math.random() * _randomPathY);
         return _loc4_;
      }
      
      private function getPointPath(param1:int, param2:int) : Array
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         if(param1 < param2)
         {
            _loc4_ = _randomPathMap[param1 + "_" + param2];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length / 2)
            {
               _loc3_.push(new Point(_loc4_[_loc5_ * 2],_loc4_[_loc5_ * 2 + 1]));
               _loc5_++;
            }
         }
         else
         {
            _loc4_ = _randomPathMap[param2 + "_" + param1];
            _loc5_ = _loc4_.length / 2 - 1;
            while(_loc5_ > -1)
            {
               _loc3_.push(new Point(_loc4_[_loc5_ * 2],_loc4_[_loc5_ * 2 + 1]));
               _loc5_--;
            }
         }
         return _loc3_;
      }
      
      public function get currentWalkStartPoint() : Point
      {
         return _currentWalkStartPoint;
      }
      
      override public function dispose() : void
      {
         Starling.juggler.remove(_tween);
         _tween = null;
         _posTimer && _posTimer.removeEventListener("timerComplete",onControlWalk);
         _posTimer = null;
         _randomPathMap = null;
         _playerVO = null;
         _currentWalkStartPoint = null;
         StarlingObjectUtils.disposeObject(_petFollow);
         StarlingObjectUtils.disposeAllChildren(_nameSprite);
         StarlingObjectUtils.disposeAllChildren(_titleSprite);
         StarlingObjectUtils.disposeObject(_nameSprite);
         StarlingObjectUtils.disposeObject(_titleSprite);
         _nameSprite = null;
         _namePos = null;
         _titleSprite = null;
         _titlePos = null;
         super.dispose();
      }
   }
}
