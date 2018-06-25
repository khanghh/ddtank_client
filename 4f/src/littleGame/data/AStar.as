package littleGame.data{   import com.pickgliss.ui.core.Disposeable;   import flash.geom.Point;   import flash.utils.getTimer;      public class AStar implements Disposeable   {                   public var heuristic:Function;            private var _straightCost:Number = 1;            private var _diagCost:Number = 1.41421;            private var nowversion:int = 0;            private var TwoOneTwoZero:Number;            private var _endNode:Node;            private var _startNode:Node;            private var _grid:Grid;            private var _open:BinaryHeap;            private var _path:Array;            private var _floydPath:Array;            public function AStar(grid:Grid) { super(); }
            public function dispose() : void { }
            private function justMin(node1:Node, node2:Node) : Boolean { return false; }
            public function manhattan(node:Node) : Number { return 0; }
            public function manhattan2(node:Node) : Number { return 0; }
            public function euclidian(node:Node) : Number { return 0; }
            public function chineseCheckersEuclidian2(node:Node) : Number { return 0; }
            private function sqrt(x:Number) : Number { return 0; }
            public function euclidian2(node:Node) : Number { return 0; }
            public function fillPath() : Boolean { return false; }
            public function search() : Boolean { return false; }
            private function buildPath() : void { }
            public function get path() : Array { return null; }
            public function floyd() : void { }
            private function floydCrossAble(n1:Node, n2:Node) : Boolean { return false; }
            private function floydVector(target:Node, n1:Node, n2:Node) : void { }
            private function bresenhamNodes(p1:Point, p2:Point) : Array { return null; }
            public function get floydPath() : Array { return null; }
   }}