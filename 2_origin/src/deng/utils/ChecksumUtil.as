package deng.utils
{
   import flash.utils.ByteArray;
   
   public class ChecksumUtil
   {
      
      private static var crcTable:Array = makeCRCTable();
       
      
      public function ChecksumUtil()
      {
         super();
      }
      
      private static function makeCRCTable() : Array
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:Array = [];
         _loc4_ = uint(0);
         while(_loc4_ < 256)
         {
            _loc1_ = _loc4_;
            _loc3_ = uint(0);
            while(_loc3_ < 8)
            {
               if(_loc1_ & 1)
               {
                  _loc1_ = uint(3988292384 ^ _loc1_ >>> 1);
               }
               else
               {
                  _loc1_ = uint(_loc1_ >>> 1);
               }
               _loc3_++;
            }
            _loc2_.push(_loc1_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function CRC32(param1:ByteArray, param2:uint = 0, param3:uint = 0) : uint
      {
         var _loc5_:* = 0;
         if(param2 >= param1.length)
         {
            param2 = param1.length;
         }
         if(param3 == 0)
         {
            param3 = param1.length - param2;
         }
         if(param3 + param2 > param1.length)
         {
            param3 = param1.length - param2;
         }
         var _loc4_:* = 4294967295;
         _loc5_ = param2;
         while(_loc5_ < param3)
         {
            _loc4_ = uint(uint(crcTable[(_loc4_ ^ param1[_loc5_]) & 255]) ^ _loc4_ >>> 8);
            _loc5_++;
         }
         return _loc4_ ^ 4294967295;
      }
      
      public static function Adler32(param1:ByteArray, param2:uint = 0, param3:uint = 0) : uint
      {
         if(param2 >= param1.length)
         {
            param2 = param1.length;
         }
         if(param3 == 0)
         {
            param3 = param1.length - param2;
         }
         if(param3 + param2 > param1.length)
         {
            param3 = param1.length - param2;
         }
         var _loc6_:* = param2;
         var _loc5_:uint = 1;
         var _loc4_:uint = 0;
         while(_loc6_ < param2 + param3)
         {
            _loc5_ = (_loc5_ + param1[_loc6_]) % 65521;
            _loc4_ = (_loc5_ + _loc4_) % 65521;
            _loc6_++;
         }
         return _loc4_ << 16 | _loc5_;
      }
   }
}
