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
      
      public function VertexList()
      {
         super();
      }
      
      public static function insertAfter(nodeA:VertexList, nodeB:VertexList) : VertexList
      {
         var temp:VertexList = nodeA.next;
         nodeA.next = nodeB;
         nodeB.next = temp;
         nodeB.prev = nodeA;
         nodeB.head = nodeA.head;
         return nodeB;
      }
      
      public static function clone(vertexList:VertexList) : VertexList
      {
         var newHead:* = null;
         var currentClonedNode:* = null;
         var newClonedNode:* = null;
         var currentNode:VertexList = vertexList.head;
         do
         {
            if(newHead == null)
            {
               newHead = getNode();
               newClonedNode = getNode();
            }
            else
            {
               newClonedNode = getNode();
            }
            newClonedNode.head = newHead;
            newClonedNode.index = currentNode.index;
            newClonedNode.vertex = currentNode.vertex;
            newClonedNode.prev = currentClonedNode;
            if(currentClonedNode)
            {
               currentClonedNode.next = newClonedNode;
            }
            currentClonedNode = newClonedNode;
            currentNode = currentNode.next;
         }
         while(currentNode != currentNode.head);
         
         currentClonedNode.next = newHead;
         newHead.prev = currentClonedNode;
         return newHead;
      }
      
      public static function reverse(vertexList:VertexList) : void
      {
         var temp:* = null;
         var node:* = vertexList.head;
         do
         {
            temp = node.next;
            node.next = node.prev;
            node.prev = temp;
            node = temp;
         }
         while(node != vertexList.head);
         
      }
      
      public static function dispose(node:VertexList) : void
      {
         var temp:* = null;
         while(node && node.head)
         {
            releaseNode(node);
            temp = node.next;
            node.next = null;
            node.prev = null;
            node.head = null;
            node.vertex = null;
            node = node.next;
         }
      }
      
      public static function getNode() : VertexList
      {
         if(nodePoolLength > 0)
         {
            nodePoolLength = Number(nodePoolLength) - 1;
            return nodePool.pop();
         }
         return new VertexList();
      }
      
      public static function releaseNode(node:VertexList) : void
      {
         var _loc2_:* = null;
         node.head = _loc2_;
         _loc2_ = _loc2_;
         node.next = _loc2_;
         node.prev = _loc2_;
         node.vertex = null;
         node.index = -1;
         nodePoolLength = Number(nodePoolLength) + 1;
         nodePool[Number(nodePoolLength)] = node;
      }
   }
}
