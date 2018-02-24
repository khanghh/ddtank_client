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
      
      public function AStar(param1:Grid){super();}
      
      public function dispose() : void{}
      
      private function justMin(param1:Node, param2:Node) : Boolean{return false;}
      
      public function manhattan(param1:Node) : Number{return 0;}
      
      public function manhattan2(param1:Node) : Number{return 0;}
      
      public function euclidian(param1:Node) : Number{return 0;}
      
      public function chineseCheckersEuclidian2(param1:Node) : Number{return 0;}
      
      private function sqrt(param1:Number) : Number{return 0;}
      
      public function euclidian2(param1:Node) : Number{return 0;}
      
      public function fillPath() : Boolean{return false;}
      
      public function search() : Boolean{return false;}
      
      private function buildPath() : void{}
      
      public function get path() : Array{return null;}
      
      public function floyd() : void{}
      
      private function floydCrossAble(param1:Node, param2:Node) : Boolean{return false;}
      
      private function floydVector(param1:Node, param2:Node, param3:Node) : void{}
      
      private function bresenhamNodes(param1:Point, param2:Point) : Array{return null;}
      
      public function get floydPath() : Array{return null;}
   }
}
