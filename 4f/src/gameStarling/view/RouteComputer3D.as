package gameStarling.view{   import flash.geom.Point;   import gameCommon.GameControl;   import starlingPhy.maps.Map3D;   import starlingPhy.object.PhysicalObj3D;      public class RouteComputer3D   {            private static var DELAY_TIME:Number = 0.04;                   private var _map:Map3D;            public function RouteComputer3D(map:Map3D) { super(); }
            public function getPath(angle:int, power:int) : Array { return null; }
            private function getVx(angle:int, power:int) : Number { return 0; }
            private function getVy(angle:int, power:int) : Number { return 0; }
   }}