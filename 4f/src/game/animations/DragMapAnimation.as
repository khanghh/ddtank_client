package game.animations
{
   public class DragMapAnimation extends BaseSetCenterAnimation
   {
       
      
      public function DragMapAnimation(param1:Number, param2:Number, param3:Boolean = false, param4:int = 100){super(null,null,null,null,null);}
      
      override public function canAct() : Boolean{return false;}
   }
}
