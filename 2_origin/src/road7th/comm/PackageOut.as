package road7th.comm
{
   import flash.utils.ByteArray;
   
   public class PackageOut extends ByteArray
   {
      
      public static const HEADER:int = 29099;
       
      
      private var _checksum:int;
      
      private var _code:int;
      
      public function PackageOut(code:int, toId:int = 0, extend1:int = 0, extend2:int = 0)
      {
         super();
         writeShort(29099);
         writeShort(0);
         writeShort(0);
         writeShort(code);
         writeInt(toId);
         writeInt(extend1);
         writeInt(extend2);
         _code = code;
         _checksum = 0;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function pack() : void
      {
         _checksum = calculateCheckSum();
         var temp:ByteArray = new ByteArray();
         temp.writeShort(length);
         temp.writeShort(_checksum);
         this[2] = temp[0];
         this[3] = temp[1];
         this[4] = temp[2];
         this[5] = temp[3];
      }
      
      public function calculateCheckSum() : int
      {
         var val1:int = 119;
         var i:int = 6;
         while(i < length)
         {
            i++;
            val1 = val1 + this[i];
         }
         return val1 & 32639;
      }
      
      public function writeDate(date:Date) : void
      {
         writeShort(date.getFullYear());
         writeByte(date.month + 1);
         writeByte(date.date);
         writeByte(date.hours);
         writeByte(date.minutes);
         writeByte(date.seconds);
      }
   }
}
