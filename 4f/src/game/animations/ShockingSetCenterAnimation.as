package game.animations
{
   import flash.geom.Point;
   import game.view.map.MapView;
   
   public class ShockingSetCenterAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _shocking:int;
      
      private var _shockDelay:int;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function ShockingSetCenterAnimation(param1:Number, param2:Number, param3:int = 165, param4:Boolean = false, param5:int = 0, param6:int = 12){super(null,null,null,null,null,null);}
      
      private function shockingOffset() : Number{return 0;}
      
      override public function update(param1:MapView) : Boolean{return false;}
   }
}
