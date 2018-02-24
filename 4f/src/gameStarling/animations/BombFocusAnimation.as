package gameStarling.animations
{
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.view.map.MapView3D;
   import phy.object.PhysicalObj;
   
   public class BombFocusAnimation extends PhysicalObjFocusAnimation
   {
       
      
      protected var _phy:SimpleBomb3D;
      
      protected var _owner:GameLiving3D;
      
      public function BombFocusAnimation(param1:SimpleBomb3D, param2:int = 100, param3:int = 0, param4:PhysicalObj = null){super(null,null,null);}
      
      override public function update(param1:MapView3D) : Boolean{return false;}
      
      private function smoothDown(param1:Number, param2:Number, param3:Number) : Number{return 0;}
      
      private function smoothUp(param1:Number, param2:Number, param3:Number) : Number{return 0;}
   }
}
