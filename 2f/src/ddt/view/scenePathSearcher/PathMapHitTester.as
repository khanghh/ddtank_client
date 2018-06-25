package ddt.view.scenePathSearcher{   import ddt.utils.Geometry;   import flash.display.Sprite;   import flash.geom.Point;      public class PathMapHitTester implements PathIHitTester   {                   private var mc:Sprite;            public function PathMapHitTester(mesh:Sprite) { super(); }
            public function isHit(point:Point) : Boolean { return false; }
            public function getNextMoveAblePoint(point:Point, angle:Number, step:Number, max:Number) : Point { return null; }
   }}