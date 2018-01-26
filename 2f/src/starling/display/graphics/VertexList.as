package starling.display.graphics
{
   public final class VertexList
   {
      
      private static var nodePool:Vector.<VertexList> = new Vector.<VertexList>();
      
      private static var nodePoolLength:int = 0;
       
      
      public var vertex:Vector.<Number>;
      
      public var next:VertexList;
      
      public var prev:VertexList;
      
      public var index:int;
      
      public var head:VertexList;
      
      public function VertexList(){super();}
      
      public static function insertAfter(param1:VertexList, param2:VertexList) : VertexList{return null;}
      
      public static function clone(param1:VertexList) : VertexList{return null;}
      
      public static function reverse(param1:VertexList) : void{}
      
      public static function dispose(param1:VertexList) : void{}
      
      public static function getNode() : VertexList{return null;}
      
      public static function releaseNode(param1:VertexList) : void{}
   }
}
