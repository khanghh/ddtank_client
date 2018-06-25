package starling.scene.common
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Point;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class WalkPlugin implements Disposeable
   {
      
      public static const DIRECTION_RT:int = 1;
      
      public static const DIRECTION_LT:int = 2;
      
      public static const DIRECTION_RB:int = 3;
      
      public static const DIRECTION_LB:int = 4;
       
      
      private var _entity:Object;
      
      private var _pathArr:Array;
      
      private var _speed:Number = 1;
      
      private var _currentPathIndex:int = 0;
      
      private var _walkTween:Tween;
      
      private var _isFinish:Boolean = false;
      
      private var _isWalk:Boolean = false;
      
      public function WalkPlugin(entity:Object = null, speed:Number = 1, pathArr:Array = null)
      {
         super();
         _entity = entity;
         _speed = speed;
         _pathArr = pathArr;
         _walkTween = new Tween(_entity,1);
      }
      
      public function walk() : void
      {
         var endPoint:* = null;
         var sec:Number = NaN;
         if(_entity == null)
         {
            throw new Error("必须先设置运动实体entity");
         }
         if(_pathArr == null)
         {
            return;
         }
         if(_speed <= 0)
         {
            throw new Error("运动实体速度speed必须大于0");
         }
         _isWalk = false;
         if(_isFinish)
         {
            return;
         }
         if(_currentPathIndex < _pathArr.length)
         {
            _isWalk = true;
            endPoint = _pathArr[_currentPathIndex];
            sec = Math.sqrt(Math.pow(endPoint.x - _entity.x,2) + Math.pow(endPoint.y - _entity.y,2)) / _speed;
            Starling.juggler.add(_walkTween);
            _walkTween.reset(_entity,sec);
            _walkTween.onComplete = onWalkPartComplete;
            _walkTween.moveTo(endPoint.x,endPoint.y);
            if(_entity.hasOwnProperty("direction"))
            {
               _entity.direction = getDirection(_entity.x,_entity.y,endPoint.x,endPoint.y);
            }
         }
         else
         {
            _isFinish = true;
         }
      }
      
      private function getDirection(startX:Number, startY:Number, endX:Number, endY:Number) : int
      {
         if(startX <= endX)
         {
            return startY <= endY?3:1;
         }
         return startY <= endY?4:2;
      }
      
      private function onWalkPartComplete() : void
      {
         if(_isWalk)
         {
            Starling.juggler.remove(_walkTween);
            _currentPathIndex = Number(_currentPathIndex) + 1;
            walk();
         }
      }
      
      public function stop() : void
      {
         Starling.juggler.remove(_walkTween);
         _isWalk = false;
      }
      
      public function get entity() : Object
      {
         return _entity;
      }
      
      public function set entity(value:Object) : void
      {
         _entity = value;
      }
      
      public function get pathArr() : Array
      {
         return _pathArr;
      }
      
      public function set pathArr(value:Array) : void
      {
         _pathArr = value;
      }
      
      public function get speed() : Number
      {
         return _speed;
      }
      
      public function set speed(value:Number) : void
      {
         _speed = value;
      }
      
      public function get isFinish() : Boolean
      {
         return _isFinish;
      }
      
      public function dispose() : void
      {
         Starling.juggler.remove(_walkTween);
         _walkTween = null;
         _entity = null;
         _pathArr = null;
      }
   }
}
