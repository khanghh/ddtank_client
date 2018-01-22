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
      
      public function PathRoboSearcher(param1:Number, param2:Number, param3:Number = 4)
      {
         super();
         this.step = param1;
         this.maxDistance = param2;
         maxCount = Math.ceil(param2 / param1) * 2;
         stepTurnNum = param3;
      }
      
      public function setStepTurnNum(param1:Number) : void
      {
         stepTurnNum = param1;
      }
      
      public function search(param1:Point, param2:Point, param3:PathIHitTester) : Array
      {
         var _loc6_:Array = [param1,param1];
         if(param1.equals(param2))
         {
            return _loc6_;
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc7_:Boolean = searchWithWish(param1,param2,param3,LEFT,_loc4_);
         var _loc8_:Boolean = searchWithWish(param1,param2,param3,RIGHT,_loc5_);
         if(_loc7_ && _loc8_)
         {
            if(_loc4_.length < _loc5_.length)
            {
               return _loc4_;
            }
            return _loc5_;
         }
         if(_loc7_)
         {
            return _loc4_;
         }
         if(_loc8_)
         {
            return _loc5_;
         }
         return _loc6_;
      }
      
      private function searchWithWish(param1:Point, param2:Point, param3:PathIHitTester, param4:Number, param5:Array) : Boolean
      {
         var _loc12_:* = null;
         var _loc7_:Boolean = false;
         var _loc10_:* = null;
         var _loc14_:Boolean = false;
         var _loc9_:* = null;
         var _loc13_:Number = NaN;
         var _loc11_:* = NaN;
         var _loc6_:* = null;
         if(param3.isHit(param2))
         {
            param2 = findReversseNearestBlankPoint(param1,param2,param3);
            if(param2 == null)
            {
               return false;
            }
            if(param3.isHit(param1))
            {
               param5.push(param1);
               param5.push(param2);
               return true;
            }
         }
         else if(param3.isHit(param1))
         {
            _loc12_ = findReversseNearestBlankPoint(param2,param1,param3);
            if(_loc12_ == null)
            {
               return false;
            }
            _loc7_ = searchWithWish(_loc12_,param2,param3,param4,param5);
            if(_loc7_)
            {
               param5.splice(0,0,param1);
               return true;
            }
            return false;
         }
         if(Point.distance(param1,param2) > maxDistance)
         {
            param5.push(param1);
            param2 = findFarestBlankPoint(param1,param2,param3);
            if(param2 == null)
            {
               return false;
            }
            param5.push(param2);
            return true;
         }
         var _loc8_:Boolean = doSearchWithWish(param1,param2,param3,param4,param5);
         if(!_loc8_)
         {
            return false;
         }
         if(param5.length > 4)
         {
            _loc10_ = [];
            _loc14_ = doSearchWithWish(param2,param5[0],param3,0 - param4,_loc10_);
            if(_loc14_)
            {
               _loc9_ = Point(_loc10_[_loc10_.length - 2]);
               _loc13_ = step;
               _loc11_ = 1;
               while(_loc11_ < param5.length - 1)
               {
                  _loc6_ = Point(param5[_loc11_]);
                  if(Point.distance(_loc6_,_loc9_) < _loc13_)
                  {
                     param5.splice(1,_loc11_,_loc9_);
                     return true;
                  }
                  _loc11_++;
               }
            }
         }
         return true;
      }
      
      private function findFarestBlankPoint(param1:Point, param2:Point, param3:PathIHitTester) : Point
      {
         var _loc8_:* = NaN;
         var _loc5_:* = null;
         if(param3.isHit(param1))
         {
            return findReversseNearestBlankPoint(param2,param1,param3);
         }
         var _loc7_:Number = countHeading(param1,param2);
         var _loc10_:Number = Point.distance(param1,param2);
         var _loc9_:* = param1;
         while(!param3.isHit(param1))
         {
            _loc9_ = param1;
            param1 = Geometry.nextPoint(param1,_loc7_,step);
            _loc10_ = _loc10_ - step;
            if(_loc10_ <= 0)
            {
               return null;
            }
         }
         param1 = _loc9_;
         var _loc6_:* = 8;
         var _loc4_:Number = 3.14159265358979 / _loc6_;
         _loc8_ = 1;
         while(_loc8_ < _loc6_)
         {
            _loc5_ = Geometry.nextPoint(param1,_loc7_ + _loc8_ * _loc4_,step * 2);
            if(!param3.isHit(_loc5_))
            {
               return _loc5_;
            }
            _loc5_ = Geometry.nextPoint(param1,_loc7_ - _loc8_ * _loc4_,step * 2);
            if(!param3.isHit(_loc5_))
            {
               return _loc5_;
            }
            _loc8_++;
         }
         return param1;
      }
      
      private function findReversseNearestBlankPoint(param1:Point, param2:Point, param3:PathIHitTester) : Point
      {
         var _loc8_:* = NaN;
         var _loc5_:* = null;
         var _loc7_:Number = countHeading(param2,param1);
         var _loc9_:Number = Point.distance(param2,param1);
         while(param3.isHit(param2))
         {
            param2 = Geometry.nextPoint(param2,_loc7_,step);
            _loc9_ = _loc9_ - step;
            if(_loc9_ <= 0)
            {
               return null;
            }
         }
         var _loc6_:* = 12;
         var _loc4_:Number = 3.14159265358979 / _loc6_;
         _loc7_ = _loc7_ + 3.14159265358979;
         _loc8_ = 1;
         while(_loc8_ < _loc6_)
         {
            _loc5_ = Geometry.nextPoint(param2,_loc7_ + _loc8_ * _loc4_,step * 2);
            if(!param3.isHit(_loc5_))
            {
               return _loc5_;
            }
            _loc5_ = Geometry.nextPoint(param2,_loc7_ - _loc8_ * _loc4_,step * 2);
            if(!param3.isHit(_loc5_))
            {
               return _loc5_;
            }
            _loc8_++;
         }
         return param2;
      }
      
      private function doSearchWithWish(param1:Point, param2:Point, param3:PathIHitTester, param4:Number, param5:Array) : Boolean
      {
         var _loc8_:Number = NaN;
         var _loc16_:* = NaN;
         var _loc18_:Number = NaN;
         var _loc7_:* = null;
         var _loc12_:* = null;
         var _loc15_:Number = NaN;
         var _loc13_:Boolean = false;
         var _loc11_:* = NaN;
         param5.push(param1);
         var _loc9_:Number = param4 * 3.14159265358979 / stepTurnNum;
         var _loc10_:Number = param4 * 3.14159265358979 / 2;
         var _loc6_:* = 1;
         var _loc14_:Number = step;
         var _loc19_:* = Number(countHeading(param1,param2));
         var _loc17_:* = Number(Point.distance(param1,param2));
         while(true)
         {
            if(!(_loc17_ > _loc14_ && _loc6_ < maxCount))
            {
               if(_loc6_ <= maxCount)
               {
                  param5.push(param2);
                  return true;
               }
               return false;
            }
            _loc8_ = countHeading(param1,param2);
            _loc16_ = Number(_loc19_ - _loc10_);
            _loc18_ = bearing(_loc8_,_loc16_);
            if(param4 > 0 && _loc18_ < 0 || param4 < 0 && _loc18_ > 0)
            {
               _loc16_ = _loc8_;
            }
            _loc7_ = Geometry.nextPoint(param1,_loc16_,step);
            _loc12_ = param1;
            if(param3.isHit(_loc7_))
            {
               _loc13_ = false;
               _loc11_ = 2;
               while(_loc11_ < stepTurnNum * 2)
               {
                  _loc16_ = Number(_loc16_ + _loc9_);
                  _loc7_ = Geometry.nextPoint(param1,_loc16_,step);
                  if(!param3.isHit(_loc7_))
                  {
                     param1 = _loc7_;
                     _loc15_ = Point.distance(param1,param2);
                     _loc13_ = true;
                     break;
                  }
                  _loc11_++;
               }
               if(!_loc13_)
               {
                  break;
               }
            }
            else
            {
               param1 = _loc7_;
               _loc15_ = Point.distance(param1,param2);
            }
            if(Math.abs(bearing(_loc19_,_loc16_)) > 0.01)
            {
               param5.push(_loc12_);
               _loc19_ = _loc16_;
            }
            _loc17_ = _loc15_;
         }
         trace("cant find one");
         param5.splice(0);
         return false;
      }
      
      private function countHeading(param1:Point, param2:Point) : Number
      {
         return Math.atan2(param2.y - param1.y,param2.x - param1.x);
      }
      
      private function bearing(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 - param1;
         _loc3_ = (_loc3_ + 3.14159265358979 * 4) % (3.14159265358979 * 2);
         if(_loc3_ < -3.14159265358979)
         {
            _loc3_ = _loc3_ + 3.14159265358979 * 2;
         }
         else if(_loc3_ > 3.14159265358979)
         {
            _loc3_ = _loc3_ - 3.14159265358979 * 2;
         }
         return _loc3_;
      }
   }
}
