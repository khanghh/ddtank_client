package littleGame.data
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   
   public class Grid implements Disposeable
   {
      
      public static const straightCost:Number = 1;
      
      public static const diagCost:Number = 1.41421;
       
      
      public var type:int;
      
      public var cellSize:int = 7;
      
      private var _cols:int;
      
      private var _rows:int;
      
      private var _nodes:Array;
      
      private var _endNode:Node;
      
      private var _startNode:Node;
      
      private var _astar:AStar;
      
      private var _width:int;
      
      private var _height:int;
      
      public function Grid(cols:int, rows:int)
      {
         _nodes = [];
         super();
         _cols = cols;
         _rows = rows;
         _width = _rows * cellSize;
         _height = _cols * cellSize;
         _astar = new AStar(this);
         creatGrid();
      }
      
      public function dispose() : void
      {
         var col:* = null;
         var rows:Array = _nodes.shift();
         while(rows != null)
         {
            col = rows.shift();
            while(col != null)
            {
               ObjectUtils.disposeObject(col);
               col = rows.shift();
            }
            rows = _nodes.shift();
         }
         ObjectUtils.disposeObject(_astar);
         _astar = null;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get nodes() : Array
      {
         return _nodes;
      }
      
      public function get path() : Array
      {
         return _astar.path;
      }
      
      public function get endNode() : Node
      {
         return _endNode;
      }
      
      public function get startNode() : Node
      {
         return _startNode;
      }
      
      public function setEndNode(x:int, y:int) : void
      {
         if(_nodes[y] != null)
         {
            _endNode = _nodes[y][x];
         }
      }
      
      public function setStartNode(x:int, y:int) : void
      {
         if(_nodes[y] != null)
         {
            _startNode = _nodes[y][x];
         }
      }
      
      public function fillPath() : Boolean
      {
         return _astar.fillPath();
      }
      
      private function creatGrid() : void
      {
         var i:int = 0;
         var column:* = null;
         var j:int = 0;
         for(i = 0; i < _cols; )
         {
            column = [];
            for(j = 0; j < _rows; )
            {
               column.push(new Node(j,i));
               j++;
            }
            _nodes.push(column);
            i++;
         }
      }
      
      public function calculateLinks(type:int) : void
      {
         var i:int = 0;
         var j:int = 0;
         this.type = type;
         for(i = 0; i < _cols; )
         {
            for(j = 0; j < _rows; )
            {
               initNodeLink(_nodes[i][j],type);
               j++;
            }
            i++;
         }
      }
      
      public function getNode(x:int, y:int) : Node
      {
         var dy:int = Math.min(y,_nodes.length - 1);
         dy = Math.max(0,dy);
         var dx:int = Math.min(x,_nodes[0].length - 1);
         dx = Math.max(0,dx);
         return _nodes[dy][dx];
      }
      
      public function setNodeWalkAble(x:int, y:int, walkable:Boolean) : void
      {
         if(_nodes[y] && _nodes[y][x])
         {
            _nodes[y][x].walkable = walkable;
         }
      }
      
      private function clearNodeLink(node:Node) : void
      {
      }
      
      private function initNodeLink(node:Node, type:int) : void
      {
         var i:* = 0;
         var j:* = 0;
         var test:* = null;
         var test2:* = null;
         var startX:int = Math.max(0,node.x - 1);
         var endX:int = Math.min(_rows - 1,node.x + 1);
         var startY:int = Math.max(0,node.y - 1);
         var endY:int = Math.min(_cols - 1,node.y + 1);
         var links:Vector.<Node> = new Vector.<Node>();
         for(i = startX; i <= endX; )
         {
            for(j = startY; j <= endY; j++)
            {
               test = getNode(i,j);
               if(!(test == node || !test.walkable))
               {
                  if(type != 2 && i != node.x && j != node.y)
                  {
                     test2 = getNode(node.x,j);
                     if(test2.walkable)
                     {
                        test2 = getNode(i,node.y);
                        if(!test2.walkable)
                        {
                        }
                        continue;
                     }
                     continue;
                  }
                  links[links.length] = test;
                  continue;
               }
            }
            i++;
         }
         node.links = links;
      }
   }
}
