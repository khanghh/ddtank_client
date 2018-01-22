package road7th.math
{
   import flash.geom.Point;
   
   public class XLine
   {
       
      
      protected var list:Array;
      
      protected var fix:Boolean = true;
      
      protected var fixValue:Number = 1;
      
      public function XLine(... rest)
      {
         super();
         line = rest;
      }
      
      public static function ToString(param1:Array) : String
      {
         var _loc2_:String = "";
         try
         {
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for each(var _loc3_ in param1)
            {
               _loc2_ = _loc2_ + (_loc3_.x + ":" + _loc3_.y + ",");
            }
         }
         catch(e:Error)
         {
         }
         return _loc2_;
      }
      
      public static function parse(param1:String) : Array
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         try
         {
            _loc3_ = param1.match(/([-]?\d+[\.]?\d*)/g);
            _loc2_ = [];
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_.push(new Point(Number(_loc3_[_loc5_]),Number(_loc3_[_loc5_ + 1])));
               _loc5_ = _loc5_ + 2;
            }
         }
         catch(e:Error)
         {
         }
         return _loc4_;
      }
      
      public function set line(param1:Array) : void
      {
         list = param1;
         if(list == null || list.length == 0)
         {
            fix = true;
            fixValue = 1;
         }
         else if(list.length == 1)
         {
            fix = true;
            fixValue = list[0].y;
         }
         else if(list.length == 2 && list[0].y == list[1].y)
         {
            fix = true;
            fixValue = list[0].y;
         }
         else
         {
            fix = false;
         }
      }
      
      public function get line() : Array
      {
         return list;
      }
      
      public function interpolate(param1:Number) : Number
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(!fix)
         {
            _loc4_ = 1;
            while(_loc4_ < list.length)
            {
               _loc2_ = list[_loc4_];
               _loc3_ = list[_loc4_ - 1];
               if(_loc2_.x <= param1)
               {
                  _loc4_++;
                  continue;
               }
               break;
            }
            return interpolatePointByX(_loc3_,_loc2_,param1);
         }
         return fixValue;
      }
   }
}
