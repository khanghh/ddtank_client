package hall.player.aStar{   import flash.geom.Point;      public class Grid   {                   private var _startNode:Node;            private var _endNode:Node;            private var _nodes:Array;            private var _numCols:int;            private var _numRows:int;            private var _nodeW:int;            private var _nodeH:int;            public function Grid(numCols:int, numRows:int, nodeW:int, nodeH:int) { super(); }
            public function getNode(x:int, y:int) : Node { return null; }
            public function setEndNode(x:int, y:int) : void { }
            public function setStartNode(x:int, y:int) : void { }
            public function setWalkable(x:int, y:int, value:Boolean) : void { }
            public function getNodesUnderPoint(xPos:Number, yPos:Number, exception:Array = null) : Array { return null; }
            public function hasBarrier(startX:int, startY:int, endX:int, endY:int) : Boolean { return false; }
            public function getEndNearNode(startX:int, startY:int, endX:int, endY:int) : Node { return null; }
            public function getDirectionEndNearNode(start:int, end:int, loopDirection:Boolean, lineFuction:Function) : Node { return null; }
            public function get endNode() : Node { return null; }
            public function get numCols() : int { return 0; }
            public function get numRows() : int { return 0; }
            public function get startNode() : Node { return null; }
            public function get nodeW() : int { return 0; }
            public function set nodeW(value:int) : void { }
            public function get nodeH() : int { return 0; }
            public function set nodeH(value:int) : void { }
   }}