package hall.player.aStar
{
   public class AStar
   {
       
      
      private var _open:Binary;
      
      private var _closed:Array;
      
      private var _grid:Grid;
      
      private var _endNode:Node;
      
      private var _startNode:Node;
      
      private var _path:Array;
      
      private var _heuristic:Function;
      
      private var _straightCost:Number = 1.0;
      
      private var _diagCost:Number = 1.4142135623730951;
      
      public function AStar()
      {
         _heuristic = diagonal;
         super();
      }
      
      public function findPath(grid:Grid) : Boolean
      {
         _grid = grid;
         _startNode = _grid.startNode;
         _endNode = _grid.endNode;
         if(_startNode.x == _endNode.x && _startNode.y == _endNode.y)
         {
            _path = [_endNode];
            return true;
         }
         if(!_grid.hasBarrier(_startNode.x,_startNode.y,_endNode.x,_endNode.y))
         {
            _path = [_endNode];
            return true;
         }
         _open = new Binary("f");
         _closed = [];
         _startNode.g = 0;
         _startNode.h = _heuristic(_startNode);
         _startNode.f = _startNode.g + _startNode.h;
         return search();
      }
      
      public function search() : Boolean
      {
         var startX:int = 0;
         var endX:int = 0;
         var startY:int = 0;
         var endY:int = 0;
         var i:* = 0;
         var j:* = 0;
         var test:* = null;
         var cost:Number = NaN;
         var g:Number = NaN;
         var h:Number = NaN;
         var f:Number = NaN;
         var isInOpen:* = false;
         var node:Node = _startNode;
         while(node != _endNode)
         {
            startX = 0 > node.x - 1?0:Number(node.x - 1);
            endX = _grid.numCols - 1 < node.x + 1?_grid.numCols - 1:Number(node.x + 1);
            startY = 0 > node.y - 1?0:Number(node.y - 1);
            endY = _grid.numRows - 1 < node.y + 1?_grid.numRows - 1:Number(node.y + 1);
            for(i = startX; i <= endX; )
            {
               for(j = startY; j <= endY; )
               {
                  test = _grid.getNode(i,j);
                  if(test != node)
                  {
                     if(!test.walkable || !isDiagonalWalkable(node,test))
                     {
                        test.costMultiplier = 2147483647;
                     }
                     else
                     {
                        test.costMultiplier = 1;
                     }
                     cost = _straightCost;
                     if(!(node.x == test.x || node.y == test.y))
                     {
                        cost = _diagCost;
                     }
                     g = node.g + cost * test.costMultiplier;
                     h = _heuristic(test);
                     f = g + h;
                     isInOpen = _open.indexOf(test) != -1;
                     if(isInOpen || _closed.indexOf(test) != -1)
                     {
                        if(test.f > f)
                        {
                           test.f = f;
                           test.g = g;
                           test.h = h;
                           test.parent = node;
                           if(isInOpen)
                           {
                              _open.updateNode(test);
                           }
                        }
                     }
                     else
                     {
                        test.f = f;
                        test.g = g;
                        test.h = h;
                        test.parent = node;
                        _open.push(test);
                     }
                  }
                  j++;
               }
               i++;
            }
            _closed.push(node);
            if(_open.length == 0)
            {
               trace("no path found");
               return false;
            }
            node = _open.shift() as Node;
         }
         buildPath();
         return true;
      }
      
      private function buildPath() : void
      {
         var i:int = 0;
         _path = [];
         var node:Node = _endNode;
         _path.push(node);
         while(node.parent != _startNode)
         {
            node = node.parent;
            _path.unshift(node);
         }
         var len:int = _path.length;
         for(i = 0; i < len; )
         {
            if(_path[i].walkable == false)
            {
               _path.splice(i,len - i);
               break;
            }
            if(len == 1 && !isDiagonalWalkable(_startNode,_endNode))
            {
               _path.shift();
            }
            else if(i < len - 1 && !isDiagonalWalkable(_path[i],_path[i + 1]))
            {
               _path.splice(i + 1,len - i - 1);
               break;
            }
            i++;
         }
      }
      
      public function get path() : Array
      {
         return _path;
      }
      
      private function isDiagonalWalkable(node1:Node, node2:Node) : Boolean
      {
         var nearByNode1:Node = _grid.getNode(node1.x,node2.y);
         var nearByNode2:Node = _grid.getNode(node2.x,node1.y);
         if(nearByNode1.walkable && nearByNode2.walkable)
         {
            return true;
         }
         return false;
      }
      
      private function manhattan(node:Node) : Number
      {
         return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y + _endNode.y) * _straightCost;
      }
      
      private function euclidian(node:Node) : Number
      {
         var dx:Number = node.x - _endNode.x;
         var dy:Number = node.y - _endNode.y;
         return Math.sqrt(dx * dx + dy * dy) * _straightCost;
      }
      
      private function diagonal(node:Node) : Number
      {
         var dx:Number = node.x - _endNode.x < 0?_endNode.x - node.x:Number(node.x - _endNode.x);
         var dy:Number = node.y - _endNode.y < 0?_endNode.y - node.y:Number(node.y - _endNode.y);
         var diag:Number = dx < dy?dx:Number(dy);
         var straight:Number = dx + dy;
         return _diagCost * diag + _straightCost * (straight - 2 * diag);
      }
   }
}
