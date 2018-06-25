package com.hurlant.crypto.prng{   import com.hurlant.util.Memory;   import flash.system.Capabilities;   import flash.system.System;   import flash.text.Font;   import flash.utils.ByteArray;   import flash.utils.getTimer;      public class Random   {                   private var psize:int;            private var ready:Boolean = false;            private var seeded:Boolean = false;            private var state:IPRNG;            private var pool:ByteArray;            private var pptr:int;            public function Random(prng:Class = null) { super(); }
            public function seed(x:int = 0) : void { }
            public function toString() : String { return null; }
            public function dispose() : void { }
            public function autoSeed() : void { }
            public function nextByte() : int { return 0; }
            public function nextBytes(buffer:ByteArray, length:int) : void { }
   }}