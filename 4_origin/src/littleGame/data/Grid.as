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
      
      public function Grid(param1:int, param2:int)
      {
         _nodes = [];
         super();
         _cols = param1;
         _rows = param2;
         _width = _rows * cellSize;
         _height = _cols * cellSize;
         _astar = new AStar(this);
         creatGrid();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = _nodes.shift();
         while(_loc2_ != null)
         {
            _loc1_ = _loc2_.shift();
            while(_loc1_ != null)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = _loc2_.shift();
            }
            _loc2_ = _nodes.shift();
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
      
      public function setEndNode(param1:int, param2:int) : void
      {
         if(_nodes[param2] != null)
         {
            _endNode = _nodes[param2][param1];
         }
      }
      
      public function setStartNode(param1:int, param2:int) : void
      {
         if(_nodes[param2] != null)
         {
            _startNode = _nodes[param2][param1];
         }
      }
      
      public function fillPath() : Boolean
      {
         return _astar.fillPath();
      }
      
      private function creatGrid() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _cols)
         {
            _loc1_ = [];
            _loc2_ = 0;
            while(_loc2_ < _rows)
            {
               _loc1_.push(new Node(_loc2_,_loc3_));
               _loc2_++;
            }
            _nodes.push(_loc1_);
            _loc3_++;
         }
      }
      
      public function calculateLinks(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         this.type = param1;
         _loc3_ = 0;
         while(_loc3_ < _cols)
         {
            _loc2_ = 0;
            while(_loc2_ < _rows)
            {
               initNodeLink(_nodes[_loc3_][_loc2_],param1);
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      public function getNode(param1:int, param2:int) : Node
      {
         var _loc4_:int = Math.min(param2,_nodes.length - 1);
         _loc4_ = Math.max(0,_loc4_);
         var _loc3_:int = Math.min(param1,_nodes[0].length - 1);
         _loc3_ = Math.max(0,_loc3_);
         return _nodes[_loc4_][_loc3_];
      }
      
      public function setNodeWalkAble(param1:int, param2:int, param3:Boolean) : void
      {
         if(_nodes[param2] && _nodes[param2][param1])
         {
            _nodes[param2][param1].walkable = param3;
         }
      }
      
      private function clearNodeLink(param1:Node) : void
      {
      }
      
      private function initNodeLink(param1:Node, param2:int) : void
      {
         var _loc11_:* = 0;
         var _loc9_:* = 0;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc3_:int = Math.max(0,param1.x - 1);
         var _loc5_:int = Math.min(_rows - 1,param1.x + 1);
         var _loc4_:int = Math.max(0,param1.y - 1);
         var _loc7_:int = Math.min(_cols - 1,param1.y + 1);
         var _loc8_:Vector.<Node> = new Vector.<Node>();
         _loc11_ = _loc3_;
         while(_loc11_ <= _loc5_)
         {
            _loc9_ = _loc4_;
            for(; _loc9_ <= _loc7_; _loc9_++)
            {
               _loc6_ = getNode(_loc11_,_loc9_);
               if(!(_loc6_ == param1 || !_loc6_.walkable))
               {
                  if(param2 != 2 && _loc11_ != param1.x && _loc9_ != param1.y)
                  {
                     _loc10_ = getNode(param1.x,_loc9_);
                     if(_loc10_.walkable)
                     {
                        _loc10_ = getNode(_loc11_,param1.y);
                        if(!_loc10_.walkable)
                        {
                        }
                        continue;
                     }
                     continue;
                  }
                  _loc8_[_loc8_.length] = _loc6_;
                  continue;
               }
            }
            _loc11_++;
         }
         param1.links = _loc8_;
      }
   }
}
