package littleGame.data
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class AStar implements Disposeable
   {
       
      
      public var heuristic:Function;
      
      private var _straightCost:Number = 1;
      
      private var _diagCost:Number = 1.41421;
      
      private var nowversion:int = 0;
      
      private var TwoOneTwoZero:Number;
      
      private var _endNode:Node;
      
      private var _startNode:Node;
      
      private var _grid:Grid;
      
      private var _open:BinaryHeap;
      
      private var _path:Array;
      
      private var _floydPath:Array;
      
      public function AStar(grid:Grid)
      {
         TwoOneTwoZero = 2 * Math.cos(3.14159265358979 / 3);
         super();
         _grid = grid;
         heuristic = euclidian2;
      }
      
      public function dispose() : void
      {
         _open = null;
         heuristic = null;
         _startNode = null;
         _endNode = null;
         _grid = null;
         _path = null;
      }
      
      private function justMin(node1:Node, node2:Node) : Boolean
      {
         return node1.f < node2.f;
      }
      
      public function manhattan(node:Node) : Number
      {
         return Math.abs(node.x - this._endNode.x) + Math.abs(node.y - this._endNode.y);
      }
      
      public function manhattan2(node:Node) : Number
      {
         var dx:Number = Math.abs(node.x - this._endNode.x);
         var dy:Number = Math.abs(node.y - this._endNode.y);
         return dx + dy + Math.abs(dx - dy) / 1000;
      }
      
      public function euclidian(node:Node) : Number
      {
         var dx:Number = node.x - this._endNode.x;
         var dy:Number = node.y - this._endNode.y;
         return Math.sqrt(dx * dx + dy * dy);
      }
      
      public function chineseCheckersEuclidian2(node:Node) : Number
      {
         var x:Number = node.y / TwoOneTwoZero;
         var y:Number = node.x + node.y / 2;
         var dx:Number = y - _endNode.x - _endNode.y / 2;
         var dy:Number = x - _endNode.y / TwoOneTwoZero;
         return this.sqrt(dx * dx + dy * dy);
      }
      
      private function sqrt(x:Number) : Number
      {
         return Math.sqrt(x);
      }
      
      public function euclidian2(node:Node) : Number
      {
         var dx:Number = node.x - _endNode.x;
         var dy:Number = node.y - _endNode.y;
         return dx * dx + dy * dy;
      }
      
      public function fillPath() : Boolean
      {
         _endNode = _grid.endNode;
         _startNode = _grid.startNode;
         nowversion = Number(nowversion) + 1;
         _open = new BinaryHeap(justMin);
         _startNode.g = 0;
         var time:int = getTimer();
         var resutl:Boolean = search();
         return resutl;
      }
      
      public function search() : Boolean
      {
         var len:int = 0;
         var i:int = 0;
         var test:* = null;
         var cost:* = NaN;
         var g:Number = NaN;
         var h:Number = NaN;
         var f:Number = NaN;
         var node:Node = _startNode;
         node.version = nowversion;
         while(node != _endNode)
         {
            len = node.links.length;
            for(i = 0; i < len; )
            {
               test = node.links[i];
               if(!(node.x == test.x || node.y == test.y))
               {
                  cost = 1.41421;
               }
               else
               {
                  cost = 1;
               }
               g = node.g + cost;
               h = heuristic(test);
               f = g + h;
               if(test.version == nowversion)
               {
                  if(test.f > f)
                  {
                     test.f = f;
                     test.g = g;
                     test.h = h;
                     test.parent = node;
                  }
               }
               else
               {
                  test.f = f;
                  test.g = g;
                  test.h = h;
                  test.parent = node;
                  _open.ins(test);
                  test.version = nowversion;
               }
               i++;
            }
            if(_open.a.length == 1)
            {
               return false;
            }
            node = _open.pop() as Node;
         }
         buildPath();
         return true;
      }
      
      private function buildPath() : void
      {
         _path = [];
         var current:Node = _endNode;
         _path.push(current);
         while(current != _startNode)
         {
            current = current.parent;
            this._path.unshift(current);
         }
      }
      
      public function get path() : Array
      {
         return _path;
      }
      
      public function floyd() : void
      {
         var vector:* = null;
         var tempVector:* = null;
         var i:* = 0;
         var j:int = 0;
         var k:int = 0;
         if(path == null)
         {
            return;
         }
         _floydPath = path.concat();
         var len:int = _floydPath.length;
         if(len > 2)
         {
            vector = new Node(0,0);
            tempVector = new Node(0,0);
            floydVector(vector,_floydPath[len - 1],_floydPath[len - 2]);
            for(i = int(_floydPath.length - 3); i >= 0; )
            {
               floydVector(tempVector,_floydPath[i + 1],_floydPath[i]);
               if(vector.x == tempVector.x && vector.y == tempVector.y)
               {
                  _floydPath.splice(i + 1,1);
               }
               else
               {
                  vector.x = tempVector.x;
                  vector.y = tempVector.y;
               }
               i--;
            }
         }
         len = _floydPath.length;
         for(i = int(len - 1); i >= 0; )
         {
            for(j = 0; j <= i - 2; )
            {
               if(floydCrossAble(_floydPath[i],_floydPath[j]))
               {
                  for(k = i - 1; k > j; )
                  {
                     _floydPath.splice(k,1);
                     k--;
                  }
                  i = j;
                  len = _floydPath.length;
                  break;
               }
               j++;
            }
            i--;
         }
      }
      
      private function floydCrossAble(n1:Node, n2:Node) : Boolean
      {
         var i:int = 0;
         var ps:Array = bresenhamNodes(new Point(n1.x,n1.y),new Point(n2.x,n2.y));
         for(i = ps.length - 2; i > 0; )
         {
            if(!_grid.getNode(ps[i].x,ps[i].y).walkable)
            {
               return false;
            }
            i--;
         }
         return true;
      }
      
      private function floydVector(target:Node, n1:Node, n2:Node) : void
      {
         target.x = n1.x - n2.x;
         target.y = n1.y - n2.y;
      }
      
      private function bresenhamNodes(p1:Point, p2:Point) : Array
      {
         var temp:int = 0;
         var fy:int = 0;
         var cy:int = 0;
         var steep:* = Math.abs(p2.y - p1.y) > Math.abs(p2.x - p1.x);
         if(steep)
         {
            temp = p1.x;
            p1.x = p1.y;
            p1.y = temp;
            temp = p2.x;
            p2.x = p2.y;
            p2.y = temp;
         }
         var stepX:int = p2.x > p1.x?1:Number(p2.x < p1.x?-1:0);
         var stepY:int = p2.y > p1.y?1:Number(p2.y < p1.y?-1:0);
         var deltay:Number = (p2.y - p1.y) / Math.abs(p2.x - p1.x);
         var ret:Array = [];
         var nowX:Number = p1.x + stepX;
         var nowY:Number = p1.y + deltay;
         if(steep)
         {
            ret.push(new Point(p1.y,p1.x));
         }
         else
         {
            ret.push(new Point(p1.x,p1.y));
         }
         while(nowX != p2.x)
         {
            fy = Math.floor(nowY);
            cy = Math.ceil(nowY);
            if(steep)
            {
               ret.push(new Point(fy,nowX));
            }
            else
            {
               ret.push(new Point(nowX,fy));
            }
            if(fy != cy)
            {
               if(steep)
               {
                  ret.push(new Point(cy,nowX));
               }
               else
               {
                  ret.push(new Point(nowX,cy));
               }
            }
            nowX = nowX + stepX;
            nowY = nowY + deltay;
         }
         if(steep)
         {
            ret.push(new Point(p2.y,p2.x));
         }
         else
         {
            ret.push(new Point(p2.x,p2.y));
         }
         return ret;
      }
      
      public function get floydPath() : Array
      {
         return _floydPath;
      }
   }
}
