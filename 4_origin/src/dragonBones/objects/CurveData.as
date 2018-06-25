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
      
      public function CurveData()
      {
         var i:int = 0;
         _pointList = [];
         sampling = new Vector.<Point>(20);
         super();
         for(i = 0; i < 20 - 1; )
         {
            sampling[i] = new Point();
            i++;
         }
         sampling.fixed = true;
      }
      
      public function getValueByProgress(progress:Number) : Number
      {
         var i:int = 0;
         var point:* = null;
         var prevPoint:* = null;
         if(_dataChanged)
         {
            refreshSampling();
         }
         i = 0;
         while(i < 20 - 1)
         {
            point = sampling[i];
            if(point.x >= progress)
            {
               if(i == 0)
               {
                  return point.y * progress / point.x;
               }
               prevPoint = sampling[i - 1];
               return prevPoint.y + (point.y - prevPoint.y) * (progress - prevPoint.x) / (point.x - prevPoint.x);
            }
            i++;
         }
         return point.y + (1 - point.y) * (progress - point.x) / (1 - point.x);
      }
      
      public function refreshSampling() : void
      {
         var i:int = 0;
         for(i = 0; i < 20 - 1; )
         {
            bezierCurve(0.05 * (i + 1),sampling[i]);
            i++;
         }
         _dataChanged = false;
      }
      
      private function bezierCurve(t:Number, outputPoint:Point) : void
      {
         var l_t:Number = 1 - t;
         outputPoint.x = 3 * point1.x * t * l_t * l_t + 3 * point2.x * t * t * l_t + Math.pow(t,3);
         outputPoint.y = 3 * point1.y * t * l_t * l_t + 3 * point2.y * t * t * l_t + Math.pow(t,3);
      }
      
      public function set pointList(value:Array) : void
      {
         _pointList = value;
         _dataChanged = true;
      }
      
      public function get pointList() : Array
      {
         return _pointList;
      }
      
      public function isCurve() : Boolean
      {
         return point1.x != 0 || point1.y != 0 || point2.x != 1 || point2.y != 1;
      }
      
      public function get point1() : Point
      {
         return pointList[0];
      }
      
      public function get point2() : Point
      {
         return pointList[1];
      }
   }
}
