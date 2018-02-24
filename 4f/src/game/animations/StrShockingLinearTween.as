package game.animations
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class StrShockingLinearTween extends StrLinearTween
   {
       
      
      protected var shockingX:int;
      
      protected var shockingY:int;
      
      protected var shockingFreq:uint = 1;
      
      protected var life:uint;
      
      public function StrShockingLinearTween(param1:TweenObject = null){super(null);}
      
      override public function get type() : String{return null;}
      
      override public function copyPropertyFromData(param1:TweenObject) : void{}
      
      override public function update(param1:DisplayObject) : Point{return null;}
      
      override protected function get propertysNeed() : Array{return null;}
   }
}
