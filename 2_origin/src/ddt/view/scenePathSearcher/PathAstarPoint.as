package ddt.view.scenePathSearcher
{
   import flash.geom.Point;
   
   public class PathAstarPoint extends Point
   {
       
      
      public var g:int;
      
      public var h:int;
      
      public var f:int;
      
      public var source_point:PathAstarPoint;
      
      public function PathAstarPoint(x:int = 0, y:int = 0)
      {
         super(x,y);
         source_point = null;
      }
   }
}
