package consortionBattle.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleController;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.view.ConsBatResurrectView;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.setTimeout;
   import hall.player.HallPlayerBase;
   
   public class ConsortiaBattlePlayer extends HallPlayerBase implements Disposeable
   {
      
      public static const CLICK:String = "consBatPlayerClick";
       
      
      private var _playerData:ConsortiaBattlePlayerInfo;
      
      private var _swordIcon:MovieClip;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _tombstone:MovieClip;
      
      private var _fighting:MovieClip;
      
      private var _resurrectView:ConsBatResurrectView;
      
      private var _resurrectCartoon:MovieClip;
      
      private var _winningStreakMc:MovieClip;
      
      private var _character:Sprite;
      
      private var _currentWalkStartPoint:Point;
      
      private var _isJustWin:Boolean;
      
      private var _walkSpeed:Number;
      
      public function ConsortiaBattlePlayer(playerData:ConsortiaBattlePlayerInfo, callBack:Function = null)
      {
         _playerData = playerData;
         super(playerData,callBack);
         _character = character;
         initView();
         initEvent();
         setPlayerWalkSpeed();
      }
      
      private function setPlayerWalkSpeed() : void
      {
         if(_playerData.MountsType > 0)
         {
            _walkSpeed = 0.25;
         }
         else
         {
            _walkSpeed = 0.15;
         }
      }
      
      protected function initView() : void
      {
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.consortiaNameTxt");
         _consortiaNameTxt.text = _playerData.consortiaName;
         if(_playerData.id == PlayerManager.Instance.Self.ID)
         {
            _consortiaNameTxt.textColor = 65280;
         }
         else if(_playerData.selfOrEnemy == 1)
         {
            _consortiaNameTxt.textColor = 52479;
         }
         else
         {
            _consortiaNameTxt.textColor = 16711680;
         }
         addChild(_consortiaNameTxt);
         _tombstone = ComponentFactory.Instance.creat("asset.consortiaBattle.tombstone");
         PositionUtils.setPos(_tombstone,"consortiaBattle.tombstonePos");
         _tombstone.gotoAndStop(1);
         _tombstone.visible = false;
         addChild(_tombstone);
         _fighting = ComponentFactory.Instance.creat("asset.consortiaBattle.fighting");
         PositionUtils.setPos(_fighting,"consortiaBattle.fightingPos");
         _fighting.gotoAndStop(2);
         _fighting.visible = false;
         addChild(_fighting);
         _winningStreakMc = ComponentFactory.Instance.creat("asset.consortiaBattle.winningStreak.iconMc");
         PositionUtils.setPos(_winningStreakMc,"consortiaBattle.winningStreakMcPos");
         _winningStreakMc.gotoAndStop(1);
         addChild(_winningStreakMc);
         refreshStatus();
      }
      
      public function refreshStatus() : void
      {
         var timeOffset:int = (_playerData.tombstoneEndTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         if(isInTomb && timeOffset <= 0)
         {
            resurrectHandler();
            return;
         }
         if(timeOffset > 0)
         {
            _character.visible = false;
            _fighting.gotoAndStop(2);
            _fighting.visible = false;
            _tombstone.visible = true;
            _tombstone.gotoAndPlay(1);
            createRrsurrectView(timeOffset);
            _consortiaNameTxt.y = -79;
         }
         else if(_playerData.status == 2)
         {
            _character.visible = true;
            _fighting.gotoAndStop(1);
            _fighting.visible = true;
            _tombstone.visible = false;
            _tombstone.gotoAndStop(1);
            _consortiaNameTxt.y = -160;
            _fighting.y = _consortiaNameTxt.y - 25;
         }
         else
         {
            _character.visible = true;
            _fighting.gotoAndStop(2);
            if(_fighting.visible)
            {
               _isJustWin = true;
               setTimeout(canClickedFight,7000);
            }
            _fighting.visible = false;
            _tombstone.visible = false;
            _tombstone.gotoAndStop(1);
            _consortiaNameTxt.y = -playerHeight;
         }
         if(_playerData.winningStreak >= 10)
         {
            _winningStreakMc.gotoAndStop(4);
         }
         else if(_playerData.winningStreak >= 6)
         {
            _winningStreakMc.gotoAndStop(3);
         }
         else if(_playerData.winningStreak >= 3)
         {
            _winningStreakMc.gotoAndStop(2);
         }
         else if(_playerData.failBuffCount > 0)
         {
            _winningStreakMc.gotoAndStop(5);
         }
         else
         {
            _winningStreakMc.gotoAndStop(1);
         }
         _winningStreakMc.y = _consortiaNameTxt.y - 25;
         if(_winningStreakMc.currentFrame > 1 && _fighting.visible)
         {
            _fighting.y = _consortiaNameTxt.y - 40;
         }
         this.visible = ConsortiaBattleController.instance.judgePlayerVisible(this);
         if(parent)
         {
            playerPoint = _playerData.pos;
         }
      }
      
      private function canClickedFight() : void
      {
         _isJustWin = false;
      }
      
      private function createRrsurrectView(total:int) : void
      {
         var tmp:* = null;
         if(_resurrectView)
         {
            return;
         }
         if(_playerData.id == PlayerManager.Instance.Self.ID)
         {
            _resurrectView = new ConsBatResurrectView(total);
            tmp = this.localToGlobal(new Point(-113,-121));
            _resurrectView.x = tmp.x;
            _resurrectView.y = tmp.y;
            LayerManager.Instance.addToLayer(_resurrectView,3);
         }
      }
      
      private function resurrectHandler() : void
      {
         if(_resurrectView)
         {
            ObjectUtils.disposeObject(_resurrectView);
            _resurrectView = null;
         }
         _resurrectCartoon = ComponentFactory.Instance.creat("asset.consortiaBattle.resurrectCartoon");
         _resurrectCartoon.addEventListener("complete",cartoonCompleteHandler,false,0,true);
         _resurrectCartoon.gotoAndPlay(1);
         addChild(_resurrectCartoon);
      }
      
      private function cartoonCompleteHandler(event:Event) : void
      {
         if(_resurrectCartoon)
         {
            _resurrectCartoon.removeEventListener("complete",cartoonCompleteHandler);
            removeChild(_resurrectCartoon);
            _resurrectCartoon = null;
         }
         _tombstone.visible = false;
         refreshStatus();
         if(_playerData.id == PlayerManager.Instance.Self.ID)
         {
            dispatchEvent(new SceneCharacterEvent("characterMovement"));
         }
      }
      
      protected function initEvent() : void
      {
         playerHitArea.addEventListener("mouseOver",__onMouseOver);
         playerHitArea.addEventListener("mouseOut",__onMouseOut);
         playerHitArea.addEventListener("click",__onMouseClick);
      }
      
      override protected function __onMouseClick(event:MouseEvent) : void
      {
         if(isCanBeFight)
         {
            if(_isJustWin)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.justWinProtectTxt"),0,true);
            }
            else
            {
               dispatchEvent(new Event("consBatPlayerClick",true));
            }
         }
      }
      
      override protected function __onMouseOver(event:MouseEvent) : void
      {
         if(isCanBeFight)
         {
            setCharacterFilter(true);
            showSwordMouse();
         }
      }
      
      private function showSwordMouse() : void
      {
         if(!_swordIcon)
         {
            _swordIcon = ComponentFactory.Instance.creat("asset.consortiaBattle.overEnemySword");
            _swordIcon.mouseChildren = false;
            _swordIcon.mouseEnabled = false;
            LayerManager.Instance.addToLayer(_swordIcon,3);
         }
         Mouse.hide();
         _swordIcon.visible = true;
         playerHitArea.addEventListener("mouseMove",mouseMoveHandler);
      }
      
      private function mouseMoveHandler(event:MouseEvent) : void
      {
         _swordIcon.x = event.stageX;
         _swordIcon.y = event.stageY;
      }
      
      private function hideSwordMouse() : void
      {
         if(playerHitArea)
         {
            playerHitArea.removeEventListener("mouseMove",mouseMoveHandler);
         }
         if(_swordIcon)
         {
            _swordIcon.visible = false;
         }
         Mouse.show();
      }
      
      override protected function __onMouseOut(event:MouseEvent) : void
      {
         if(isEnemy)
         {
            setCharacterFilter(false);
            hideSwordMouse();
         }
      }
      
      public function get isEnemy() : Boolean
      {
         return _playerData && _playerData.selfOrEnemy == 2;
      }
      
      private function get isCanBeFight() : Boolean
      {
         return isEnemy && !_tombstone.visible && !_fighting.visible && ConsortiaBattleManager.instance.beforeStartTime <= 0;
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
      
      public function get isCanWalk() : Boolean
      {
         return !_tombstone.visible && !_fighting.visible;
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
         if(_walkPath != null && _walkPath.length > 0 && _playerData.walkPath.length > 0 && _walkPath != _playerData.walkPath)
         {
            fixPlayerPath();
         }
         if(_playerData && _playerData.walkPath && _playerData.walkPath.length <= 0 && !_tween.isPlaying)
         {
            return;
         }
         playerWalk(_playerData.walkPath);
      }
      
      private function fixPlayerPath() : void
      {
         var i:int = 0;
         var lastPath:* = null;
         if(_playerData.currentWalkStartPoint == null)
         {
            return;
         }
         var startPointIndex:* = -1;
         for(i = 0; i < _walkPath.length; )
         {
            if(_walkPath[i].x == _playerData.currentWalkStartPoint.x && _walkPath[i].y == _playerData.currentWalkStartPoint.y)
            {
               startPointIndex = i;
               break;
            }
            i++;
         }
         if(startPointIndex > 0)
         {
            lastPath = _walkPath.slice(0,startPointIndex);
            _playerData.walkPath = lastPath.concat(_playerData.walkPath);
         }
      }
      
      override public function playerWalk(walkPathArray:Array) : void
      {
         var dirction:* = null;
         var dis:Number = NaN;
         if(_walkPath != null && _tween.isPlaying && _walkPath == playerData.walkPath)
         {
            return;
         }
         _walkPath = playerData.walkPath;
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
         if(_playerData.IsMounts)
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
      
      public function get playerData() : ConsortiaBattlePlayerInfo
      {
         return _playerData;
      }
      
      public function get isInTomb() : Boolean
      {
         return _tombstone.visible;
      }
      
      public function get isInFighting() : Boolean
      {
         return _fighting.visible;
      }
      
      private function characterDirectionChange(actionFlag:Boolean) : void
      {
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
         else if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
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
      
      protected function removeEvent() : void
      {
      }
      
      public function get currentWalkStartPoint() : Point
      {
         return _currentWalkStartPoint;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _playerData = null;
         ObjectUtils.disposeObject(_swordIcon);
         _swordIcon = null;
         ObjectUtils.disposeObject(_consortiaNameTxt);
         _consortiaNameTxt = null;
         ObjectUtils.disposeObject(_tombstone);
         _tombstone = null;
         if(_fighting)
         {
            _fighting.gotoAndStop(2);
         }
         ObjectUtils.disposeObject(_fighting);
         _fighting = null;
         if(_resurrectView)
         {
            ObjectUtils.disposeObject(_resurrectView);
            _resurrectView = null;
         }
         if(_resurrectCartoon)
         {
            _resurrectCartoon.removeEventListener("complete",cartoonCompleteHandler);
            removeChild(_resurrectCartoon);
            _resurrectCartoon = null;
         }
         _character = null;
         super.dispose();
      }
   }
}
