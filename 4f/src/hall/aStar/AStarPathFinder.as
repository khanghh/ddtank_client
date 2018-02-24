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
      
      public function AStarPathFinder(){super();}
      
      public function init(param1:SceneMapGridData) : void{}
      
      public function hit(param1:Point) : Boolean{return false;}
      
      public function searchPath(param1:Point, param2:Point) : Array{return null;}
      
      public function transToNodeCoordinateX(param1:Number) : int{return 0;}
      
      public function transToNodeCoordinateY(param1:Number) : int{return 0;}
      
      private function searchNodePath(param1:int, param2:int, param3:int, param4:int) : Array{return null;}
      
      public function dispose() : void{}
      
      public function get grid() : Grid{return null;}
      
      public function get mapData() : SceneMapGridData{return null;}
   }
}
