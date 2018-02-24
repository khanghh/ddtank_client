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
      
      public function Grid(param1:int, param2:int, param3:int, param4:int){super();}
      
      public function getNode(param1:int, param2:int) : Node{return null;}
      
      public function setEndNode(param1:int, param2:int) : void{}
      
      public function setStartNode(param1:int, param2:int) : void{}
      
      public function setWalkable(param1:int, param2:int, param3:Boolean) : void{}
      
      public function getNodesUnderPoint(param1:Number, param2:Number, param3:Array = null) : Array{return null;}
      
      public function hasBarrier(param1:int, param2:int, param3:int, param4:int) : Boolean{return false;}
      
      public function getEndNearNode(param1:int, param2:int, param3:int, param4:int) : Node{return null;}
      
      public function getDirectionEndNearNode(param1:int, param2:int, param3:Boolean, param4:Function) : Node{return null;}
      
      public function get endNode() : Node{return null;}
      
      public function get numCols() : int{return 0;}
      
      public function get numRows() : int{return 0;}
      
      public function get startNode() : Node{return null;}
      
      public function get nodeW() : int{return 0;}
      
      public function set nodeW(param1:int) : void{}
      
      public function get nodeH() : int{return 0;}
      
      public function set nodeH(param1:int) : void{}
   }
}
