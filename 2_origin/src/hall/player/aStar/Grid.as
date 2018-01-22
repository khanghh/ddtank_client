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
      
      public function Grid(param1:int, param2:int, param3:int, param4:int)
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         super();
         _numCols = param1;
         _numRows = param2;
         _nodeW = param3;
         _nodeH = param4;
         _nodes = [];
         _loc6_ = 0;
         while(_loc6_ < _numCols)
         {
            _nodes[_loc6_] = [];
            _loc5_ = 0;
            while(_loc5_ < _numRows)
            {
               _nodes[_loc6_][_loc5_] = new Node(_loc6_,_loc5_);
               _loc5_++;
            }
            _loc6_++;
         }
      }
      
      public function getNode(param1:int, param2:int) : Node
      {
         return _nodes[param1][param2] as Node;
      }
      
      public function setEndNode(param1:int, param2:int) : void
      {
         _endNode = _nodes[param1][param2] as Node;
      }
      
      public function setStartNode(param1:int, param2:int) : void
      {
         _startNode = _nodes[param1][param2] as Node;
      }
      
      public function setWalkable(param1:int, param2:int, param3:Boolean) : void
      {
         _nodes[param1][param2].walkable = param3;
      }
      
      public function getNodesUnderPoint(param1:Number, param2:Number, param3:Array = null) : Array
      {
         var _loc7_:int = 0;
         var _loc4_:Array = [];
         var _loc6_:* = param1 % 1 == 0;
         var _loc5_:* = param2 % 1 == 0;
         if(_loc6_ && _loc5_)
         {
            _loc4_[0] = getNode(param1 - 1,param2 - 1);
            _loc4_[1] = getNode(param1,param2 - 1);
            _loc4_[2] = getNode(param1 - 1,param2);
            _loc4_[3] = getNode(param1,param2);
         }
         else if(_loc6_ && !_loc5_)
         {
            _loc4_[0] = getNode(param1 - 1,int(param2));
            _loc4_[1] = getNode(param1,int(param2));
         }
         else if(!_loc6_ && _loc5_)
         {
            _loc4_[0] = getNode(int(param1),param2 - 1);
            _loc4_[1] = getNode(int(param1),param2);
         }
         else
         {
            _loc4_[0] = getNode(int(param1),int(param2));
         }
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            if(_loc4_[_loc7_] == null)
            {
               _loc4_.splice(_loc7_,1);
               _loc7_--;
            }
            _loc7_++;
         }
         if(param3 && param3.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               if(param3.indexOf(_loc4_[_loc7_]) != -1)
               {
                  _loc4_.splice(_loc7_,1);
                  _loc7_--;
               }
               _loc7_++;
            }
         }
         return _loc4_;
      }
      
      public function hasBarrier(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc7_:* = null;
         var _loc9_:* = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc5_:Number = NaN;
         var _loc11_:Number = NaN;
         if(param1 == param3 && param2 == param4)
         {
            return false;
         }
         var _loc16_:Point = new Point(param1 + 0.5,param2 + 0.5);
         var _loc17_:Point = new Point(param3 + 0.5,param4 + 0.5);
         var _loc15_:Number = Math.abs(param3 - param1);
         var _loc14_:Number = Math.abs(param4 - param2);
         var _loc10_:Boolean = _loc15_ > _loc14_?true:false;
         if(_loc10_)
         {
            _loc7_ = MathUtil.getLineFunc(_loc16_,_loc17_,0);
            _loc6_ = Math.min(param1,param3);
            _loc8_ = Math.max(param1,param3);
            _loc9_ = _loc6_;
            while(_loc9_ <= _loc8_)
            {
               if(_loc9_ == _loc6_)
               {
                  _loc9_ = Number(_loc9_ + 0.5);
               }
               _loc5_ = _loc7_(_loc9_);
               _loc12_ = getNodesUnderPoint(_loc9_,_loc5_);
               var _loc19_:int = 0;
               var _loc18_:* = _loc12_;
               for each(_loc13_ in _loc12_)
               {
                  if(_loc13_.walkable == false)
                  {
                     return true;
                  }
               }
               if(_loc9_ == _loc6_ + 0.5)
               {
                  _loc9_ = Number(_loc9_ - 0.5);
               }
               _loc9_++;
            }
         }
         else
         {
            _loc7_ = MathUtil.getLineFunc(_loc16_,_loc17_,1);
            _loc6_ = Math.min(param2,param4);
            _loc8_ = Math.max(param2,param4);
            _loc9_ = _loc6_;
            while(_loc9_ <= _loc8_)
            {
               if(_loc9_ == _loc6_)
               {
                  _loc9_ = Number(_loc9_ + 0.5);
               }
               _loc11_ = _loc7_(_loc9_);
               _loc12_ = getNodesUnderPoint(_loc11_,_loc9_);
               var _loc21_:int = 0;
               var _loc20_:* = _loc12_;
               for each(_loc13_ in _loc12_)
               {
                  if(_loc13_.walkable == false)
                  {
                     return true;
                  }
               }
               if(_loc9_ == _loc6_ + 0.5)
               {
                  _loc9_ = Number(_loc9_ - 0.5);
               }
               _loc9_++;
            }
         }
         return false;
      }
      
      public function getEndNearNode(param1:int, param2:int, param3:int, param4:int) : Node
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc9_:* = null;
         var _loc7_:Node = getNode(param3,param4);
         if(_loc7_ && _loc7_.walkable)
         {
            return _loc7_;
         }
         if(param1 == param3 && param2 == param4)
         {
            return _loc7_;
         }
         var _loc12_:Point = new Point(param1 + 0.5,param2 + 0.5);
         var _loc13_:Point = new Point(param3 + 0.5,param4 + 0.5);
         var _loc11_:Number = Math.abs(param3 - param1);
         var _loc10_:Number = Math.abs(param4 - param2);
         var _loc8_:Boolean = _loc11_ > _loc10_?true:false;
         if(_loc8_)
         {
            _loc6_ = MathUtil.getLineFunc(_loc12_,_loc13_,0);
            _loc5_ = getDirectionEndNearNode(param1,param3,_loc8_,_loc6_);
            if(_loc5_)
            {
               return _loc5_;
            }
         }
         else
         {
            _loc6_ = MathUtil.getLineFunc(_loc12_,_loc13_,1);
            _loc9_ = getDirectionEndNearNode(param2,param4,_loc8_,_loc6_);
            if(_loc9_)
            {
               return _loc9_;
            }
         }
         return getNode(param1,param2);
      }
      
      public function getDirectionEndNearNode(param1:int, param2:int, param3:Boolean, param4:Function) : Node
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Boolean = false;
         _loc9_ = param2;
         while(param2 <= param1?_loc9_ <= param1:_loc9_ >= param1)
         {
            if(_loc9_ == param2)
            {
               _loc9_ = _loc9_ + 0.5;
            }
            _loc6_ = param4(_loc9_);
            if(param3)
            {
               _loc7_ = getNodesUnderPoint(_loc9_,_loc6_);
            }
            else
            {
               _loc7_ = getNodesUnderPoint(_loc6_,_loc9_);
            }
            _loc5_ = true;
            if(_loc7_.length == 0)
            {
               _loc5_ = false;
            }
            else
            {
               var _loc11_:int = 0;
               var _loc10_:* = _loc7_;
               for each(_loc8_ in _loc7_)
               {
                  if(_loc8_.walkable == false)
                  {
                     _loc5_ = false;
                     break;
                  }
               }
            }
            if(_loc5_)
            {
               return _loc7_[0];
            }
            if(_loc9_ == param2 + 0.5)
            {
               _loc9_ = _loc9_ - 0.5;
            }
            if(param2 <= param1)
            {
               _loc9_++;
               §§push(_loc9_);
            }
            else
            {
               _loc9_--;
               §§push(Number(_loc9_));
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
      
      public function set nodeW(param1:int) : void
      {
         _nodeW = param1;
      }
      
      public function get nodeH() : int
      {
         return _nodeH;
      }
      
      public function set nodeH(param1:int) : void
      {
         _nodeH = param1;
      }
   }
}
