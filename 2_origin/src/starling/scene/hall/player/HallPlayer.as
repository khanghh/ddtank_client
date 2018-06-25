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
      
      public function HallPlayer(playerVO:PlayerVO)
      {
         _playerVO = playerVO;
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
      
      public function updatePlayerLocal(point:Point = null) : void
      {
         var pos:* = null;
         if(_isDefaultCharacter)
         {
            pos = HallPlayerPos.MOUNT_0;
         }
         else
         {
            pos = point || HallPlayerPos["MOUNT_" + _playerVO.playerInfo.MountsType];
         }
         _nameSprite.x = _namePos.x + pos.x;
         _nameSprite.y = _namePos.y + pos.y;
         _titleSprite.x = _titlePos.x + pos.x;
         _titleSprite.y = _titlePos.y + pos.y;
         _characterPlayer.x = pos.x;
         _characterPlayer.y = pos.y;
         if(_characterTouch)
         {
            _characterTouch.x = pos.x + 15;
            _characterTouch.y = pos.y + 15;
         }
         changeCharacterDirection();
      }
      
      public function updatePlayerName() : void
      {
         var nameText:* = null;
         var assetName:* = null;
         var vipImage:* = null;
         nameText = null;
         var girlAttest:* = null;
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
         var nameWidth:* = 0;
         var bg:Sprite = new Sprite();
         _nameSprite.addChild(bg);
         if(_playerVO.playerInfo.IsVIP)
         {
            nameText = new TextLabel("asset.hall.playerInfo.lblNameVIP");
            nameText.text = _playerVO.playerInfo.NickName;
            nameText.x = 5;
            _nameSprite.addChild(nameText);
            nameWidth = Number(nameWidth + (nameText.width + 10));
            assetName = "image_vipGrade_small" + _playerVO.playerInfo.VIPLevel;
            vipImage = StarlingMain.instance.createImage(assetName);
            vipImage.x = 5;
            vipImage.y = -10;
            _nameSprite.addChild(vipImage);
            nameText.x = vipImage.width + 5;
            nameWidth = Number(nameWidth + (vipImage.width + 5));
         }
         else
         {
            nameText = new TextLabel("asset.hall.playerInfo.lblName");
            nameText.text = _playerVO.playerInfo.NickName;
            nameText.x = 5;
            _nameSprite.addChild(nameText);
            nameWidth = Number(nameWidth + (nameText.width + 10));
         }
         if(playerVO.playerInfo.isAttest)
         {
            girlAttest = StarlingMain.instance.createImage("image_player_girlAttest");
            _nameSprite.addChild(girlAttest);
            girlAttest.x = nameWidth;
            girlAttest.y = -5;
            nameWidth = Number(nameWidth + (girlAttest.width + 5));
         }
         bg.graphics.beginFill(0,0.5);
         bg.graphics.drawRect(0,0,nameWidth,20);
         bg.graphics.endFill();
         _nameSprite.x = 60 - nameWidth / 2;
         _namePos.setTo(_nameSprite.x,_nameSprite.y);
      }
      
      public function updateTitle() : void
      {
         var textWidth:Number = NaN;
         var consortiaText:* = null;
         var icon:* = null;
         var titleModel:* = null;
         var image:* = null;
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
            textWidth = FilterFrameText.getStringWidthByTextField(_playerVO.playerInfo.ConsortiaName,13);
            consortiaText = new TextField(textWidth,20,_playerVO.playerInfo.ConsortiaName,"Arial",12,3002359,true);
            if(_playerVO.playerInfo.badgeID > 0)
            {
               icon = StarlingMain.instance.createImage("image_badge_" + _playerVO.playerInfo.badgeID);
               var _loc6_:int = 25;
               icon.height = _loc6_;
               icon.width = _loc6_;
               _titleSprite.addChild(icon);
               consortiaText.x = 25;
            }
            _titleSprite.y = -30;
            _titleSprite.addChild(consortiaText);
         }
         else if(_playerVO.playerInfo.honor.length > 0)
         {
            titleModel = NewTitleManager.instance.titleInfo[_playerVO.playerInfo.honorId];
            if(titleModel && titleModel.Show != "0" && titleModel.Pic != "0")
            {
               image = StarlingMain.instance.createImage("image_title_" + titleModel.Pic);
               _titleSprite.y = -(image.height + 5);
               _titleSprite.addChild(image);
            }
         }
         _titleSprite.x = 60 - _titleSprite.width / 2;
         _titlePos.setTo(_titleSprite.x,_titleSprite.y);
      }
      
      public function get playerVO() : PlayerVO
      {
         return _playerVO;
      }
      
      override protected function __onTouch(e:TouchEvent) : void
      {
         var lastFilter:* = null;
         var locationPoint:* = null;
         super.__onTouch(e);
         var touch:Touch = e.getTouch(_characterTouch,"ended");
         if(_characterPlayer)
         {
            lastFilter = _characterPlayer.filter;
            lastFilter && lastFilter.dispose();
            if(e.getTouch(_characterTouch,"hover"))
            {
               _characterPlayer.filter = BlurFilter.createGlow(16776960,1,8,0.5);
            }
            else
            {
               _characterPlayer.filter = null;
            }
         }
         if(touch)
         {
            locationPoint = touch.getLocation(_characterTouch);
            if(_characterTouch.hitTest(locationPoint,true))
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
      
      public function set isHideTitle(value:Boolean) : void
      {
         if(_isHideTitle != value)
         {
            _isHideTitle = value;
            updateTitle();
            updatePlayerLocal();
         }
      }
      
      override protected function __onStyleChange(evt:PlayerPropertyEvent) : void
      {
         if(_isDefaultCharacter)
         {
            return;
         }
         if(evt.changedProperties["petsID"])
         {
            updatePetsFollow();
         }
         if(evt.changedProperties["IsShowConsortia"] || !_playerVO.playerInfo.IsShowConsortia && evt.changedProperties["honor"])
         {
            updateTitle();
            updatePlayerLocal();
         }
         super.__onStyleChange(evt);
         if(evt.changedProperties["mountsType"])
         {
            updatePetsFollowPos();
            updatePlayerLocal();
         }
         updatePlayerWalk();
      }
      
      protected function updatePetsFollow() : void
      {
         var index:int = 0;
         var path:* = null;
         var styleName:* = null;
         removePetsFollow();
         if(_playerVO.playerInfo.isPetsFollow)
         {
            index = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_playerVO.playerInfo.PetsID);
            if(index != -1)
            {
               path = PetsAdvancedManager.Instance.formDataList[index].Resource;
               styleName = "game.living.L" + path.slice(1,path.length);
               _petFollow = BoneMovieFactory.instance.creatBoneMovieFast(styleName);
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
         var desX:int = 0;
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
            desX = _petFollow.scaleX * HallPlayerPos["PET_X_" + _playerVO.playerInfo.MountsType];
            TweenLite.killTweensOf(_petFollow);
            TweenLite.to(_petFollow,1.2,{"x":desX});
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
      
      override public function playerWalk(walkPath:Array) : void
      {
         var dirction:* = null;
         var dis:Number = NaN;
         var sec:Number = NaN;
         if(_walkPath != null && _isPlaying && _walkPath == _playerVO.walkPath)
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
            sec = dis / _moveSpeed / 1000;
            resetTween(sec);
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
      
      public function stopWalk(isDispatchEvent:Boolean = true) : void
      {
         characterDirectionChange(false);
         isDispatchEvent && dispatchEvent(new NewHallEventStarling("newhallbtnclick"));
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
      
      public function startRandomWalk(randomPathX:int, randomPathY:int, randomPathMap:Object) : void
      {
         _randomPathMap = randomPathMap;
         _randomPathX = randomPathX;
         _randomPathY = randomPathY;
         _posTimer = new Timer(getRandomDelayTime(),1);
         _posTimer.addEventListener("timerComplete",onControlWalk);
         _posTimer.start();
      }
      
      protected function onControlWalk(evt:TimerEvent) : void
      {
         var newStartPointIndex:int = 0;
         var newEndPointIndex:int = 0;
         var walkPath:* = null;
         if(_isPlaying)
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
      
      protected function getRandomDelayTime() : int
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
