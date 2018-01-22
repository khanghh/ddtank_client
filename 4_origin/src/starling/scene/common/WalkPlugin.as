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
      
      public function WalkPlugin(param1:Object = null, param2:Number = 1, param3:Array = null)
      {
         super();
         _entity = param1;
         _speed = param2;
         _pathArr = param3;
         _walkTween = new Tween(_entity,1);
      }
      
      public function walk() : void
      {
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
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
            _loc1_ = _pathArr[_currentPathIndex];
            _loc2_ = Math.sqrt(Math.pow(_loc1_.x - _entity.x,2) + Math.pow(_loc1_.y - _entity.y,2)) / _speed;
            Starling.juggler.add(_walkTween);
            _walkTween.reset(_entity,_loc2_);
            _walkTween.onComplete = onWalkPartComplete;
            _walkTween.moveTo(_loc1_.x,_loc1_.y);
            if(_entity.hasOwnProperty("direction"))
            {
               _entity.direction = getDirection(_entity.x,_entity.y,_loc1_.x,_loc1_.y);
            }
         }
         else
         {
            _isFinish = true;
         }
      }
      
      private function getDirection(param1:Number, param2:Number, param3:Number, param4:Number) : int
      {
         if(param1 <= param3)
         {
            return param2 <= param4?3:1;
         }
         return param2 <= param4?4:2;
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
      
      public function set entity(param1:Object) : void
      {
         _entity = param1;
      }
      
      public function get pathArr() : Array
      {
         return _pathArr;
      }
      
      public function set pathArr(param1:Array) : void
      {
         _pathArr = param1;
      }
      
      public function get speed() : Number
      {
         return _speed;
      }
      
      public function set speed(param1:Number) : void
      {
         _speed = param1;
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
