package com.hurlant.crypto.prng{   import com.hurlant.crypto.symmetric.IStreamCipher;   import com.hurlant.util.Memory;   import flash.utils.ByteArray;      public class ARC4 implements IPRNG, IStreamCipher   {                   private var S:ByteArray;            private var i:int = 0;            private var j:int = 0;            private const psize:uint = 256;            public function ARC4(key:ByteArray = null) { super(); }
            public function decrypt(block:ByteArray) : void { }
            public function init(key:ByteArray) : void { }
            public function dispose() : void { }
            public function encrypt(block:ByteArray) : void { }
            public function next() : uint { return null; }
            public function getBlockSize() : uint { return null; }
            public function getPoolSize() : uint { return null; }
            public function toString() : String { return null; }
   }}