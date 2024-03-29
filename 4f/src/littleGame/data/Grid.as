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
      
      public function Grid(param1:int, param2:int){super();}
      
      public function dispose() : void{}
      
      public function get width() : int{return 0;}
      
      public function get height() : int{return 0;}
      
      public function get nodes() : Array{return null;}
      
      public function get path() : Array{return null;}
      
      public function get endNode() : Node{return null;}
      
      public function get startNode() : Node{return null;}
      
      public function setEndNode(param1:int, param2:int) : void{}
      
      public function setStartNode(param1:int, param2:int) : void{}
      
      public function fillPath() : Boolean{return false;}
      
      private function creatGrid() : void{}
      
      public function calculateLinks(param1:int) : void{}
      
      public function getNode(param1:int, param2:int) : Node{return null;}
      
      public function setNodeWalkAble(param1:int, param2:int, param3:Boolean) : void{}
      
      private function clearNodeLink(param1:Node) : void{}
      
      private function initNodeLink(param1:Node, param2:int) : void{}
   }
}
