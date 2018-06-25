package ddt.view.scenePathSearcher
{
   import flash.geom.Point;
   
   public class PathNode
   {
       
      
      public var costFromStart:int = 0;
      
      public var costToGoal:int = 0;
      
      public var totalCost:int = 0;
      
      public var location:Point;
      
      public var parent:PathNode;
      
      public function PathNode()
      {
         super();
      }
      
      public function equals(node:PathNode) : Boolean
      {
         return node.location.equals(location);
      }
      
      public function toString() : String
      {
         return "x=" + location.x + " y=" + location.y + " G=" + costFromStart + " H=" + costToGoal + " F=" + totalCost;
      }
   }
}
