package com.hurlant.math{   import com.hurlant.crypto.prng.Random;   import com.hurlant.util.Hex;   import com.hurlant.util.Memory;   import flash.utils.ByteArray;      use namespace bi_internal;      public class BigInteger   {            public static const ONE:BigInteger = nbv(1);            public static const ZERO:BigInteger = nbv(0);            public static const DM:int = DV - 1;            public static const F1:int = BI_FP - DB;            public static const F2:int = 2 * DB - BI_FP;            public static const lplim:int = (1 << 26) / lowprimes[lowprimes.length - 1];            public static const lowprimes:Array = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509];            public static const FV:Number = Math.pow(2,BI_FP);            public static const BI_FP:int = 52;            public static const DV:int = 1 << DB;            public static const DB:int = 30;                   bi_internal var a:Array;            bi_internal var s:int;            public var t:int;            public function BigInteger(value:* = null, radix:int = 0) { super(); }
            public static function nbv(value:int) : BigInteger { return null; }
            public function clearBit(n:int) : BigInteger { return null; }
            public function negate() : BigInteger { return null; }
            public function andNot(a:BigInteger) : BigInteger { return null; }
            public function modPow(e:BigInteger, m:BigInteger) : BigInteger { return null; }
            public function isProbablePrime(t:int) : Boolean { return false; }
            private function op_or(x:int, y:int) : int { return 0; }
            public function mod(v:BigInteger) : BigInteger { return null; }
            protected function addTo(a:BigInteger, r:BigInteger) : void { }
            protected function bitwiseTo(a:BigInteger, op:Function, r:BigInteger) : void { }
            protected function modInt(n:int) : int { return 0; }
            protected function chunkSize(r:Number) : int { return 0; }
            bi_internal function dAddOffset(n:int, w:int) : void { }
            bi_internal function lShiftTo(n:int, r:BigInteger) : void { }
            public function getLowestSetBit() : int { return 0; }
            public function subtract(a:BigInteger) : BigInteger { return null; }
            public function primify(bits:int, t:int) : void { }
            public function gcd(a:BigInteger) : BigInteger { return null; }
            bi_internal function multiplyLowerTo(a:BigInteger, n:int, r:BigInteger) : void { }
            public function modPowInt(e:int, m:BigInteger) : BigInteger { return null; }
            bi_internal function intAt(str:String, index:int) : int { return 0; }
            public function testBit(n:int) : Boolean { return false; }
            bi_internal function exp(e:int, z:IReduction) : BigInteger { return null; }
            public function toArray(array:ByteArray) : uint { return null; }
            public function dispose() : void { }
            private function lbit(x:int) : int { return 0; }
            bi_internal function divRemTo(m:BigInteger, q:BigInteger = null, r:BigInteger = null) : void { }
            public function remainder(a:BigInteger) : BigInteger { return null; }
            public function divide(a:BigInteger) : BigInteger { return null; }
            public function divideAndRemainder(a:BigInteger) : Array { return null; }
            public function valueOf() : Number { return 0; }
            public function shiftLeft(n:int) : BigInteger { return null; }
            public function multiply(a:BigInteger) : BigInteger { return null; }
            bi_internal function am(i:int, x:int, w:BigInteger, j:int, c:int, n:int) : int { return 0; }
            bi_internal function drShiftTo(n:int, r:BigInteger) : void { }
            public function add(a:BigInteger) : BigInteger { return null; }
            bi_internal function multiplyUpperTo(a:BigInteger, n:int, r:BigInteger) : void { }
            protected function nbi() : * { return null; }
            protected function millerRabin(t:int) : Boolean { return false; }
            bi_internal function dMultiply(n:int) : void { }
            private function op_andnot(x:int, y:int) : int { return 0; }
            bi_internal function clamp() : void { }
            bi_internal function invDigit() : int { return 0; }
            protected function changeBit(n:int, op:Function) : BigInteger { return null; }
            public function equals(a:BigInteger) : Boolean { return false; }
            public function compareTo(v:BigInteger) : int { return 0; }
            public function shiftRight(n:int) : BigInteger { return null; }
            bi_internal function multiplyTo(v:BigInteger, r:BigInteger) : void { }
            public function bitCount() : int { return 0; }
            public function byteValue() : int { return 0; }
            private function cbit(x:int) : int { return 0; }
            bi_internal function rShiftTo(n:int, r:BigInteger) : void { }
            public function modInverse(m:BigInteger) : BigInteger { return null; }
            bi_internal function fromArray(value:ByteArray, length:int) : void { }
            bi_internal function copyTo(r:BigInteger) : void { }
            public function intValue() : int { return 0; }
            public function min(a:BigInteger) : BigInteger { return null; }
            public function bitLength() : int { return 0; }
            public function shortValue() : int { return 0; }
            public function and(a:BigInteger) : BigInteger { return null; }
            protected function toRadix(b:uint = 10) : String { return null; }
            public function not() : BigInteger { return null; }
            bi_internal function subTo(v:BigInteger, r:BigInteger) : void { }
            public function clone() : BigInteger { return null; }
            public function pow(e:int) : BigInteger { return null; }
            public function flipBit(n:int) : BigInteger { return null; }
            public function xor(a:BigInteger) : BigInteger { return null; }
            public function or(a:BigInteger) : BigInteger { return null; }
            public function max(a:BigInteger) : BigInteger { return null; }
            bi_internal function fromInt(value:int) : void { }
            bi_internal function isEven() : Boolean { return false; }
            public function toString(radix:Number = 16) : String { return null; }
            public function setBit(n:int) : BigInteger { return null; }
            public function abs() : BigInteger { return null; }
            bi_internal function nbits(x:int) : int { return 0; }
            public function sigNum() : int { return 0; }
            public function toByteArray() : ByteArray { return null; }
            bi_internal function squareTo(r:BigInteger) : void { }
            private function op_and(x:int, y:int) : int { return 0; }
            protected function fromRadix(s:String, b:int = 10) : void { }
            bi_internal function dlShiftTo(n:int, r:BigInteger) : void { }
            private function op_xor(x:int, y:int) : int { return 0; }
   }}