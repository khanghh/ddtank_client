package campbattle.view.roleView
{
   import campbattle.data.RoleData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class CampBattlePlayer extends CampBaseRole
   {
       
      
      public var scene:SceneScene;
      
      protected var tombstone:MovieClip;
      
      protected var fighting:MovieClip;
      
      protected var capture:Bitmap;
      
      private var _walkOverHander:Function;
      
      private var _targetID:int;
      
      private var _targetZoneID:int;
      
      private var _nameTxt:FilterFrameText;
      
      private var _resurrectCartoon:MovieClip;
      
      private var _currentWalkStartPoint:Point;
      
      private var _walkSpeed:Number;
      
      public function CampBattlePlayer(param1:RoleData = null, param2:Function = null)
      {
         super(param1,param2);
         if(!param1)
         {
            return;
         }
         _playerInfo = param1;
         setPlayerInfo(param1);
         setPlayerWalkSpeed();
      }
      
      private function setPlayerWalkSpeed() : void
      {
         if(playerInfo.IsMounts)
         {
            _walkSpeed = 0.25;
         }
         else
         {
            _walkSpeed = 0.15;
         }
      }
      
      public function setPlayerInfo(param1:RoleData = null) : void
      {
         addEventListener("characterDirectionChange",characterDirectionChange);
         addEventListener("enterFrame",enterFrameHander);
         x = param1.posX;
         y = param1.posY;
         this.character.x = -playerWidth / 2;
         this.character.y = -playerHeight;
         initStatus();
         setStateType(param1.stateType);
         setCaptureVisible(param1.isCapture);
      }
      
      private function initStatus() : void
      {
         _resurrectCartoon = ComponentFactory.Instance.creat("asset.consortiaBattle.resurrectCartoon");
         _resurrectCartoon.addEventListener("complete",cartoonCompleteHandler,false,0,true);
         _resurrectCartoon.gotoAndStop(1);
         _resurrectCartoon.visible = false;
         addChild(_resurrectCartoon);
         tombstone = ComponentFactory.Instance.creat("campbattle.tombstone");
         tombstone.visible = false;
         addChild(tombstone);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.titleTxt1");
         _nameTxt.text = _playerInfo.name;
         _nameTxt.x = this.character.x + (playerWidth / 2 - _nameTxt.width / 2);
         _nameTxt.y = -playerHeight + 10;
         addChild(_nameTxt);
         fighting = ComponentFactory.Instance.creat("campbattle.fighting");
         fighting.x = -1;
         fighting.y = _nameTxt.y - 20;
         fighting.visible = false;
         addChild(fighting);
         capture = ComponentFactory.Instance.creat("asset.campbattle.capture.Samll");
         capture.x = _nameTxt.x - capture.width - 2;
         capture.y = _nameTxt.y;
         capture.visible = false;
         addChild(capture);
      }
      
      public function setCaptureVisible(param1:Boolean) : void
      {
         capture.visible = param1;
         _playerInfo.isCapture = param1;
      }
      
      private function cartoonCompleteHandler(param1:Event) : void
      {
         _resurrectCartoon.gotoAndStop(1);
         _resurrectCartoon.visible = false;
      }
      
      public function setStateType(param1:int) : void
      {
         tombstone.visible = false;
         fighting.visible = false;
         _resurrectCartoon.visible = false;
         switch(int(param1))
         {
            case 0:
               this.character.visible = true;
               _nameTxt.y = -playerHeight + 10;
            case 1:
               this.character.visible = true;
               _nameTxt.y = -playerHeight + 10;
               if(_playerInfo.isDead)
               {
                  _playerInfo.isDead = false;
                  _resurrectCartoon.visible = true;
                  _resurrectCartoon.gotoAndPlay(1);
               }
               break;
            case 2:
               fighting.visible = true;
               this.character.visible = true;
               _nameTxt.y = -playerHeight + 10;
               break;
            case 3:
               break;
            case 4:
               this.character.visible = false;
               tombstone.visible = true;
               _playerInfo.isDead = true;
               _nameTxt.y = tombstone.y - 80;
         }
         _playerInfo.stateType = param1;
      }
      
      override public function dispose() : void
      {
         if(fighting)
         {
            while(fighting.numChildren)
            {
               ObjectUtils.disposeObject(fighting.getChildAt(0));
            }
         }
         if(tombstone)
         {
            while(tombstone.numChildren)
            {
               ObjectUtils.disposeObject(tombstone.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(fighting);
         ObjectUtils.disposeObject(capture);
         ObjectUtils.disposeObject(tombstone);
         ObjectUtils.disposeObject(_nameTxt);
         removeEventListener("characterDirectionChange",characterDirectionChange);
         removeEventListener("enterFrame",enterFrameHander);
         super.dispose();
      }
      
      protected function enterFrameHander(param1:Event) : void
      {
         update();
         playerWalkPath();
         characterMirror();
      }
      
      public function walk(param1:Point, param2:Function = null, param3:int = 0, param4:int = 0) : void
      {
         if(!scene)
         {
            return;
         }
         walkPath = [];
         _targetID = param3;
         _targetZoneID = param4;
         walkPath = scene.searchPath(playerPoint,param1);
         walkPath.shift();
         isWalkPathChange = true;
         _walkOverHander = param2;
      }
      
      protected function characterMirror() : void
      {
         var _loc1_:int = playerHeight;
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
            _loc1_ = 175;
         }
         this.character.y = -_loc1_ + 12;
         this.playerHitArea.y = this.character.y;
      }
      
      protected function playerWalkPath() : void
      {
         if((!walkPath || walkPath.length <= 0) && !_tween.isPlaying)
         {
            return;
         }
         playerWalk(walkPath);
      }
      
      override public function playerWalk(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         if(_walkPath != null && !isWalkPathChange && _tween.isPlaying)
         {
            return;
         }
         _walkPath = param1;
         isWalkPathChange = false;
         if(_walkPath && _walkPath.length > 0)
         {
            _currentWalkStartPoint = _walkPath[0] as Point;
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
         if(_playerInfo.IsMounts)
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
      
      public function IsShowPlayer(param1:Boolean) : void
      {
         this.character.visible = param1;
         _nameTxt.visible = param1;
      }
      
      private function characterDirectionChange(param1:SceneCharacterEvent) : void
      {
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
            if(_walkOverHander != null)
            {
               if(_targetID != 0 && _targetZoneID != 0)
               {
                  _walkOverHander(_targetZoneID,_targetID);
               }
               else if(_targetID != 0)
               {
                  _walkOverHander(_targetID);
               }
               else
               {
                  _walkOverHander();
               }
            }
            _playerInfo.posX = x;
            _playerInfo.posY = y;
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
      
      public function get playerInfo() : RoleData
      {
         return _playerInfo;
      }
   }
}
