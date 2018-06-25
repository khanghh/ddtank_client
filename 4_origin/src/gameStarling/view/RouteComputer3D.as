package gameStarling.view
{
   import flash.geom.Point;
   import gameCommon.GameControl;
   import starlingPhy.maps.Map3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class RouteComputer3D
   {
      
      private static var DELAY_TIME:Number = 0.04;
       
      
      private var _map:Map3D;
      
      public function RouteComputer3D(map:Map3D)
      {
         super();
         _map = map;
      }
      
      public function getPath(angle:int, power:int) : Array
      {
         var obj:PhysicalObj3D = new PhysicalObj3D(0,1,10,70,240,1);
         obj.x = GameControl.Instance.Current.selfGamePlayer.pos.x;
         obj.y = GameControl.Instance.Current.selfGamePlayer.pos.y;
         obj.setSpeedXY(new Point(getVx(angle,power),getVy(angle,power)));
         obj.setCollideRect(-3,-3,6,6);
         _map.addPhysical(obj);
         obj.startMoving();
         var result:Array = [];
         while(obj.isMoving())
         {
            result.push(new Point(obj.x,obj.y));
            obj.update(DELAY_TIME);
         }
         return result;
      }
      
      private function getVx(angle:int, power:int) : Number
      {
         var vx:Number = power * Math.cos(angle / 180 * 3.14159265358979);
         return vx;
      }
      
      private function getVy(angle:int, power:int) : Number
      {
         var vy:Number = power * Math.sin(angle / 180 * 3.14159265358979);
         return vy;
      }
   }
}
