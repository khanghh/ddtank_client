package com.hurlant.crypto.prng
{
   import com.hurlant.crypto.symmetric.IStreamCipher;
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class ARC4 implements IPRNG, IStreamCipher
   {
       
      
      private var S:ByteArray;
      
      private var i:int = 0;
      
      private var j:int = 0;
      
      private const psize:uint = 256;
      
      public function ARC4(param1:ByteArray = null){super();}
      
      public function decrypt(param1:ByteArray) : void{}
      
      public function init(param1:ByteArray) : void{}
      
      public function dispose() : void{}
      
      public function encrypt(param1:ByteArray) : void{}
      
      public function next() : uint{return null;}
      
      public function getBlockSize() : uint{return null;}
      
      public function getPoolSize() : uint{return null;}
      
      public function toString() : String{return null;}
   }
}
