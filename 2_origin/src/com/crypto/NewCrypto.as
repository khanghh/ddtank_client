package com.crypto
{
   import flash.utils.ByteArray;
   
   public class NewCrypto
   {
      
      private static const _FLAG:String = "^_^";
      
      private static const _SKIP_INDEX:int = 16;
       
      
      public function NewCrypto()
      {
         super();
      }
      
      public static function decry(src:ByteArray) : ByteArray
      {
         if(!isEncryed(src))
         {
            return src;
         }
         var originPos:int = src.position;
         src.position = 0;
         src.readUTF();
         var headBytes:ByteArray = new ByteArray();
         src.readBytes(headBytes,0,16);
         var ciphertext:int = src.readByte();
         ciphertext = ~ciphertext;
         var lastBytes:ByteArray = new ByteArray();
         src.readBytes(lastBytes,0,lastBytes.bytesAvailable);
         var bytes:ByteArray = new ByteArray();
         bytes.writeBytes(headBytes);
         bytes.writeByte(ciphertext);
         bytes.writeBytes(lastBytes);
         src.position = originPos;
         headBytes.clear();
         lastBytes.clear();
         return bytes;
      }
      
      public static function isEncryed(src:ByteArray) : Boolean
      {
         var flag:* = null;
         var originPos:int = src.position;
         var isEncry:Boolean = false;
         src.position = 0;
         try
         {
            flag = src.readUTF();
         }
         catch(e:Error)
         {
         }
         if(flag == "^_^")
         {
            isEncry = true;
         }
         src.position = originPos;
         return isEncry;
      }
   }
}
