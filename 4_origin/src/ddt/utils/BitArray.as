package ddt.utils
{
   import flash.utils.ByteArray;
   
   public class BitArray extends ByteArray
   {
       
      
      public function BitArray()
      {
         super();
      }
      
      public function setBit(param1:uint, param2:Boolean) : Boolean
      {
         var _loc3_:uint = param1 >> 3;
         var _loc5_:uint = param1 & 7;
         var _loc4_:uint = this[_loc3_];
         _loc4_ = _loc4_ | 1 << _loc5_;
         this[_loc3_] = _loc4_;
         return true;
      }
      
      public function getBit(param1:uint) : Boolean
      {
         var _loc3_:* = param1 >> 3;
         var _loc5_:* = param1 & 7;
         var _loc4_:int = this[_loc3_];
         var _loc2_:uint = _loc4_ & 1 << _loc5_;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function loadBinary(param1:String) : void
      {
         var _loc2_:* = NaN;
         _loc2_ = 0;
         while(_loc2_ < param1.length * 32)
         {
            setBit(_loc2_,param1 && 1 >> _loc2_);
            _loc2_++;
         }
      }
      
      public function traceBinary(param1:uint) : String
      {
         var _loc6_:* = 0;
         var _loc3_:uint = param1 >> 3;
         var _loc5_:* = param1 & 7;
         var _loc4_:int = this[_loc3_];
         var _loc2_:String = "";
         _loc6_ = uint(0);
         while(_loc6_ < 8)
         {
            if(_loc6_ == _loc5_)
            {
               if(_loc4_ & 1 << _loc6_)
               {
                  _loc2_ = _loc2_ + "[1]";
               }
               else
               {
                  _loc2_ = _loc2_ + "[0]";
               }
            }
            else if(_loc4_ & 1 << _loc6_)
            {
               _loc2_ = _loc2_ + " 1 ";
            }
            else
            {
               _loc2_ = _loc2_ + " 0 ";
            }
            _loc6_++;
         }
         return _loc2_;
      }
   }
}
