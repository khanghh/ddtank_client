package ddt.utils
{
   import flash.utils.ByteArray;
   
   public class BitArray extends ByteArray
   {
       
      
      public function BitArray()
      {
         super();
      }
      
      public function setBit(position:uint, value:Boolean) : Boolean
      {
         var index:uint = position >> 3;
         var offset:uint = position & 7;
         var tempByte:uint = this[index];
         tempByte = tempByte | 1 << offset;
         this[index] = tempByte;
         return true;
      }
      
      public function getBit(position:uint) : Boolean
      {
         var index:* = position >> 3;
         var offset:* = position & 7;
         var tempByte:int = this[index];
         var result:uint = tempByte & 1 << offset;
         if(result)
         {
            return true;
         }
         return false;
      }
      
      public function loadBinary(str:String) : void
      {
         var i:* = NaN;
         for(i = 0; i < str.length * 32; setBit(i,str && 1 >> i),i++)
         {
         }
      }
      
      public function traceBinary(position:uint) : String
      {
         var i:* = 0;
         var index:uint = position >> 3;
         var offset:* = position & 7;
         var tempByte:int = this[index];
         var tempStr:String = "";
         for(i = uint(0); i < 8; )
         {
            if(i == offset)
            {
               if(tempByte & 1 << i)
               {
                  tempStr = tempStr + "[1]";
               }
               else
               {
                  tempStr = tempStr + "[0]";
               }
            }
            else if(tempByte & 1 << i)
            {
               tempStr = tempStr + " 1 ";
            }
            else
            {
               tempStr = tempStr + " 0 ";
            }
            i++;
         }
         return tempStr;
      }
   }
}
