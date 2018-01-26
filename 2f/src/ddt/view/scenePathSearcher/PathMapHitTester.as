package ddt.view.scenePathSearcher
{
   import ddt.utils.Geometry;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class PathMapHitTester implements PathIHitTester
   {
       
      
      private var mc:Sprite;
      
      public function PathMapHitTester(param1:Sprite){super();}
      
      public function isHit(param1:Point) : Boolean{return false;}
      
      public function getNextMoveAblePoint(param1:Point, param2:Number, param3:Number, param4:Number) : Point{return null;}
   }
}
