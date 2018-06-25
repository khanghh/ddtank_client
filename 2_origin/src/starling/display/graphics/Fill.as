package starling.display.graphics
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.display.graphics.util.TriangleUtil;
   
   public class Fill extends Graphic
   {
      
      public static const VERTEX_STRIDE:int = 9;
      
      protected static const EPSILON:Number = 1.0E-7;
       
      
      protected var fillVertices:VertexList;
      
      protected var _numVertices:int;
      
      protected var _isConvex:Boolean = true;
      
      public function Fill()
      {
         super();
         clear();
         _uvMatrix = new Matrix();
         _uvMatrix.scale(0.00390625,0.00390625);
      }
      
      protected static function triangulate(vertices:VertexList, _numVertices:int, outputVertices:Vector.<Number>, outputIndices:Vector.<uint>, isConvex:Boolean) : void
      {
         var currentList:* = null;
         var iter:int = 0;
         var flag:Boolean = false;
         var currentNode:* = null;
         var n0:* = null;
         var n1:* = null;
         var n2:* = null;
         var v0x:Number = NaN;
         var v0y:Number = NaN;
         var v1x:Number = NaN;
         var v1y:Number = NaN;
         var v2x:Number = NaN;
         var v2y:Number = NaN;
         var startNode:* = null;
         var n:* = null;
         var found:Boolean = false;
         vertices = VertexList.clone(vertices);
         var openList:Vector.<VertexList> = null;
         if(isConvex == false)
         {
            openList = convertToSimple(vertices);
         }
         else
         {
            openList = new Vector.<VertexList>();
            openList.push(vertices);
         }
         flatten(openList,outputVertices);
         while(openList.length > 0)
         {
            currentList = openList.pop();
            if(isClockWise(currentList) == false)
            {
               VertexList.reverse(currentList);
            }
            iter = 0;
            flag = false;
            currentNode = currentList.head;
            while(iter <= _numVertices * 3)
            {
               iter++;
               n0 = currentNode.prev;
               n1 = currentNode;
               n2 = currentNode.next;
               if(n2.next == n0)
               {
                  outputIndices.push(n0.index,n1.index,n2.index);
                  VertexList.releaseNode(n0);
                  VertexList.releaseNode(n1);
                  VertexList.releaseNode(n2);
                  break;
               }
               v0x = n0.vertex[0];
               v0y = n0.vertex[1];
               v1x = n1.vertex[0];
               v1y = n1.vertex[1];
               v2x = n2.vertex[0];
               v2y = n2.vertex[1];
               if(isReflex(v0x,v0y,v1x,v1y,v2x,v2y) == false)
               {
                  currentNode = currentNode.next;
               }
               else
               {
                  startNode = n2.next;
                  n = startNode;
                  found = false;
                  while(n != n0)
                  {
                     if(TriangleUtil.isPointInTriangle(v0x,v0y,v1x,v1y,v2x,v2y,n.vertex[0],n.vertex[1]))
                     {
                        found = true;
                        break;
                     }
                     n = n.next;
                  }
                  if(found)
                  {
                     currentNode = currentNode.next;
                  }
                  else
                  {
                     outputIndices.push(n0.index,n1.index,n2.index);
                     if(n1 == n1.head)
                     {
                        n1.vertex = n2.vertex;
                        n1.next = n2.next;
                        n1.index = n2.index;
                        n1.next.prev = n1;
                        VertexList.releaseNode(n2);
                     }
                     else
                     {
                        n0.next = n2;
                        n2.prev = n0;
                        VertexList.releaseNode(n1);
                     }
                     currentNode = n0;
                  }
               }
            }
            VertexList.dispose(currentList);
         }
      }
      
      protected static function convertToSimple(vertexList:VertexList) : Vector.<VertexList>
      {
         var currentList:* = null;
         var headA:* = null;
         var nodeA:* = null;
         var isSimple:Boolean = false;
         var nodeB:* = null;
         var isect:* = undefined;
         var temp:* = null;
         var isectNodeA:* = null;
         var headB:* = null;
         var isectNodeB:* = null;
         var output:Vector.<VertexList> = new Vector.<VertexList>();
         var outputLength:int = 0;
         var openList:Vector.<VertexList> = new Vector.<VertexList>();
         openList.push(vertexList);
         while(openList.length > 0)
         {
            currentList = openList.pop();
            headA = currentList.head;
            nodeA = headA;
            isSimple = true;
            if(nodeA.next == nodeA || nodeA.next.next == nodeA || nodeA.next.next.next == nodeA)
            {
               outputLength++;
               output[outputLength] = headA;
            }
            else
            {
               do
               {
                  nodeB = nodeA.next.next;
                  do
                  {
                     isect = intersection(nodeA,nodeA.next,nodeB,nodeB.next);
                     if(isect != null)
                     {
                        isSimple = false;
                        temp = nodeA.next;
                        isectNodeA = VertexList.getNode();
                        isectNodeA.vertex = isect;
                        isectNodeA.prev = nodeA;
                        isectNodeA.next = nodeB.next;
                        isectNodeA.next.prev = isectNodeA;
                        isectNodeA.head = headA;
                        nodeA.next = isectNodeA;
                        headB = nodeB;
                        isectNodeB = VertexList.getNode();
                        isectNodeB.vertex = isect;
                        isectNodeB.prev = nodeB;
                        isectNodeB.next = temp;
                        isectNodeB.next.prev = isectNodeB;
                        isectNodeB.head = headB;
                        nodeB.next = isectNodeB;
                        do
                        {
                           nodeB.head = headB;
                           nodeB = nodeB.next;
                        }
                        while(nodeB != headB);
                        
                        openList.push(headA,headB);
                        break;
                     }
                     nodeB = nodeB.next;
                  }
                  while(nodeB != nodeA.prev && isSimple);
                  
                  nodeA = nodeA.next;
               }
               while(nodeA != headA && isSimple);
               
               if(isSimple)
               {
                  outputLength++;
                  output[outputLength] = headA;
               }
            }
         }
         return output;
      }
      
      protected static function flatten(vertexLists:Vector.<VertexList>, output:Vector.<Number>) : void
      {
         var i:int = 0;
         var vertexList:* = null;
         var node:* = null;
         var L:int = vertexLists.length;
         var index:int = 0;
         for(i = 0; i < L; )
         {
            vertexList = vertexLists[i];
            node = vertexList.head;
            do
            {
               index++;
               node.index = index;
               output.push(node.vertex[0],node.vertex[1],node.vertex[2],node.vertex[3],node.vertex[4],node.vertex[5],node.vertex[6],node.vertex[7],node.vertex[8]);
               node = node.next;
            }
            while(node != node.head);
            
            i++;
         }
      }
      
      protected static function windingNumberAroundPoint(vertexList:VertexList, x:Number, y:Number) : int
      {
         var v0y:Number = NaN;
         var v1y:Number = NaN;
         var v0x:Number = NaN;
         var v1x:Number = NaN;
         var isUp:* = false;
         var wn:int = 0;
         var node:VertexList = vertexList.head;
         do
         {
            v0y = node.vertex[1];
            v1y = node.next.vertex[1];
            if(y > v0y && y < v1y || y > v1y && y < v0y)
            {
               v0x = node.vertex[0];
               v1x = node.next.vertex[0];
               isUp = v1y < y;
               if(isUp)
               {
                  wn = wn + ((v1x - v0x) * (y - v0y) - (v1y - v0y) * (x - v0x) < 0?1:0);
               }
               else
               {
                  wn = wn + ((v1x - v0x) * (y - v0y) - (v1y - v0y) * (x - v0x) < 0?0:-1);
               }
            }
            node = node.next;
         }
         while(node != vertexList.head);
         
         return wn;
      }
      
      public static function isClockWise(vertexList:VertexList) : Boolean
      {
         var wn:* = 0;
         var node:VertexList = vertexList.head;
         do
         {
            wn = Number(wn + (node.next.vertex[0] - node.vertex[0]) * (node.next.vertex[1] + node.vertex[1]));
            node = node.next;
         }
         while(node != vertexList.head);
         
         return wn <= 0;
      }
      
      protected static function windingNumber(vertexList:VertexList) : int
      {
         var wn:int = 0;
         var node:VertexList = vertexList.head;
         do
         {
            wn = wn + ((node.next.vertex[0] - node.vertex[0]) * (node.next.next.vertex[1] - node.vertex[1]) - (node.next.next.vertex[0] - node.vertex[0]) * (node.next.vertex[1] - node.vertex[1]) < 0?-1:1);
            node = node.next;
         }
         while(node != vertexList.head);
         
         return wn;
      }
      
      protected static function isReflex(v0x:Number, v0y:Number, v1x:Number, v1y:Number, v2x:Number, v2y:Number) : Boolean
      {
         if(TriangleUtil.isLeft(v0x,v0y,v1x,v1y,v2x,v2y))
         {
            return false;
         }
         if(TriangleUtil.isLeft(v1x,v1y,v2x,v2y,v0x,v0y))
         {
            return false;
         }
         return true;
      }
      
      protected static function intersection(a0:VertexList, a1:VertexList, b0:VertexList, b1:VertexList) : Vector.<Number>
      {
         var ux:Number = a1.vertex[0] - a0.vertex[0];
         var uy:Number = a1.vertex[1] - a0.vertex[1];
         var vx:Number = b1.vertex[0] - b0.vertex[0];
         var vy:Number = b1.vertex[1] - b0.vertex[1];
         var wx:Number = a0.vertex[0] - b0.vertex[0];
         var wy:Number = a0.vertex[1] - b0.vertex[1];
         var D:Number = ux * vy - uy * vx;
         if((D < 0?-D:Number(D)) < 1.0e-7)
         {
            return null;
         }
         var t:Number = (vx * wy - vy * wx) / D;
         if(t < 0 || t > 1)
         {
            return null;
         }
         var t2:Number = (ux * wy - uy * wx) / D;
         if(t2 < 0 || t2 > 1)
         {
            return null;
         }
         var vertexA:Vector.<Number> = a0.vertex;
         var vertexB:Vector.<Number> = a1.vertex;
         return Vector.<Number>([vertexA[0] + t * (vertexB[0] - vertexA[0]),vertexA[1] + t * (vertexB[1] - vertexA[1]),0,vertexA[3] + t * (vertexB[3] - vertexA[3]),vertexA[4] + t * (vertexB[4] - vertexA[4]),vertexA[5] + t * (vertexB[5] - vertexA[5]),vertexA[6] + t * (vertexB[6] - vertexA[6]),vertexA[7] + t * (vertexB[7] - vertexA[7]),vertexA[8] + t * (vertexB[8] - vertexA[8])]);
      }
      
      public function get numVertices() : int
      {
         return _numVertices;
      }
      
      public function clear() : void
      {
         indices = new Vector.<uint>();
         vertices = new Vector.<Number>();
         if(minBounds)
         {
            var _loc1_:int = 0;
            minBounds.y = _loc1_;
            minBounds.x = _loc1_;
            _loc1_ = 0;
            maxBounds.y = _loc1_;
            maxBounds.x = _loc1_;
         }
         _numVertices = 0;
         VertexList.dispose(fillVertices);
         fillVertices = null;
         setGeometryInvalid();
         _isConvex = true;
      }
      
      override public function dispose() : void
      {
         clear();
         fillVertices = null;
         super.dispose();
      }
      
      public function addDegenerates(destX:Number, destY:Number, color:uint = 16777215, alpha:Number = 1) : void
      {
         var lastColor:* = 0;
         if(_numVertices < 1)
         {
            return;
         }
         var lastVertex:Vector.<Number> = fillVertices.prev.vertex;
         lastColor = uint(uint(lastVertex[3] * 255) << 16);
         lastColor = uint(lastColor | uint(lastVertex[4] * 255) << 8);
         lastColor = uint(lastColor | uint(lastVertex[5] * 255));
         var r:Number = (color >> 16) / 255;
         var g:Number = ((color & 65280) >> 8) / 255;
         var b:Number = (color & 255) / 255;
         addVertex(lastVertex[0],lastVertex[1],lastColor,lastVertex[6]);
         addVertex(destX,destY,color,alpha);
      }
      
      public function addVertexInConvexShape(x:Number, y:Number, color:uint = 16777215, alpha:Number = 1) : void
      {
         addVertexInternal(x,y,color,alpha);
      }
      
      public function addVertex(x:Number, y:Number, color:uint = 16777215, alpha:Number = 1) : void
      {
         _isConvex = false;
         addVertexInternal(x,y,color,alpha);
      }
      
      protected function addVertexInternal(x:Number, y:Number, color:uint = 16777215, alpha:Number = 1) : void
      {
         var r:Number = (color >> 16) / 255;
         var g:Number = ((color & 65280) >> 8) / 255;
         var b:Number = (color & 255) / 255;
         var vertex:Vector.<Number> = Vector.<Number>([x,y,0,r,g,b,alpha,x,y]);
         var node:VertexList = VertexList.getNode();
         if(_numVertices == 0)
         {
            fillVertices = node;
            node.head = node;
            node.prev = node;
         }
         node.next = fillVertices.head;
         node.prev = fillVertices.head.prev;
         node.prev.next = node;
         node.next.prev = node;
         node.index = _numVertices;
         node.vertex = vertex;
         if(x < minBounds.x)
         {
            minBounds.x = x;
         }
         else if(x > maxBounds.x)
         {
            maxBounds.x = x;
         }
         if(y < minBounds.y)
         {
            minBounds.y = y;
         }
         else if(y > maxBounds.y)
         {
            maxBounds.y = y;
         }
         _numVertices = Number(_numVertices) + 1;
         setGeometryInvalid();
      }
      
      override protected function buildGeometry() : void
      {
         if(_numVertices < 3)
         {
            return;
         }
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         triangulate(fillVertices,_numVertices,vertices,indices,_isConvex);
      }
      
      override public function shapeHitTest(stageX:Number, stageY:Number) : Boolean
      {
         if(vertices == null)
         {
            return false;
         }
         if(numVertices < 3)
         {
            return false;
         }
         var pt:Point = globalToLocal(new Point(stageX,stageY));
         var wn:int = windingNumberAroundPoint(fillVertices,pt.x,pt.y);
         if(isClockWise(fillVertices))
         {
            return wn != 0;
         }
         return wn == 0;
      }
      
      override protected function shapeHitTestLocalInternal(localX:Number, localY:Number) : Boolean
      {
         var wn:int = windingNumberAroundPoint(fillVertices,localX,localY);
         if(isClockWise(fillVertices))
         {
            return wn != 0;
         }
         return wn == 0;
      }
   }
}
