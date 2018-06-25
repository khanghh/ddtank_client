package ddt.view.scenePathSearcher{   import flash.geom.Point;      public class PathAstarSearcher implements PathIPathSearcher   {                   private var open_list:Array;            private var close_list:Array;            private var path_arr:Array;            private var setOut_point:PathAstarPoint;            private var aim_point:PathAstarPoint;            private var current_point:PathAstarPoint;            private var step_len:int;            private var hittest:PathIHitTester;            private var record_start_point:PathAstarPoint;            public function PathAstarSearcher(n:int) { super(); }
            public function search(from:Point, end:Point, hittest:PathIHitTester) : Array { return null; }
            private function init() : void { }
            private function findPath() : void { }
            private function createPath() : void { }
            private function setEvaluate(point:PathAstarPoint, g:Number, h:Number) : void { }
            private function getEvaluateG(point:PathAstarPoint) : int { return 0; }
            private function getEvaluateH(point:PathAstarPoint) : int { return 0; }
            private function createNode(point:PathAstarPoint) : Array { return null; }
            private function existInArray(arr:Array, point:PathAstarPoint) : int { return 0; }
   }}