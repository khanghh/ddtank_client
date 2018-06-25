package starling.display.graphics{   public final class VertexList   {            private static var nodePool:Vector.<VertexList> = new Vector.<VertexList>();            private static var nodePoolLength:int = 0;                   public var vertex:Vector.<Number>;            public var next:VertexList;            public var prev:VertexList;            public var index:int;            public var head:VertexList;            public function VertexList() { super(); }
            public static function insertAfter(nodeA:VertexList, nodeB:VertexList) : VertexList { return null; }
            public static function clone(vertexList:VertexList) : VertexList { return null; }
            public static function reverse(vertexList:VertexList) : void { }
            public static function dispose(node:VertexList) : void { }
            public static function getNode() : VertexList { return null; }
            public static function releaseNode(node:VertexList) : void { }
   }}