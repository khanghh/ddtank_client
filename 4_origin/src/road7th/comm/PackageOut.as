package road7th.comm
{
   import flash.utils.ByteArray;
   
   public class PackageOut extends ByteArray
   {
      
      public static const HEADER:int = 29099;
       
      
      private var _checksum:int;
      
      private var _code:int;
      
      public function PackageOut(param1:int, param2:int = 0, param3:int = 0, param4:int = 0)
      {
         super();
         writeShort(29099);
         writeShort(0);
         writeShort(0);
         writeShort(param1);
         writeInt(param2);
         writeInt(param3);
         writeInt(param4);
         _code = param1;
         _checksum = 0;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function pack() : void
      {
         _checksum = calculateCheckSum();
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeShort(length);
         _loc1_.writeShort(_checksum);
         this[2] = _loc1_[0];
         this[3] = _loc1_[1];
         this[4] = _loc1_[2];
         this[5] = _loc1_[3];
      }
      
      public function calculateCheckSum() : int
      {
         var _loc1_:int = 119;
         var _loc2_:int = 6;
         while(_loc2_ < length)
         {
            _loc2_++;
            _loc1_ = _loc1_ + this[_loc2_];
         }
         return _loc1_ & 32639;
      }
      
      public function writeDate(param1:Date) : void
      {
         writeShort(param1.getFullYear());
         writeByte(param1.month + 1);
         writeByte(param1.date);
         writeByte(param1.hours);
         writeByte(param1.minutes);
         writeByte(param1.seconds);
      }
   }
}
