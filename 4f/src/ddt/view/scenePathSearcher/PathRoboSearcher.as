package ddt.view.scenePathSearcher{   import ddt.utils.Geometry;   import flash.geom.Point;      public class PathRoboSearcher implements PathIPathSearcher   {            private static var LEFT:Number = -1;            private static var RIGHT:Number = 1;                   private var step:Number;            private var maxCount:Number;            private var maxDistance:Number;            private var stepTurnNum:Number;            public function PathRoboSearcher(step:Number, maxDistance:Number, num:Number = 4) { super(); }
            public function setStepTurnNum(num:Number) : void { }
            public function search(from:Point, end:Point, hittest:PathIHitTester) : Array { return null; }
            private function searchWithWish(from:Point, tto:Point, tester:PathIHitTester, wish:Number, nodes:Array) : Boolean { return false; }
            private function findFarestBlankPoint(from:Point, tto:Point, t:PathIHitTester) : Point { return null; }
            private function findReversseNearestBlankPoint(from:Point, tto:Point, t:PathIHitTester) : Point { return null; }
            private function doSearchWithWish(from:Point, tto:Point, tester:PathIHitTester, wish:Number, nodes:Array) : Boolean { return false; }
            private function countHeading(p1:Point, p2:Point) : Number { return 0; }
            private function bearing(base:Number, heading:Number) : Number { return 0; }
   }}