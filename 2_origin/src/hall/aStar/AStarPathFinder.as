package hall.aStar
{
   import flash.geom.Point;
   import hall.player.aStar.AStar;
   import hall.player.aStar.Grid;
   import hall.player.aStar.Node;
   import starling.scene.hall.SceneMapGridData;
   
   public class AStarPathFinder
   {
       
      
      private var _mapData:SceneMapGridData;
      
      private var _aStar:AStar;
      
      private var _grid:Grid;
      
      public function AStarPathFinder()
      {
         super();
      }
      
      public function init(param1:SceneMapGridData) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _mapData = param1;
         var _loc3_:int = param1.numX;
         var _loc4_:int = param1.numY;
         var _loc2_:Array = param1.gridsTypeArrArr;
         _aStar = new AStar();
         _grid = new Grid(_loc3_,_loc4_,_mapData.cellW,_mapData.cellH);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_loc2_[_loc6_][_loc5_] == 2)
               {
                  _grid.setWalkable(_loc6_,_loc5_,false);
               }
               _loc5_++;
            }
            _loc6_++;
         }
      }
      
      public function hit(param1:Point) : Boolean
      {
         var _loc4_:int = transToNodeCoordinateX(param1.x);
         var _loc3_:int = transToNodeCoordinateY(param1.y);
         if(_loc4_ < 0 || _loc4_ >= _grid.numCols || _loc3_ < 0 || _loc3_ >= _grid.numRows)
         {
            return false;
         }
         var _loc2_:Node = _grid.getNode(_loc4_,_loc3_);
         return !_loc2_.walkable;
      }
      
      public function searchPath(param1:Point, param2:Point) : Array
      {
         var _loc10_:* = null;
         var _loc4_:int = transToNodeCoordinateX(param1.x);
         var _loc5_:int = transToNodeCoordinateY(param1.y);
         var _loc7_:int = transToNodeCoordinateX(param2.x);
         var _loc9_:int = transToNodeCoordinateY(param2.y);
         if(_loc4_ < 0 || _loc4_ >= _grid.numCols || _loc5_ < 0 || _loc5_ >= _grid.numRows || _loc7_ < 0 || _loc7_ >= _grid.numCols || _loc9_ < 0 || _loc9_ >= _grid.numRows)
         {
            return null;
         }
         var _loc6_:Node = _grid.getEndNearNode(_loc4_,_loc5_,_loc7_,_loc9_);
         var _loc8_:Array = searchNodePath(_loc4_,_loc5_,_loc6_.x,_loc6_.y);
         if(_loc8_)
         {
            if(_loc8_.length == 1 && Node(_loc8_[0]).equalXY(_loc4_,_loc5_))
            {
               return null;
            }
            _loc10_ = [];
            var _loc12_:int = 0;
            var _loc11_:* = _loc8_;
            for each(var _loc3_ in _loc8_)
            {
               _loc10_.push(new Point(_loc3_.x * _mapData.cellW + _mapData.cellW / 2,_loc3_.y * _mapData.cellH + _mapData.cellH / 2));
            }
            if(_loc10_ && _loc10_.length > 0 && _grid.getNode(_loc7_,_loc9_).walkable)
            {
               _loc10_.pop();
               _loc10_.push(param2);
            }
         }
         return _loc10_;
      }
      
      public function transToNodeCoordinateX(param1:Number) : int
      {
         return Math.floor(param1 / _mapData.cellW);
      }
      
      public function transToNodeCoordinateY(param1:Number) : int
      {
         return Math.floor(param1 / _mapData.cellH);
      }
      
      private function searchNodePath(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = 0;
         var _loc9_:int = 0;
         _grid.setStartNode(param1,param2);
         _grid.setEndNode(param3,param4);
         var _loc5_:Array = null;
         if(_aStar.findPath(_grid))
         {
            _loc8_ = _aStar.path;
            if(_loc8_.length > 0)
            {
               _loc7_ = _loc8_.length;
               _loc5_ = [_loc8_[0]];
               _loc6_ = 0;
               while(_loc6_ < _loc7_ - 1)
               {
                  _loc9_ = _loc7_ - 1;
                  while(_loc9_ > _loc6_)
                  {
                     if(!_grid.hasBarrier(_loc8_[_loc6_].x,_loc8_[_loc6_].y,_loc8_[_loc9_].x,_loc8_[_loc9_].y))
                     {
                        _loc5_.push(_loc8_[_loc9_]);
                        _loc6_ = _loc9_;
                        break;
                     }
                     _loc9_--;
                  }
                  _loc6_++;
               }
            }
         }
         return _loc5_;
      }
      
      public function dispose() : void
      {
      }
      
      public function get grid() : Grid
      {
         return _grid;
      }
      
      public function get mapData() : SceneMapGridData
      {
         return _mapData;
      }
   }
}
