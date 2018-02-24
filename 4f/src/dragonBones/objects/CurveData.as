package dragonBones.objects
{
   import flash.geom.Point;
   
   public class CurveData
   {
      
      private static const SamplingTimes:int = 20;
      
      private static const SamplingStep:Number = 0.05;
       
      
      private var _dataChanged:Boolean = false;
      
      private var _pointList:Array;
      
      public var sampling:Vector.<Point>;
      
      public function CurveData(){super();}
      
      public function getValueByProgress(param1:Number) : Number{return 0;}
      
      public function refreshSampling() : void{}
      
      private function bezierCurve(param1:Number, param2:Point) : void{}
      
      public function set pointList(param1:Array) : void{}
      
      public function get pointList() : Array{return null;}
      
      public function isCurve() : Boolean{return false;}
      
      public function get point1() : Point{return null;}
      
      public function get point2() : Point{return null;}
   }
}
