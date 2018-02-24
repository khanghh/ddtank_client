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
      
      public function WalkPlugin(param1:Object = null, param2:Number = 1, param3:Array = null){super();}
      
      public function walk() : void{}
      
      private function getDirection(param1:Number, param2:Number, param3:Number, param4:Number) : int{return 0;}
      
      private function onWalkPartComplete() : void{}
      
      public function stop() : void{}
      
      public function get entity() : Object{return null;}
      
      public function set entity(param1:Object) : void{}
      
      public function get pathArr() : Array{return null;}
      
      public function set pathArr(param1:Array) : void{}
      
      public function get speed() : Number{return 0;}
      
      public function set speed(param1:Number) : void{}
      
      public function get isFinish() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
