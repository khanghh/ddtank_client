package road7th.comm
{
   import flash.utils.ByteArray;
   
   public class PackageIn extends ByteArray
   {
      
      public static const HEADER_SIZE:Number = 20;
       
      
      private var _len:int;
      
      private var _checksum:int;
      
      private var _clientId:int;
      
      private var _code:int;
      
      private var _extend1:int;
      
      private var _extend2:int;
      
      public function PackageIn()
      {
         super();
      }
      
      public function load(src:ByteArray, len:int) : void
      {
         writeByte(src.readByte());
         readHeader();
      }
      
      public function loadE(src:ByteArray, len:int, key:ByteArray) : void
      {
         var i:int = 0;
         var origion:ByteArray = new ByteArray();
         var result:ByteArray = new ByteArray();
         for(i = 0; i < len; )
         {
            origion.writeByte(src.readByte());
            result.writeByte(origion[i]);
            i++;
         }
         for(i = 0; i < len; )
         {
            if(i > 0)
            {
               key[i % 8] = key[i % 8] + origion[i - 1] ^ i;
               result[i] = origion[i] - origion[i - 1] ^ key[i % 8];
            }
            else
            {
               result[i] = origion[i] ^ key[0];
            }
            i++;
         }
         result.position = 0;
         for(i = 0; i < len; )
         {
            writeByte(result.readByte());
            i++;
         }
         position = 0;
         readHeader();
      }
      
      public function loadFightByteInfo(extend1:int, extend2:int, len:int, src:ByteArray, index:int) : void
      {
         _extend1 = extend1;
         _extend2 = extend2;
         _len = len;
         writeBytes(src);
         position = 20;
      }
      
      public function readHeader() : void
      {
         readShort();
         _len = readShort();
         _checksum = readShort();
         _code = readShort();
         _clientId = readInt();
         _extend1 = readInt();
         _extend2 = readInt();
      }
      
      public function get checkSum() : int
      {
         return _checksum;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function get clientId() : int
      {
         return _clientId;
      }
      
      public function get extend1() : int
      {
         return _extend1;
      }
      
      public function get extend2() : int
      {
         return _extend2;
      }
      
      public function get Len() : int
      {
         return _len;
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
      
      public function readXml() : XML
      {
         return new XML(readUTF());
      }
      
      public function readDateString() : String
      {
         return readShort() + "-" + readByte() + "-" + readByte() + " " + readByte() + ":" + readByte() + ":" + readByte();
      }
      
      public function readDate() : Date
      {
         var year:int = readShort();
         var month:int = readByte() - 1;
         var day:int = readByte();
         var hours:int = readByte();
         var minutes:int = readByte();
         var seconds:int = readByte();
         var date:Date = new Date(year,month,day,hours,minutes,seconds);
         return date;
      }
      
      public function readByteArray() : ByteArray
      {
         var temp:ByteArray = new ByteArray();
         readBytes(temp,0,_len - position);
         temp.position = 0;
         return temp;
      }
      
      public function deCompress() : void
      {
         position = 20;
         var temp:ByteArray = new ByteArray();
         readBytes(temp,0,_len - 20);
         temp.uncompress();
         position = 20;
         writeBytes(temp,0,temp.length);
         _len = 20 + temp.length;
         position = 20;
      }
      
      public function readLong() : Number
      {
         var value:Number = new Number();
         var H32:Number = new Number(readInt());
         var D32:Number = new Number(readUnsignedInt());
         var temp:int = 1;
         if(H32 < 0)
         {
            temp = -1;
         }
         value = temp * (Math.abs(H32 * Math.pow(2,32)) + D32);
         return value;
      }
   }
}
