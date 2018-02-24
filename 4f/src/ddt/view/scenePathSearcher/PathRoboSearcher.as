package ddt.view.scenePathSearcher
{
   import ddt.utils.Geometry;
   import flash.geom.Point;
   
   public class PathRoboSearcher implements PathIPathSearcher
   {
      
      private static var LEFT:Number = -1;
      
      private static var RIGHT:Number = 1;
       
      
      private var step:Number;
      
      private var maxCount:Number;
      
      private var maxDistance:Number;
      
      private var stepTurnNum:Number;
      
      public function PathRoboSearcher(param1:Number, param2:Number, param3:Number = 4){super();}
      
      public function setStepTurnNum(param1:Number) : void{}
      
      public function search(param1:Point, param2:Point, param3:PathIHitTester) : Array{return null;}
      
      private function searchWithWish(param1:Point, param2:Point, param3:PathIHitTester, param4:Number, param5:Array) : Boolean{return false;}
      
      private function findFarestBlankPoint(param1:Point, param2:Point, param3:PathIHitTester) : Point{return null;}
      
      private function findReversseNearestBlankPoint(param1:Point, param2:Point, param3:PathIHitTester) : Point{return null;}
      
      private function doSearchWithWish(param1:Point, param2:Point, param3:PathIHitTester, param4:Number, param5:Array) : Boolean{return false;}
      
      private function countHeading(param1:Point, param2:Point) : Number{return 0;}
      
      private function bearing(param1:Number, param2:Number) : Number{return 0;}
   }
}
