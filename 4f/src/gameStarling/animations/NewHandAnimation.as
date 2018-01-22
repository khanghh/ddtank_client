package gameStarling.animations
{
   import flash.geom.Point;
   import gameStarling.view.map.MapView3D;
   
   public class NewHandAnimation extends BaseSetCenterAnimation
   {
       
      
      public function NewHandAnimation(param1:Number, param2:Number, param3:int = 0, param4:Boolean = false, param5:int = 0, param6:int = 4, param7:Object = null){super(null,null,null,null,null);}
      
      override public function canAct() : Boolean{return false;}
      
      override public function prepare(param1:AnimationSet) : void{}
      
      override public function update(param1:MapView3D) : Boolean{return false;}
   }
}
