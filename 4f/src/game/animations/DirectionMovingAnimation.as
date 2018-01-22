package game.animations
{
   import game.view.map.MapView;
   
   public class DirectionMovingAnimation extends BaseAnimate
   {
      
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _dir:String;
      
      public function DirectionMovingAnimation(param1:String){super();}
      
      override public function cancel() : void{}
      
      override public function update(param1:MapView) : Boolean{return false;}
   }
}
