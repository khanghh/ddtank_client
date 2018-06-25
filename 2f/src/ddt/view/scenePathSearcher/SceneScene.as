package ddt.view.scenePathSearcher{   import flash.events.EventDispatcher;   import flash.geom.Point;      public class SceneScene extends EventDispatcher   {                   private var _hitTester:PathIHitTester;            private var _pathSearcher:PathIPathSearcher;            private var _x:Number;            private var _y:Number;            public function SceneScene() { super(); }
            public function get HitTester() : PathIHitTester { return null; }
            public function get x() : Number { return 0; }
            public function get y() : Number { return 0; }
            public function set position(value:Point) : void { }
            public function get position() : Point { return null; }
            public function setPathSearcher(path:PathIPathSearcher) : void { }
            public function setHitTester(tester:PathIHitTester) : void { }
            public function hit(local:Point) : Boolean { return false; }
            public function searchPath(from:Point, to:Point) : Array { return null; }
            public function localToGlobal(point:Point) : Point { return null; }
            public function globalToLocal(point:Point) : Point { return null; }
            public function dispose() : void { }
   }}