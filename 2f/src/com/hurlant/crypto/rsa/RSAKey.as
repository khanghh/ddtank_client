package com.hurlant.crypto.rsa{   import com.hurlant.crypto.prng.Random;   import com.hurlant.math.BigInteger;   import com.hurlant.util.Memory;   import flash.utils.ByteArray;      public class RSAKey   {                   public var dmp1:BigInteger;            protected var canDecrypt:Boolean;            public var d:BigInteger;            public var e:int;            public var dmq1:BigInteger;            public var n:BigInteger;            public var p:BigInteger;            public var q:BigInteger;            protected var canEncrypt:Boolean;            public var coeff:BigInteger;            public function RSAKey(N:BigInteger, E:int, D:BigInteger = null, P:BigInteger = null, Q:BigInteger = null, DP:BigInteger = null, DQ:BigInteger = null, C:BigInteger = null) { super(); }
            protected static function bigRandom(bits:int, rnd:Random) : BigInteger { return null; }
            public static function parsePublicKey(N:String, E:String) : RSAKey { return null; }
            public static function generate(B:uint, E:String) : RSAKey { return null; }
            public static function parsePrivateKey(N:String, E:String, D:String, P:String = null, Q:String = null, DMP1:String = null, DMQ1:String = null, IQMP:String = null) : RSAKey { return null; }
            public function verify(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void { }
            public function dump() : String { return null; }
            protected function doPrivate2(x:BigInteger) : BigInteger { return null; }
            public function decrypt(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void { }
            private function _decrypt(op:Function, src:ByteArray, dst:ByteArray, length:uint, pad:Function, padType:int) : void { }
            protected function doPublic(x:BigInteger) : BigInteger { return null; }
            public function dispose() : void { }
            private function _encrypt(op:Function, src:ByteArray, dst:ByteArray, length:uint, pad:Function, padType:int) : void { }
            private function rawpad(src:ByteArray, end:int, n:uint) : ByteArray { return null; }
            public function encrypt(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void { }
            private function pkcs1pad(src:ByteArray, end:int, n:uint, type:uint = 2) : ByteArray { return null; }
            private function pkcs1unpad(src:BigInteger, n:uint, type:uint = 2) : ByteArray { return null; }
            public function getBlockSize() : uint { return null; }
            public function toString() : String { return null; }
            public function sign(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void { }
            protected function doPrivate(x:BigInteger) : BigInteger { return null; }
   }}