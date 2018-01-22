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
         var _loc1_:int = 0;
         _pointList = [];
         sampling = new Vector.<Point>(20);
         super();
         _loc1_ = 0;
         while(_loc1_ < 20 - 1)
         {
            sampling[_loc1_] = new Point();
            _loc1_++;
         }
         sampling.fixed = true;
      }
      
      public function getValueByProgress(param1:Number) : Number
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_dataChanged)
         {
            refreshSampling();
         }
         _loc4_ = 0;
         while(_loc4_ < 20 - 1)
         {
            _loc2_ = sampling[_loc4_];
            if(_loc2_.x >= param1)
            {
               if(_loc4_ == 0)
               {
                  return _loc2_.y * param1 / _loc2_.x;
               }
               _loc3_ = sampling[_loc4_ - 1];
               return _loc3_.y + (_loc2_.y - _loc3_.y) * (param1 - _loc3_.x) / (_loc2_.x - _loc3_.x);
            }
            _loc4_++;
         }
         return _loc2_.y + (1 - _loc2_.y) * (param1 - _loc2_.x) / (1 - _loc2_.x);
      }
      
      public function refreshSampling() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 20 - 1)
         {
            bezierCurve(0.05 * (_loc1_ + 1),sampling[_loc1_]);
            _loc1_++;
         }
         _dataChanged = false;
      }
      
      private function bezierCurve(param1:Number, param2:Point) : void
      {
         var _loc3_:Number = 1 - param1;
         param2.x = 3 * point1.x * param1 * _loc3_ * _loc3_ + 3 * point2.x * param1 * param1 * _loc3_ + Math.pow(param1,3);
         param2.y = 3 * point1.y * param1 * _loc3_ * _loc3_ + 3 * point2.y * param1 * param1 * _loc3_ + Math.pow(param1,3);
      }
      
      public function set pointList(param1:Array) : void
      {
         _pointList = param1;
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
