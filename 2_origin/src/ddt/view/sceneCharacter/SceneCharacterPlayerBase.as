package ddt.view.sceneCharacter
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.view.scenePathSearcher.SceneMTween;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class SceneCharacterPlayerBase extends Sprite
   {
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
       
      
      private var _callBack:Function;
      
      private var _sceneCharacterDirection:SceneCharacterDirection;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterStateType:String;
      
      private var _sceneCharacterStateItem:SceneCharacterStateItem;
      
      private var _characterVisible:Boolean = true;
      
      protected var _moveSpeed:Number = 0.15;
      
      protected var _walkPath:Array;
      
      public var isWalkPathChange:Boolean = false;
      
      protected var _tween:SceneMTween;
      
      private var _walkDistance:Number;
      
      public var character:Sprite;
      
      private var _walkPath0:Point;
      
      private var po1:Point;
      
      private var _playerY:Number;
      
      private var _loadComplete:Boolean = false;
      
      public var isDefaultCharacter:Boolean;
      
      private var vFlag:int = 0;
      
      public function SceneCharacterPlayerBase(callBack:Function = null)
      {
         _sceneCharacterDirection = SceneCharacterDirection.RB;
         super();
         _callBack = callBack;
         initialize();
      }
      
      public function get loadComplete() : Boolean
      {
         return _loadComplete;
      }
      
      public function set loadComplete(value:Boolean) : void
      {
         _loadComplete = value;
      }
      
      private function initialize() : void
      {
         _tween = new SceneMTween(this);
         character = new Sprite();
         addChildAt(character,0);
         setEvent();
      }
      
      private function setEvent() : void
      {
         _tween.addEventListener("finish",__finish);
         _tween.addEventListener("change",__change);
      }
      
      private function removeEvent() : void
      {
         if(_tween)
         {
            _tween.removeEventListener("finish",__finish);
         }
         if(_tween)
         {
            _tween.removeEventListener("change",__change);
         }
      }
      
      private function __change(event:Event) : void
      {
         dispatchEvent(new SceneCharacterEvent("characterMovement",null));
         _playerY = (this.y + Math.random()) * 10000;
      }
      
      private function __finish(event:Event) : void
      {
         playerWalk(_walkPath);
         dispatchEvent(new SceneCharacterEvent("characterArrivedNextStep"));
      }
      
      public function playerWalk(walkPath:Array) : void
      {
         if(_walkPath != null && !isWalkPathChange && _tween.isPlaying)
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
            _tween.start(_walkDistance / _moveSpeed,"x",_walkPath[0].x,"y",_walkPath[0].y);
            _walkPath.shift();
         }
         else
         {
            dispatchEvent(new SceneCharacterEvent("characterDirectionChange",false));
         }
      }
      
      public function set sceneCharacterActionType(value:String) : void
      {
         if(!_sceneCharacterStateItem || _sceneCharacterStateItem.setSceneCharacterActionType == value)
         {
            return;
         }
         _sceneCharacterStateItem.setSceneCharacterActionType = value;
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
      
      protected function set sceneCharacterStateSet(value:SceneCharacterStateSet) : void
      {
         _sceneCharacterStateSet = value;
         sceneCharacterStateType = _sceneCharacterStateSet.dataSet[0].type;
         if(_callBack != null)
         {
            _callBack(this,true,vFlag);
         }
         vFlag = Number(vFlag) + 1;
      }
      
      public function update() : void
      {
         if(_sceneCharacterStateItem)
         {
            _sceneCharacterStateItem.sceneCharacterBase.update();
         }
      }
      
      public function get sceneCharacterStateType() : String
      {
         return _sceneCharacterStateType;
      }
      
      public function set sceneCharacterStateType(value:String) : void
      {
         if(_sceneCharacterStateType == value && !loadComplete)
         {
            return;
         }
         loadComplete = false;
         _sceneCharacterStateType = value;
         if(!_sceneCharacterStateSet)
         {
            return;
         }
         _sceneCharacterStateItem = _sceneCharacterStateSet.getItem(_sceneCharacterStateType);
         if(!_sceneCharacterStateItem)
         {
            return;
         }
         while(character && this.character.numChildren > 0)
         {
            this.character.removeChildAt(0);
         }
         this.character.addChild(_sceneCharacterStateItem.sceneCharacterBase);
      }
      
      public function get sceneCharacterDirection() : SceneCharacterDirection
      {
         return _sceneCharacterDirection;
      }
      
      protected function setCharacterFilter(value:Boolean) : void
      {
         if(!this.character)
         {
            return;
         }
         if(value)
         {
            this.character.filters = MOUSE_ON_GLOW_FILTER;
         }
         else
         {
            this.character.filters = null;
         }
      }
      
      public function set sceneCharacterDirection(value:SceneCharacterDirection) : void
      {
         if(_sceneCharacterDirection == value)
         {
            return;
         }
         _sceneCharacterDirection = value;
         if(_sceneCharacterStateItem)
         {
            _sceneCharacterStateItem.sceneCharacterDirection = _sceneCharacterDirection;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(_walkPath && _walkPath.length > 0)
         {
            _walkPath.shift();
         }
         _walkPath = null;
         if(_tween)
         {
            _tween.dispose();
         }
         _tween = null;
         _sceneCharacterDirection = null;
         _callBack = null;
         while(_sceneCharacterStateSet && _sceneCharacterStateSet.dataSet && _sceneCharacterStateSet.length > 0)
         {
            _sceneCharacterStateSet.dataSet[0].dispose();
            _sceneCharacterStateSet.dataSet.shift();
         }
         _sceneCharacterStateSet = null;
         if(_sceneCharacterStateItem)
         {
            _sceneCharacterStateItem.dispose();
         }
         _sceneCharacterStateItem = null;
         if(character)
         {
            if(this.character.parent)
            {
               this.character.parent.removeChild(character);
            }
         }
         character = null;
         ObjectUtils.disposeAllChildren(this);
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
