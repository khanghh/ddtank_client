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
      
      public function RouteComputer3D(param1:Map3D){super();}
      
      public function getPath(param1:int, param2:int) : Array{return null;}
      
      private function getVx(param1:int, param2:int) : Number{return 0;}
      
      private function getVy(param1:int, param2:int) : Number{return 0;}
   }
}
