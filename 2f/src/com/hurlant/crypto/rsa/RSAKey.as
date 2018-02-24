package com.hurlant.crypto.rsa
{
   import com.hurlant.crypto.prng.Random;
   import com.hurlant.math.BigInteger;
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class RSAKey
   {
       
      
      public var dmp1:BigInteger;
      
      protected var canDecrypt:Boolean;
      
      public var d:BigInteger;
      
      public var e:int;
      
      public var dmq1:BigInteger;
      
      public var n:BigInteger;
      
      public var p:BigInteger;
      
      public var q:BigInteger;
      
      protected var canEncrypt:Boolean;
      
      public var coeff:BigInteger;
      
      public function RSAKey(param1:BigInteger, param2:int, param3:BigInteger = null, param4:BigInteger = null, param5:BigInteger = null, param6:BigInteger = null, param7:BigInteger = null, param8:BigInteger = null){super();}
      
      protected static function bigRandom(param1:int, param2:Random) : BigInteger{return null;}
      
      public static function parsePublicKey(param1:String, param2:String) : RSAKey{return null;}
      
      public static function generate(param1:uint, param2:String) : RSAKey{return null;}
      
      public static function parsePrivateKey(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null) : RSAKey{return null;}
      
      public function verify(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void{}
      
      public function dump() : String{return null;}
      
      protected function doPrivate2(param1:BigInteger) : BigInteger{return null;}
      
      public function decrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void{}
      
      private function _decrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void{}
      
      protected function doPublic(param1:BigInteger) : BigInteger{return null;}
      
      public function dispose() : void{}
      
      private function _encrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void{}
      
      private function rawpad(param1:ByteArray, param2:int, param3:uint) : ByteArray{return null;}
      
      public function encrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void{}
      
      private function pkcs1pad(param1:ByteArray, param2:int, param3:uint, param4:uint = 2) : ByteArray{return null;}
      
      private function pkcs1unpad(param1:BigInteger, param2:uint, param3:uint = 2) : ByteArray{return null;}
      
      public function getBlockSize() : uint{return null;}
      
      public function toString() : String{return null;}
      
      public function sign(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void{}
      
      protected function doPrivate(param1:BigInteger) : BigInteger{return null;}
   }
}
