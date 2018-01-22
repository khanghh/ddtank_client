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
      
      public function BombFocusAnimation(param1:SimpleBomb3D, param2:int = 100, param3:int = 0, param4:PhysicalObj = null)
      {
         super(param1,param2,param3);
         _phy = param1;
         _level = 1;
         _owner = param4 as GameLiving3D;
      }
      
      override public function update(param1:MapView3D) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         return super.update(param1);
      }
      
      private function smoothDown(param1:Number, param2:Number, param3:Number) : Number
      {
         param3 = Math.sqrt(param3);
         var _loc4_:Number = (param2 - param1) * param3;
         return param1 + _loc4_;
      }
      
      private function smoothUp(param1:Number, param2:Number, param3:Number) : Number
      {
         param3 = param3 * param3;
         var _loc4_:Number = (param2 - param1) * param3;
         return param1 + _loc4_;
      }
   }
}
