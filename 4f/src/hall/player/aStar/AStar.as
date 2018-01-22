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
      
      public function AStar(){super();}
      
      public function findPath(param1:Grid) : Boolean{return false;}
      
      public function search() : Boolean{return false;}
      
      private function buildPath() : void{}
      
      public function get path() : Array{return null;}
      
      private function isDiagonalWalkable(param1:Node, param2:Node) : Boolean{return false;}
      
      private function manhattan(param1:Node) : Number{return 0;}
      
      private function euclidian(param1:Node) : Number{return 0;}
      
      private function diagonal(param1:Node) : Number{return 0;}
   }
}
