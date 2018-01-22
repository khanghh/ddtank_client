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
      
      public function findPath(param1:Grid) : Boolean
      {
         _grid = param1;
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
         var _loc12_:int = 0;
         var _loc3_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:* = 0;
         var _loc7_:* = 0;
         var _loc4_:* = null;
         var _loc8_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc6_:* = false;
         var _loc11_:Node = _startNode;
         while(_loc11_ != _endNode)
         {
            _loc12_ = 0 > _loc11_.x - 1?0:Number(_loc11_.x - 1);
            _loc3_ = _grid.numCols - 1 < _loc11_.x + 1?_grid.numCols - 1:Number(_loc11_.x + 1);
            _loc13_ = 0 > _loc11_.y - 1?0:Number(_loc11_.y - 1);
            _loc5_ = _grid.numRows - 1 < _loc11_.y + 1?_grid.numRows - 1:Number(_loc11_.y + 1);
            _loc10_ = _loc12_;
            while(_loc10_ <= _loc3_)
            {
               _loc7_ = _loc13_;
               while(_loc7_ <= _loc5_)
               {
                  _loc4_ = _grid.getNode(_loc10_,_loc7_);
                  if(_loc4_ != _loc11_)
                  {
                     if(!_loc4_.walkable || !isDiagonalWalkable(_loc11_,_loc4_))
                     {
                        _loc4_.costMultiplier = 2147483647;
                     }
                     else
                     {
                        _loc4_.costMultiplier = 1;
                     }
                     _loc8_ = _straightCost;
                     if(!(_loc11_.x == _loc4_.x || _loc11_.y == _loc4_.y))
                     {
                        _loc8_ = _diagCost;
                     }
                     _loc2_ = _loc11_.g + _loc8_ * _loc4_.costMultiplier;
                     _loc9_ = _heuristic(_loc4_);
                     _loc1_ = _loc2_ + _loc9_;
                     _loc6_ = _open.indexOf(_loc4_) != -1;
                     if(_loc6_ || _closed.indexOf(_loc4_) != -1)
                     {
                        if(_loc4_.f > _loc1_)
                        {
                           _loc4_.f = _loc1_;
                           _loc4_.g = _loc2_;
                           _loc4_.h = _loc9_;
                           _loc4_.parent = _loc11_;
                           if(_loc6_)
                           {
                              _open.updateNode(_loc4_);
                           }
                        }
                     }
                     else
                     {
                        _loc4_.f = _loc1_;
                        _loc4_.g = _loc2_;
                        _loc4_.h = _loc9_;
                        _loc4_.parent = _loc11_;
                        _open.push(_loc4_);
                     }
                  }
                  _loc7_++;
               }
               _loc10_++;
            }
            _closed.push(_loc11_);
            if(_open.length == 0)
            {
               trace("no path found");
               return false;
            }
            _loc11_ = _open.shift() as Node;
         }
         buildPath();
         return true;
      }
      
      private function buildPath() : void
      {
         var _loc3_:int = 0;
         _path = [];
         var _loc1_:Node = _endNode;
         _path.push(_loc1_);
         while(_loc1_.parent != _startNode)
         {
            _loc1_ = _loc1_.parent;
            _path.unshift(_loc1_);
         }
         var _loc2_:int = _path.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_path[_loc3_].walkable == false)
            {
               _path.splice(_loc3_,_loc2_ - _loc3_);
               break;
            }
            if(_loc2_ == 1 && !isDiagonalWalkable(_startNode,_endNode))
            {
               _path.shift();
            }
            else if(_loc3_ < _loc2_ - 1 && !isDiagonalWalkable(_path[_loc3_],_path[_loc3_ + 1]))
            {
               _path.splice(_loc3_ + 1,_loc2_ - _loc3_ - 1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function get path() : Array
      {
         return _path;
      }
      
      private function isDiagonalWalkable(param1:Node, param2:Node) : Boolean
      {
         var _loc4_:Node = _grid.getNode(param1.x,param2.y);
         var _loc3_:Node = _grid.getNode(param2.x,param1.y);
         if(_loc4_.walkable && _loc3_.walkable)
         {
            return true;
         }
         return false;
      }
      
      private function manhattan(param1:Node) : Number
      {
         return Math.abs(param1.x - _endNode.x) * _straightCost + Math.abs(param1.y + _endNode.y) * _straightCost;
      }
      
      private function euclidian(param1:Node) : Number
      {
         var _loc2_:Number = param1.x - _endNode.x;
         var _loc3_:Number = param1.y - _endNode.y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_) * _straightCost;
      }
      
      private function diagonal(param1:Node) : Number
      {
         var _loc3_:Number = param1.x - _endNode.x < 0?_endNode.x - param1.x:Number(param1.x - _endNode.x);
         var _loc4_:Number = param1.y - _endNode.y < 0?_endNode.y - param1.y:Number(param1.y - _endNode.y);
         var _loc2_:Number = _loc3_ < _loc4_?_loc3_:Number(_loc4_);
         var _loc5_:Number = _loc3_ + _loc4_;
         return _diagCost * _loc2_ + _straightCost * (_loc5_ - 2 * _loc2_);
      }
   }
}
