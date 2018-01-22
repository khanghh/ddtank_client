package gameStarling.animations
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class BaseStageTween implements IStageTween
   {
       
      
      protected var _target:Point;
      
      protected var _prepared:Boolean = false;
      
      protected var _isFinished:Boolean;
      
      public function BaseStageTween(param1:TweenObject = null){super();}
      
      public function get type() : String{return null;}
      
      public function initData(param1:TweenObject) : void{}
      
      public function update(param1:DisplayObject) : Point{return null;}
      
      public function set target(param1:Point) : void{}
      
      public function get target() : Point{return null;}
      
      public function copyPropertyFromData(param1:TweenObject) : void{}
      
      protected function get propertysNeed() : Array{return null;}
      
      public function get isFinished() : Boolean{return false;}
   }
}
