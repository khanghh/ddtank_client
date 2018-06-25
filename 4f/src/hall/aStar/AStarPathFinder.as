package hall.aStar{   import flash.geom.Point;   import hall.player.aStar.AStar;   import hall.player.aStar.Grid;   import hall.player.aStar.Node;   import starling.scene.hall.SceneMapGridData;      public class AStarPathFinder   {                   private var _mapData:SceneMapGridData;            private var _aStar:AStar;            private var _grid:Grid;            public function AStarPathFinder() { super(); }
            public function init(mapData:SceneMapGridData) : void { }
            public function hit(local:Point) : Boolean { return false; }
            public function searchPath(from:Point, to:Point) : Array { return null; }
            public function transToNodeCoordinateX(pointX:Number) : int { return 0; }
            public function transToNodeCoordinateY(pointY:Number) : int { return 0; }
            private function searchNodePath(startNodeX:int, startNodeY:int, endNodeX:int, endNodeY:int) : Array { return null; }
            public function dispose() : void { }
            public function get grid() : Grid { return null; }
            public function get mapData() : SceneMapGridData { return null; }
   }}