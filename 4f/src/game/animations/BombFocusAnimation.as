package game.animations
{
   import game.objects.GameLiving;
   import game.objects.SimpleBomb;
   import game.view.map.MapView;
   import phy.object.PhysicalObj;
   
   public class BombFocusAnimation extends PhysicalObjFocusAnimation
   {
       
      
      protected var _phy:SimpleBomb;
      
      protected var _owner:GameLiving;
      
      public function BombFocusAnimation(param1:SimpleBomb, param2:int = 100, param3:int = 0, param4:PhysicalObj = null){super(null,null,null);}
      
      override public function update(param1:MapView) : Boolean{return false;}
      
      private function smoothDown(param1:Number, param2:Number, param3:Number) : Number{return 0;}
      
      private function smoothUp(param1:Number, param2:Number, param3:Number) : Number{return 0;}
   }
}
