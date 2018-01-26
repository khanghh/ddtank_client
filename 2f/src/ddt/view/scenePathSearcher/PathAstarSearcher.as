package ddt.view.scenePathSearcher
{
   import flash.geom.Point;
   
   public class PathAstarSearcher implements PathIPathSearcher
   {
       
      
      private var open_list:Array;
      
      private var close_list:Array;
      
      private var path_arr:Array;
      
      private var setOut_point:PathAstarPoint;
      
      private var aim_point:PathAstarPoint;
      
      private var current_point:PathAstarPoint;
      
      private var step_len:int;
      
      private var hittest:PathIHitTester;
      
      private var record_start_point:PathAstarPoint;
      
      public function PathAstarSearcher(param1:int){super();}
      
      public function search(param1:Point, param2:Point, param3:PathIHitTester) : Array{return null;}
      
      private function init() : void{}
      
      private function findPath() : void{}
      
      private function createPath() : void{}
      
      private function setEvaluate(param1:PathAstarPoint, param2:Number, param3:Number) : void{}
      
      private function getEvaluateG(param1:PathAstarPoint) : int{return 0;}
      
      private function getEvaluateH(param1:PathAstarPoint) : int{return 0;}
      
      private function createNode(param1:PathAstarPoint) : Array{return null;}
      
      private function existInArray(param1:Array, param2:PathAstarPoint) : int{return 0;}
   }
}
