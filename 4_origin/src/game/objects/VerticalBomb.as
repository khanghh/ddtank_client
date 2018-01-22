package game.objects
{
   import flash.geom.Point;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class VerticalBomb extends SimpleBomb
   {
       
      
      private var _isFall:Boolean;
      
      public function VerticalBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function computeFallNextXY(param1:Number) : Point
      {
         var _loc2_:Number = _vy.x1;
         if(!isFall)
         {
            _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,param1);
         }
         _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,param1);
         if(_loc2_ * _vy.x1 <= 0)
         {
            _isFall = true;
         }
         return new Point(_vx.x0,_vy.x0);
      }
      
      override public function get motionAngle() : Number
      {
         if(isFall)
         {
            return 3.14159265358979 / 2;
         }
         return Math.atan2(_vy.x1,_vx.x1);
      }
      
      override public function get isFall() : Boolean
      {
         return _isFall;
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return !isFall;
      }
   }
}
