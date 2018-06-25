package game.view{   import flash.geom.Point;   import gameCommon.GameControl;   import phy.maps.Map;   import phy.object.PhysicalObj;      public class RouteComputer   {            private static var DELAY_TIME:Number = 0.04;                   private var _map:Map;            public function RouteComputer(map:Map) { super(); }
            public function getPath(angle:int, power:int) : Array { return null; }
            private function getVx(angle:int, power:int) : Number { return 0; }
            private function getVy(angle:int, power:int) : Number { return 0; }
   }}