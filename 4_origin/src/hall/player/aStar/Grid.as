package hall.player.aStar
{
   import flash.geom.Point;
   
   public class Grid
   {
       
      
      private var _startNode:Node;
      
      private var _endNode:Node;
      
      private var _nodes:Array;
      
      private var _numCols:int;
      
      private var _numRows:int;
      
      private var _nodeW:int;
      
      private var _nodeH:int;
      
      public function Grid(numCols:int, numRows:int, nodeW:int, nodeH:int)
      {
         var i:int = 0;
         var j:int = 0;
         super();
         _numCols = numCols;
         _numRows = numRows;
         _nodeW = nodeW;
         _nodeH = nodeH;
         _nodes = [];
         for(i = 0; i < _numCols; )
         {
            _nodes[i] = [];
            for(j = 0; j < _numRows; )
            {
               _nodes[i][j] = new Node(i,j);
               j++;
            }
            i++;
         }
      }
      
      public function getNode(x:int, y:int) : Node
      {
         return _nodes[x][y] as Node;
      }
      
      public function setEndNode(x:int, y:int) : void
      {
         _endNode = _nodes[x][y] as Node;
      }
      
      public function setStartNode(x:int, y:int) : void
      {
         _startNode = _nodes[x][y] as Node;
      }
      
      public function setWalkable(x:int, y:int, value:Boolean) : void
      {
         _nodes[x][y].walkable = value;
      }
      
      public function getNodesUnderPoint(xPos:Number, yPos:Number, exception:Array = null) : Array
      {
         var i:int = 0;
         var result:Array = [];
         var xIsInt:* = xPos % 1 == 0;
         var yIsInt:* = yPos % 1 == 0;
         if(xIsInt && yIsInt)
         {
            result[0] = getNode(xPos - 1,yPos - 1);
            result[1] = getNode(xPos,yPos - 1);
            result[2] = getNode(xPos - 1,yPos);
            result[3] = getNode(xPos,yPos);
         }
         else if(xIsInt && !yIsInt)
         {
            result[0] = getNode(xPos - 1,int(yPos));
            result[1] = getNode(xPos,int(yPos));
         }
         else if(!xIsInt && yIsInt)
         {
            result[0] = getNode(int(xPos),yPos - 1);
            result[1] = getNode(int(xPos),yPos);
         }
         else
         {
            result[0] = getNode(int(xPos),int(yPos));
         }
         for(i = 0; i < result.length; )
         {
            if(result[i] == null)
            {
               result.splice(i,1);
               i--;
            }
            i++;
         }
         if(exception && exception.length > 0)
         {
            for(i = 0; i < result.length; )
            {
               if(exception.indexOf(result[i]) != -1)
               {
                  result.splice(i,1);
                  i--;
               }
               i++;
            }
         }
         return result;
      }
      
      public function hasBarrier(startX:int, startY:int, endX:int, endY:int) : Boolean
      {
         var lineFuction:* = null;
         var i:* = NaN;
         var loopStart:Number = NaN;
         var loopEnd:Number = NaN;
         var passedNodeList:* = null;
         var passedNode:* = null;
         var yPos:Number = NaN;
         var xPos:Number = NaN;
         if(startX == endX && startY == endY)
         {
            return false;
         }
         var point1:Point = new Point(startX + 0.5,startY + 0.5);
         var point2:Point = new Point(endX + 0.5,endY + 0.5);
         var distX:Number = Math.abs(endX - startX);
         var distY:Number = Math.abs(endY - startY);
         var loopDirection:Boolean = distX > distY?true:false;
         if(loopDirection)
         {
            lineFuction = MathUtil.getLineFunc(point1,point2,0);
            loopStart = Math.min(startX,endX);
            loopEnd = Math.max(startX,endX);
            for(i = loopStart; i <= loopEnd; )
            {
               if(i == loopStart)
               {
                  i = Number(i + 0.5);
               }
               yPos = lineFuction(i);
               passedNodeList = getNodesUnderPoint(i,yPos);
               var _loc19_:int = 0;
               var _loc18_:* = passedNodeList;
               for each(passedNode in passedNodeList)
               {
                  if(passedNode.walkable == false)
                  {
                     return true;
                  }
               }
               if(i == loopStart + 0.5)
               {
                  i = Number(i - 0.5);
               }
               i++;
            }
         }
         else
         {
            lineFuction = MathUtil.getLineFunc(point1,point2,1);
            loopStart = Math.min(startY,endY);
            loopEnd = Math.max(startY,endY);
            for(i = loopStart; i <= loopEnd; )
            {
               if(i == loopStart)
               {
                  i = Number(i + 0.5);
               }
               xPos = lineFuction(i);
               passedNodeList = getNodesUnderPoint(xPos,i);
               var _loc21_:int = 0;
               var _loc20_:* = passedNodeList;
               for each(passedNode in passedNodeList)
               {
                  if(passedNode.walkable == false)
                  {
                     return true;
                  }
               }
               if(i == loopStart + 0.5)
               {
                  i = Number(i - 0.5);
               }
               i++;
            }
         }
         return false;
      }
      
      public function getEndNearNode(startX:int, startY:int, endX:int, endY:int) : Node
      {
         var lineFuction:* = null;
         var nodeH:* = null;
         var nodeV:* = null;
         var endNode:Node = getNode(endX,endY);
         if(endNode && endNode.walkable)
         {
            return endNode;
         }
         if(startX == endX && startY == endY)
         {
            return endNode;
         }
         var point1:Point = new Point(startX + 0.5,startY + 0.5);
         var point2:Point = new Point(endX + 0.5,endY + 0.5);
         var distX:Number = Math.abs(endX - startX);
         var distY:Number = Math.abs(endY - startY);
         var loopDirection:Boolean = distX > distY?true:false;
         if(loopDirection)
         {
            lineFuction = MathUtil.getLineFunc(point1,point2,0);
            nodeH = getDirectionEndNearNode(startX,endX,loopDirection,lineFuction);
            if(nodeH)
            {
               return nodeH;
            }
         }
         else
         {
            lineFuction = MathUtil.getLineFunc(point1,point2,1);
            nodeV = getDirectionEndNearNode(startY,endY,loopDirection,lineFuction);
            if(nodeV)
            {
               return nodeV;
            }
         }
         return getNode(startX,startY);
      }
      
      public function getDirectionEndNearNode(start:int, end:int, loopDirection:Boolean, lineFuction:Function) : Node
      {
         var passedNodeList:* = null;
         var passedNode:* = null;
         var i:Number = NaN;
         var xyPos:Number = NaN;
         var allWalkable:Boolean = false;
         i = end;
         while(end <= start?i <= start:i >= start)
         {
            if(i == end)
            {
               i = i + 0.5;
            }
            xyPos = lineFuction(i);
            if(loopDirection)
            {
               passedNodeList = getNodesUnderPoint(i,xyPos);
            }
            else
            {
               passedNodeList = getNodesUnderPoint(xyPos,i);
            }
            allWalkable = true;
            if(passedNodeList.length == 0)
            {
               allWalkable = false;
            }
            else
            {
               var _loc11_:int = 0;
               var _loc10_:* = passedNodeList;
               for each(passedNode in passedNodeList)
               {
                  if(passedNode.walkable == false)
                  {
                     allWalkable = false;
                     break;
                  }
               }
            }
            if(allWalkable)
            {
               return passedNodeList[0];
            }
            if(i == end + 0.5)
            {
               i = i - 0.5;
            }
            if(end <= start)
            {
               i++;
               §§push(i);
            }
            else
            {
               i--;
               §§push(Number(i));
            }
            §§pop();
         }
         return null;
      }
      
      public function get endNode() : Node
      {
         return _endNode;
      }
      
      public function get numCols() : int
      {
         return _numCols;
      }
      
      public function get numRows() : int
      {
         return _numRows;
      }
      
      public function get startNode() : Node
      {
         return _startNode;
      }
      
      public function get nodeW() : int
      {
         return _nodeW;
      }
      
      public function set nodeW(value:int) : void
      {
         _nodeW = value;
      }
      
      public function get nodeH() : int
      {
         return _nodeH;
      }
      
      public function set nodeH(value:int) : void
      {
         _nodeH = value;
      }
   }
}
