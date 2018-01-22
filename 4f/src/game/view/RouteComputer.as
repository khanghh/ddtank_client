package game.view
{
   import flash.geom.Point;
   import gameCommon.GameControl;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   
   public class RouteComputer
   {
      
      private static var DELAY_TIME:Number = 0.04;
       
      
      private var _map:Map;
      
      public function RouteComputer(param1:Map){super();}
      
      public function getPath(param1:int, param2:int) : Array{return null;}
      
      private function getVx(param1:int, param2:int) : Number{return 0;}
      
      private function getVy(param1:int, param2:int) : Number{return 0;}
   }
}
