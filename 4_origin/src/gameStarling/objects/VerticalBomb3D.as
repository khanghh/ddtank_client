package gameStarling.objects
{
   import flash.geom.Point;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class VerticalBomb3D extends SimpleBomb3D
   {
       
      
      private var _isFall:Boolean;
      
      public function VerticalBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         super(info,owner,refineryLevel,isPhantom);
      }
      
      override protected function computeFallNextXY(dt:Number) : Point
      {
         var preX1:Number = _vy.x1;
         if(!isFall)
         {
            _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,dt);
         }
         _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,dt);
         if(preX1 * _vy.x1 <= 0)
         {
            _isFall = true;
         }
         return new Point(_vx.x0,_vy.x0);
      }
      
      override public function moveTo(p:Point) : void
      {
         if(_isLiving && _isFall && _particleRenderInfo)
         {
            _particleRenderInfo.addAngle = motionAngle;
         }
         super.moveTo(p);
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
