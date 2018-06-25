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
      
      public function init(mapData:SceneMapGridData) : void
      {
         var i:int = 0;
         var j:int = 0;
         _mapData = mapData;
         var numX:int = mapData.numX;
         var numY:int = mapData.numY;
         var gridTypeArrArr:Array = mapData.gridsTypeArrArr;
         _aStar = new AStar();
         _grid = new Grid(numX,numY,_mapData.cellW,_mapData.cellH);
         for(i = 0; i < numX; )
         {
            for(j = 0; j < numY; )
            {
               if(gridTypeArrArr[i][j] == 2)
               {
                  _grid.setWalkable(i,j,false);
               }
               j++;
            }
            i++;
         }
      }
      
      public function hit(local:Point) : Boolean
      {
         var x:int = transToNodeCoordinateX(local.x);
         var y:int = transToNodeCoordinateY(local.y);
         if(x < 0 || x >= _grid.numCols || y < 0 || y >= _grid.numRows)
         {
            return false;
         }
         var node:Node = _grid.getNode(x,y);
         return !node.walkable;
      }
      
      public function searchPath(from:Point, to:Point) : Array
      {
         var pathArr:* = null;
         var startX:int = transToNodeCoordinateX(from.x);
         var startY:int = transToNodeCoordinateY(from.y);
         var endX:int = transToNodeCoordinateX(to.x);
         var endY:int = transToNodeCoordinateY(to.y);
         if(startX < 0 || startX >= _grid.numCols || startY < 0 || startY >= _grid.numRows || endX < 0 || endX >= _grid.numCols || endY < 0 || endY >= _grid.numRows)
         {
            return null;
         }
         var fixEndNode:Node = _grid.getEndNearNode(startX,startY,endX,endY);
         var nodePathArr:Array = searchNodePath(startX,startY,fixEndNode.x,fixEndNode.y);
         if(nodePathArr)
         {
            if(nodePathArr.length == 1 && Node(nodePathArr[0]).equalXY(startX,startY))
            {
               return null;
            }
            pathArr = [];
            var _loc12_:int = 0;
            var _loc11_:* = nodePathArr;
            for each(var node in nodePathArr)
            {
               pathArr.push(new Point(node.x * _mapData.cellW + _mapData.cellW / 2,node.y * _mapData.cellH + _mapData.cellH / 2));
            }
            if(pathArr && pathArr.length > 0 && _grid.getNode(endX,endY).walkable)
            {
               pathArr.pop();
               pathArr.push(to);
            }
         }
         return pathArr;
      }
      
      public function transToNodeCoordinateX(pointX:Number) : int
      {
         return Math.floor(pointX / _mapData.cellW);
      }
      
      public function transToNodeCoordinateY(pointY:Number) : int
      {
         return Math.floor(pointY / _mapData.cellH);
      }
      
      private function searchNodePath(startNodeX:int, startNodeY:int, endNodeX:int, endNodeY:int) : Array
      {
         var pathArr:* = null;
         var length:int = 0;
         var start:* = 0;
         var end:int = 0;
         _grid.setStartNode(startNodeX,startNodeY);
         _grid.setEndNode(endNodeX,endNodeY);
         var newPathArr:Array = null;
         if(_aStar.findPath(_grid))
         {
            pathArr = _aStar.path;
            if(pathArr.length > 0)
            {
               length = pathArr.length;
               newPathArr = [pathArr[0]];
               for(start = 0; start < length - 1; )
               {
                  end = length - 1;
                  while(end > start)
                  {
                     if(!_grid.hasBarrier(pathArr[start].x,pathArr[start].y,pathArr[end].x,pathArr[end].y))
                     {
                        newPathArr.push(pathArr[end]);
                        start = end;
                        break;
                     }
                     end--;
                  }
                  start++;
               }
            }
         }
         return newPathArr;
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
