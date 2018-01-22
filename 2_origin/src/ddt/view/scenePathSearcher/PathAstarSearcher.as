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
      
      public function PathAstarSearcher(param1:int)
      {
         super();
         step_len = param1;
      }
      
      public function search(param1:Point, param2:Point, param3:PathIHitTester) : Array
      {
         aim_point = new PathAstarPoint(param2.x,param2.y);
         record_start_point = new PathAstarPoint(param1.x,param1.y);
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param2.x > param1.x)
         {
            _loc5_ = param1.x - (step_len - Math.abs(param2.x - param1.x) % step_len);
         }
         else
         {
            _loc5_ = param1.x + (step_len - Math.abs(param2.x - param1.x) % step_len);
         }
         if(param2.y > param1.y)
         {
            _loc4_ = param1.y - (step_len - Math.abs(param2.y - param1.y) % step_len);
         }
         else
         {
            _loc4_ = param1.y + (step_len - Math.abs(param2.y - param1.y) % step_len);
         }
         setOut_point = new PathAstarPoint(_loc5_,_loc4_);
         current_point = setOut_point;
         this.hittest = param3;
         init();
         findPath();
         return path_arr;
      }
      
      private function init() : void
      {
         open_list = [];
         close_list = [];
         path_arr = [];
      }
      
      private function findPath() : void
      {
         var _loc3_:* = null;
         var _loc5_:* = NaN;
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc6_:int = 0;
         open_list.push(setOut_point);
         var _loc4_:Boolean = true;
         while(open_list.length > 0 && _loc4_)
         {
            current_point = open_list.shift();
            if(current_point.x == aim_point.x && current_point.y == aim_point.y)
            {
               _loc4_ = false;
               aim_point = _loc3_[_loc6_];
               aim_point.source_point = current_point;
               break;
            }
            _loc3_ = [];
            _loc3_ = createNode(current_point);
            _loc5_ = 0;
            _loc1_ = 0;
            _loc2_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc3_[_loc6_].x == aim_point.x && _loc3_[_loc6_].y == aim_point.y)
               {
                  _loc4_ = false;
                  aim_point = _loc3_[_loc6_];
                  aim_point.source_point = current_point;
                  break;
               }
               if(existInArray(open_list,_loc3_[_loc6_]) == -1 && existInArray(close_list,_loc3_[_loc6_]) == -1)
               {
                  if(!hittest.isHit(_loc3_[_loc6_]))
                  {
                     _loc3_[_loc6_].source_point = current_point;
                     _loc5_ = Number(getEvaluateG(_loc3_[_loc6_]));
                     _loc2_ = Number(getEvaluateH(_loc3_[_loc6_]));
                     setEvaluate(_loc3_[_loc6_],_loc5_,_loc2_);
                     open_list.push(_loc3_[_loc6_]);
                  }
               }
               else if(existInArray(open_list,_loc3_[_loc6_]) != -1)
               {
                  _loc5_ = Number(getEvaluateG(_loc3_[_loc6_]));
                  _loc2_ = Number(getEvaluateH(_loc3_[_loc6_]));
                  _loc1_ = Number(_loc5_ + _loc2_);
                  if(_loc1_ < _loc3_[_loc6_].f)
                  {
                     _loc3_[_loc6_].source_point = current_point;
                     setEvaluate(_loc3_[_loc6_],_loc5_,_loc2_);
                  }
               }
               else
               {
                  _loc5_ = Number(getEvaluateG(_loc3_[_loc6_]));
                  _loc2_ = Number(getEvaluateH(_loc3_[_loc6_]));
                  _loc1_ = Number(_loc5_ + _loc2_);
                  if(_loc1_ < _loc3_[_loc6_].f)
                  {
                     _loc3_[_loc6_].source_point = current_point;
                     setEvaluate(_loc3_[_loc6_],_loc5_,_loc2_);
                     open_list.push(_loc3_[_loc6_]);
                     close_list.splice(existInArray(close_list,_loc3_[_loc6_]),1);
                  }
               }
               _loc6_++;
            }
            close_list.push(current_point);
            open_list.sortOn("f",16);
            if(open_list.length > 30)
            {
               open_list = open_list.slice(0,30);
            }
         }
         createPath();
      }
      
      private function createPath() : void
      {
         var _loc1_:PathAstarPoint = new PathAstarPoint();
         _loc1_ = aim_point;
         while(_loc1_ != setOut_point)
         {
            path_arr.unshift(_loc1_);
            if(_loc1_.source_point != null)
            {
               _loc1_ = _loc1_.source_point;
               continue;
            }
            path_arr = [];
            path_arr.push(record_start_point,record_start_point);
            return;
         }
         path_arr.splice(0,0,record_start_point);
      }
      
      private function setEvaluate(param1:PathAstarPoint, param2:Number, param3:Number) : void
      {
         param1.g = param2;
         param1.h = param3;
         param1.f = param1.g + param1.h;
      }
      
      private function getEvaluateG(param1:PathAstarPoint) : int
      {
         var _loc2_:int = 0;
         if(current_point.x == param1.x || current_point.y == param1.y)
         {
            _loc2_ = 10;
         }
         else
         {
            _loc2_ = 14;
         }
         _loc2_ = _loc2_ + current_point.g;
         return _loc2_;
      }
      
      private function getEvaluateH(param1:PathAstarPoint) : int
      {
         return Math.abs(aim_point.x - param1.x) * 10 + Math.abs(aim_point.y - param1.y) * 10;
      }
      
      private function createNode(param1:PathAstarPoint) : Array
      {
         var _loc2_:Array = [];
         _loc2_.push(new PathAstarPoint(param1.x,param1.y - step_len));
         _loc2_.push(new PathAstarPoint(param1.x - step_len,param1.y));
         _loc2_.push(new PathAstarPoint(param1.x + step_len,param1.y));
         _loc2_.push(new PathAstarPoint(param1.x,param1.y + step_len));
         _loc2_.push(new PathAstarPoint(param1.x - step_len,param1.y - step_len));
         _loc2_.push(new PathAstarPoint(param1.x + step_len,param1.y - step_len));
         _loc2_.push(new PathAstarPoint(param1.x - step_len,param1.y + step_len));
         _loc2_.push(new PathAstarPoint(param1.x + step_len,param1.y + step_len));
         return _loc2_;
      }
      
      private function existInArray(param1:Array, param2:PathAstarPoint) : int
      {
         var _loc4_:int = 0;
         var _loc3_:* = -1;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].x == param2.x && param1[_loc4_].y == param2.y)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
