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
      
      public function AStar(param1:Grid)
      {
         TwoOneTwoZero = 2 * Math.cos(3.14159265358979 / 3);
         super();
         _grid = param1;
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
      
      private function justMin(param1:Node, param2:Node) : Boolean
      {
         return param1.f < param2.f;
      }
      
      public function manhattan(param1:Node) : Number
      {
         return Math.abs(param1.x - this._endNode.x) + Math.abs(param1.y - this._endNode.y);
      }
      
      public function manhattan2(param1:Node) : Number
      {
         var _loc2_:Number = Math.abs(param1.x - this._endNode.x);
         var _loc3_:Number = Math.abs(param1.y - this._endNode.y);
         return _loc2_ + _loc3_ + Math.abs(_loc2_ - _loc3_) / 1000;
      }
      
      public function euclidian(param1:Node) : Number
      {
         var _loc2_:Number = param1.x - this._endNode.x;
         var _loc3_:Number = param1.y - this._endNode.y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function chineseCheckersEuclidian2(param1:Node) : Number
      {
         var _loc5_:Number = param1.y / TwoOneTwoZero;
         var _loc4_:Number = param1.x + param1.y / 2;
         var _loc2_:Number = _loc4_ - _endNode.x - _endNode.y / 2;
         var _loc3_:Number = _loc5_ - _endNode.y / TwoOneTwoZero;
         return this.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      private function sqrt(param1:Number) : Number
      {
         return Math.sqrt(param1);
      }
      
      public function euclidian2(param1:Node) : Number
      {
         var _loc2_:Number = param1.x - _endNode.x;
         var _loc3_:Number = param1.y - _endNode.y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      public function fillPath() : Boolean
      {
         _endNode = _grid.endNode;
         _startNode = _grid.startNode;
         nowversion = Number(nowversion) + 1;
         _open = new BinaryHeap(justMin);
         _startNode.g = 0;
         var _loc2_:int = getTimer();
         var _loc1_:Boolean = search();
         return _loc1_;
      }
      
      public function search() : Boolean
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = NaN;
         var _loc2_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc3_:Node = _startNode;
         _loc3_.version = nowversion;
         while(_loc3_ != _endNode)
         {
            _loc5_ = _loc3_.links.length;
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc4_ = _loc3_.links[_loc8_];
               if(!(_loc3_.x == _loc4_.x || _loc3_.y == _loc4_.y))
               {
                  _loc6_ = 1.41421;
               }
               else
               {
                  _loc6_ = 1;
               }
               _loc2_ = _loc3_.g + _loc6_;
               _loc7_ = heuristic(_loc4_);
               _loc1_ = _loc2_ + _loc7_;
               if(_loc4_.version == nowversion)
               {
                  if(_loc4_.f > _loc1_)
                  {
                     _loc4_.f = _loc1_;
                     _loc4_.g = _loc2_;
                     _loc4_.h = _loc7_;
                     _loc4_.parent = _loc3_;
                  }
               }
               else
               {
                  _loc4_.f = _loc1_;
                  _loc4_.g = _loc2_;
                  _loc4_.h = _loc7_;
                  _loc4_.parent = _loc3_;
                  _open.ins(_loc4_);
                  _loc4_.version = nowversion;
               }
               _loc8_++;
            }
            if(_open.a.length == 1)
            {
               return false;
            }
            _loc3_ = _open.pop() as Node;
         }
         buildPath();
         return true;
      }
      
      private function buildPath() : void
      {
         _path = [];
         var _loc1_:Node = _endNode;
         _path.push(_loc1_);
         while(_loc1_ != _startNode)
         {
            _loc1_ = _loc1_.parent;
            this._path.unshift(_loc1_);
         }
      }
      
      public function get path() : Array
      {
         return _path;
      }
      
      public function floyd() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc6_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(path == null)
         {
            return;
         }
         _floydPath = path.concat();
         var _loc3_:int = _floydPath.length;
         if(_loc3_ > 2)
         {
            _loc2_ = new Node(0,0);
            _loc1_ = new Node(0,0);
            floydVector(_loc2_,_floydPath[_loc3_ - 1],_floydPath[_loc3_ - 2]);
            _loc6_ = int(_floydPath.length - 3);
            while(_loc6_ >= 0)
            {
               floydVector(_loc1_,_floydPath[_loc6_ + 1],_floydPath[_loc6_]);
               if(_loc2_.x == _loc1_.x && _loc2_.y == _loc1_.y)
               {
                  _floydPath.splice(_loc6_ + 1,1);
               }
               else
               {
                  _loc2_.x = _loc1_.x;
                  _loc2_.y = _loc1_.y;
               }
               _loc6_--;
            }
         }
         _loc3_ = _floydPath.length;
         _loc6_ = int(_loc3_ - 1);
         while(_loc6_ >= 0)
         {
            _loc4_ = 0;
            while(_loc4_ <= _loc6_ - 2)
            {
               if(floydCrossAble(_floydPath[_loc6_],_floydPath[_loc4_]))
               {
                  _loc5_ = _loc6_ - 1;
                  while(_loc5_ > _loc4_)
                  {
                     _floydPath.splice(_loc5_,1);
                     _loc5_--;
                  }
                  _loc6_ = _loc4_;
                  _loc3_ = _floydPath.length;
                  break;
               }
               _loc4_++;
            }
            _loc6_--;
         }
      }
      
      private function floydCrossAble(param1:Node, param2:Node) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = bresenhamNodes(new Point(param1.x,param1.y),new Point(param2.x,param2.y));
         _loc3_ = _loc4_.length - 2;
         while(_loc3_ > 0)
         {
            if(!_grid.getNode(_loc4_[_loc3_].x,_loc4_[_loc3_].y).walkable)
            {
               return false;
            }
            _loc3_--;
         }
         return true;
      }
      
      private function floydVector(param1:Node, param2:Node, param3:Node) : void
      {
         param1.x = param2.x - param3.x;
         param1.y = param2.y - param3.y;
      }
      
      private function bresenhamNodes(param1:Point, param2:Point) : Array
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = Math.abs(param2.y - param1.y) > Math.abs(param2.x - param1.x);
         if(_loc7_)
         {
            _loc9_ = param1.x;
            param1.x = param1.y;
            param1.y = _loc9_;
            _loc9_ = param2.x;
            param2.x = param2.y;
            param2.y = _loc9_;
         }
         var _loc4_:int = param2.x > param1.x?1:Number(param2.x < param1.x?-1:0);
         var _loc5_:int = param2.y > param1.y?1:Number(param2.y < param1.y?-1:0);
         var _loc12_:Number = (param2.y - param1.y) / Math.abs(param2.x - param1.x);
         var _loc3_:Array = [];
         var _loc11_:Number = param1.x + _loc4_;
         var _loc10_:Number = param1.y + _loc12_;
         if(_loc7_)
         {
            _loc3_.push(new Point(param1.y,param1.x));
         }
         else
         {
            _loc3_.push(new Point(param1.x,param1.y));
         }
         while(_loc11_ != param2.x)
         {
            _loc6_ = Math.floor(_loc10_);
            _loc8_ = Math.ceil(_loc10_);
            if(_loc7_)
            {
               _loc3_.push(new Point(_loc6_,_loc11_));
            }
            else
            {
               _loc3_.push(new Point(_loc11_,_loc6_));
            }
            if(_loc6_ != _loc8_)
            {
               if(_loc7_)
               {
                  _loc3_.push(new Point(_loc8_,_loc11_));
               }
               else
               {
                  _loc3_.push(new Point(_loc11_,_loc8_));
               }
            }
            _loc11_ = _loc11_ + _loc4_;
            _loc10_ = _loc10_ + _loc12_;
         }
         if(_loc7_)
         {
            _loc3_.push(new Point(param2.y,param2.x));
         }
         else
         {
            _loc3_.push(new Point(param2.x,param2.y));
         }
         return _loc3_;
      }
      
      public function get floydPath() : Array
      {
         return _floydPath;
      }
   }
}
