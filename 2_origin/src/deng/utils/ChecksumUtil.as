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
         var i:* = 0;
         var j:* = 0;
         var c:* = 0;
         var table:Array = [];
         for(i = uint(0); i < 256; )
         {
            c = i;
            for(j = uint(0); j < 8; )
            {
               if(c & 1)
               {
                  c = uint(3988292384 ^ c >>> 1);
               }
               else
               {
                  c = uint(c >>> 1);
               }
               j++;
            }
            table.push(c);
            i++;
         }
         return table;
      }
      
      public static function CRC32(data:ByteArray, start:uint = 0, len:uint = 0) : uint
      {
         var i:* = 0;
         if(start >= data.length)
         {
            start = data.length;
         }
         if(len == 0)
         {
            len = data.length - start;
         }
         if(len + start > data.length)
         {
            len = data.length - start;
         }
         var c:* = 4294967295;
         for(i = start; i < len; )
         {
            c = uint(uint(crcTable[(c ^ data[i]) & 255]) ^ c >>> 8);
            i++;
         }
         return c ^ 4294967295;
      }
      
      public static function Adler32(data:ByteArray, start:uint = 0, len:uint = 0) : uint
      {
         if(start >= data.length)
         {
            start = data.length;
         }
         if(len == 0)
         {
            len = data.length - start;
         }
         if(len + start > data.length)
         {
            len = data.length - start;
         }
         var i:* = start;
         var a:uint = 1;
         var b:uint = 0;
         while(i < start + len)
         {
            a = (a + data[i]) % 65521;
            b = (a + b) % 65521;
            i++;
         }
         return b << 16 | a;
      }
   }
}
