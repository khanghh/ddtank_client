package starling.display.sceneCharacter
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.geom.Point;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.TouchEvent;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilter;
   
   public class SceneCharacterPlayerBase extends Sprite
   {
       
      
      protected var _sceneCharacterDirection:SceneCharacterDirection;
      
      protected var _sceneCharacterState:SceneCharacterState;
      
      protected var _characterPlayer:Sprite;
      
      protected var _characterTouch:Quad;
      
      protected var _moveSpeed:Number = 0.15;
      
      protected var _walkPath:Array;
      
      public var isWalkPathChange:Boolean = false;
      
      protected var _tween:Tween;
      
      protected var _isPlaying:Boolean = false;
      
      private var _walkDistance:Number;
      
      private var _walkPath0:Point;
      
      private var po1:Point;
      
      private var _playerY:Number;
      
      protected var sceneCharacterDefaultActionState:String = "";
      
      protected var _isDefaultCharacter:Boolean = true;
      
      public function SceneCharacterPlayerBase()
      {
         _sceneCharacterDirection = SceneCharacterDirection.RB;
         super();
         initialize();
         initEvent();
      }
      
      protected function initialize() : void
      {
         _tween = new Tween(this,1);
         _tween.roundToInt = true;
         _characterPlayer = new Sprite();
         _characterPlayer.touchable = false;
         addChildAt(_characterPlayer,0);
      }
      
      protected function initEvent() : void
      {
         if(_characterTouch)
         {
            _characterTouch.addEventListener("touch",__onTouch);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_characterTouch)
         {
            _characterTouch.removeEventListener("touch",__onTouch);
         }
      }
      
      protected function __onTouch(e:TouchEvent) : void
      {
         e.stopPropagation();
      }
      
      private function __change() : void
      {
         dispatchEvent(new SceneCharacterEvent("characterMovement",null));
         _playerY = (this.y + Math.random()) * 10000;
      }
      
      private function __finish() : void
      {
         Starling.juggler.remove(_tween);
         _isPlaying = false;
         playerWalk(_walkPath);
         dispatchEvent(new SceneCharacterEvent("characterArrivedNextStep"));
      }
      
      public function playerWalk(walkPath:Array) : void
      {
         var sec:Number = NaN;
         if(_walkPath != null && !isWalkPathChange && _isPlaying)
         {
            return;
         }
         _walkPath = walkPath;
         isWalkPathChange = false;
         if(_walkPath && _walkPath.length > 0)
         {
            sceneCharacterDirection = SceneCharacterDirection.getDirection(new Point(this.x,this.y),_walkPath[0]);
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",true));
            _walkPath0 = _walkPath[0] as Point;
            po1 = new Point(this.x,this.y);
            _walkDistance = Point.distance(_walkPath0,new Point(this.x,this.y));
            sec = _walkDistance / _moveSpeed / 1000;
            resetTween(sec);
            _tween.animate("x",_walkPath[0].x);
            _tween.animate("y",_walkPath[0].y);
            Starling.juggler.add(_tween);
            _isPlaying = true;
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      protected function resetTween(sec:Number) : void
      {
         _tween.reset(this,sec);
         _tween.roundToInt = true;
         _tween.onUpdate = __change;
         _tween.onComplete = __finish;
      }
      
      public function set sceneCharacterActionState(value:String) : void
      {
         if(!_sceneCharacterState || _sceneCharacterState.setSceneCharacterActionState == value)
         {
            return;
         }
         _sceneCharacterState.setSceneCharacterActionState = value;
         dispatchEvent(new SceneCharacterEvent("characterActionChange",value));
      }
      
      public function get playerPoint() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function set playerPoint(value:Point) : void
      {
         this.x = value.x;
         this.y = value.y;
         _playerY = (this.y + Math.random()) * 10000;
      }
      
      public function get moveSpeed() : Number
      {
         return _moveSpeed;
      }
      
      public function set moveSpeed(value:Number) : void
      {
         if(_moveSpeed == value)
         {
            return;
         }
         _moveSpeed = value;
      }
      
      public function get walkPath() : Array
      {
         return _walkPath;
      }
      
      public function set walkPath(value:Array) : void
      {
         _walkPath = value;
      }
      
      protected function set sceneCharacterState(value:SceneCharacterState) : void
      {
         _sceneCharacterState = value;
      }
      
      public function update() : void
      {
         if(_sceneCharacterState && this.visible)
         {
            _sceneCharacterState.sceneCharacterBase.update();
         }
      }
      
      public function initSceneCharacterState() : void
      {
         if(!_sceneCharacterState || !_sceneCharacterState.sceneCharacterBase)
         {
            return;
         }
         while(_characterPlayer && this._characterPlayer.numChildren > 0)
         {
            this._characterPlayer.removeChildAt(0,true);
         }
         this._characterPlayer.addChild(_sceneCharacterState.sceneCharacterBase);
      }
      
      public function get sceneCharacterDirection() : SceneCharacterDirection
      {
         return _sceneCharacterDirection;
      }
      
      public function setCharacterFilter(value:Boolean) : void
      {
         if(!this._characterPlayer)
         {
            return;
         }
         var lastFilter:FragmentFilter = this._characterPlayer.filter;
         lastFilter && lastFilter.dispose();
         if(value)
         {
            this._characterPlayer.filter = BlurFilter.createGlow(16776960,1,8,8);
         }
         else
         {
            this._characterPlayer.filter = null;
         }
      }
      
      public function set sceneCharacterDirection(value:SceneCharacterDirection) : void
      {
         if(_sceneCharacterDirection == value)
         {
            return;
         }
         _sceneCharacterDirection = value;
         changeCharacterDirection();
      }
      
      protected function changeCharacterDirection() : void
      {
         var scaleX:int = 0;
         if(_isDefaultCharacter)
         {
            this._characterPlayer.scaleX = 1;
         }
         else
         {
            scaleX = !!sceneCharacterDirection.isMirror?-1:1;
            this._characterPlayer.scaleX = scaleX;
            this._characterPlayer.x = -scaleX * Math.abs(this._characterPlayer.x);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         while(_walkPath && _walkPath.length > 0)
         {
            _walkPath.shift();
         }
         _walkPath = null;
         Starling.juggler.remove(_tween);
         _tween = null;
         _sceneCharacterDirection = null;
         if(_sceneCharacterState)
         {
            _sceneCharacterState.dispose();
         }
         _sceneCharacterState = null;
         StarlingObjectUtils.disposeObject(_characterPlayer);
         _characterPlayer = null;
         StarlingObjectUtils.disposeObject(_characterTouch);
         _characterTouch = null;
         super.dispose();
      }
      
      public function get playerY() : Number
      {
         return _playerY;
      }
      
      public function set playerY(value:Number) : void
      {
         _playerY = value;
      }
   }
}
