package com.hurlant.math
{
   import com.hurlant.crypto.prng.Random;
   import com.hurlant.util.Hex;
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   use namespace bi_internal;
   
   public class BigInteger
   {
      
      public static const ONE:BigInteger = nbv(1);
      
      public static const ZERO:BigInteger = nbv(0);
      
      public static const DM:int = DV - 1;
      
      public static const F1:int = BI_FP - DB;
      
      public static const F2:int = 2 * DB - BI_FP;
      
      public static const lplim:int = (1 << 26) / lowprimes[lowprimes.length - 1];
      
      public static const lowprimes:Array = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509];
      
      public static const FV:Number = Math.pow(2,BI_FP);
      
      public static const BI_FP:int = 52;
      
      public static const DV:int = 1 << DB;
      
      public static const DB:int = 30;
       
      
      bi_internal var a:Array;
      
      bi_internal var s:int;
      
      public var t:int;
      
      public function BigInteger(param1:* = null, param2:int = 0){super();}
      
      public static function nbv(param1:int) : BigInteger{return null;}
      
      public function clearBit(param1:int) : BigInteger{return null;}
      
      public function negate() : BigInteger{return null;}
      
      public function andNot(param1:BigInteger) : BigInteger{return null;}
      
      public function modPow(param1:BigInteger, param2:BigInteger) : BigInteger{return null;}
      
      public function isProbablePrime(param1:int) : Boolean{return false;}
      
      private function op_or(param1:int, param2:int) : int{return 0;}
      
      public function mod(param1:BigInteger) : BigInteger{return null;}
      
      protected function addTo(param1:BigInteger, param2:BigInteger) : void{}
      
      protected function bitwiseTo(param1:BigInteger, param2:Function, param3:BigInteger) : void{}
      
      protected function modInt(param1:int) : int{return 0;}
      
      protected function chunkSize(param1:Number) : int{return 0;}
      
      bi_internal function dAddOffset(param1:int, param2:int) : void{}
      
      bi_internal function lShiftTo(param1:int, param2:BigInteger) : void{}
      
      public function getLowestSetBit() : int{return 0;}
      
      public function subtract(param1:BigInteger) : BigInteger{return null;}
      
      public function primify(param1:int, param2:int) : void{}
      
      public function gcd(param1:BigInteger) : BigInteger{return null;}
      
      bi_internal function multiplyLowerTo(param1:BigInteger, param2:int, param3:BigInteger) : void{}
      
      public function modPowInt(param1:int, param2:BigInteger) : BigInteger{return null;}
      
      bi_internal function intAt(param1:String, param2:int) : int{return 0;}
      
      public function testBit(param1:int) : Boolean{return false;}
      
      bi_internal function exp(param1:int, param2:IReduction) : BigInteger{return null;}
      
      public function toArray(param1:ByteArray) : uint{return null;}
      
      public function dispose() : void{}
      
      private function lbit(param1:int) : int{return 0;}
      
      bi_internal function divRemTo(param1:BigInteger, param2:BigInteger = null, param3:BigInteger = null) : void{}
      
      public function remainder(param1:BigInteger) : BigInteger{return null;}
      
      public function divide(param1:BigInteger) : BigInteger{return null;}
      
      public function divideAndRemainder(param1:BigInteger) : Array{return null;}
      
      public function valueOf() : Number{return 0;}
      
      public function shiftLeft(param1:int) : BigInteger{return null;}
      
      public function multiply(param1:BigInteger) : BigInteger{return null;}
      
      bi_internal function am(param1:int, param2:int, param3:BigInteger, param4:int, param5:int, param6:int) : int{return 0;}
      
      bi_internal function drShiftTo(param1:int, param2:BigInteger) : void{}
      
      public function add(param1:BigInteger) : BigInteger{return null;}
      
      bi_internal function multiplyUpperTo(param1:BigInteger, param2:int, param3:BigInteger) : void{}
      
      protected function nbi() : *{return null;}
      
      protected function millerRabin(param1:int) : Boolean{return false;}
      
      bi_internal function dMultiply(param1:int) : void{}
      
      private function op_andnot(param1:int, param2:int) : int{return 0;}
      
      bi_internal function clamp() : void{}
      
      bi_internal function invDigit() : int{return 0;}
      
      protected function changeBit(param1:int, param2:Function) : BigInteger{return null;}
      
      public function equals(param1:BigInteger) : Boolean{return false;}
      
      public function compareTo(param1:BigInteger) : int{return 0;}
      
      public function shiftRight(param1:int) : BigInteger{return null;}
      
      bi_internal function multiplyTo(param1:BigInteger, param2:BigInteger) : void{}
      
      public function bitCount() : int{return 0;}
      
      public function byteValue() : int{return 0;}
      
      private function cbit(param1:int) : int{return 0;}
      
      bi_internal function rShiftTo(param1:int, param2:BigInteger) : void{}
      
      public function modInverse(param1:BigInteger) : BigInteger{return null;}
      
      bi_internal function fromArray(param1:ByteArray, param2:int) : void{}
      
      bi_internal function copyTo(param1:BigInteger) : void{}
      
      public function intValue() : int{return 0;}
      
      public function min(param1:BigInteger) : BigInteger{return null;}
      
      public function bitLength() : int{return 0;}
      
      public function shortValue() : int{return 0;}
      
      public function and(param1:BigInteger) : BigInteger{return null;}
      
      protected function toRadix(param1:uint = 10) : String{return null;}
      
      public function not() : BigInteger{return null;}
      
      bi_internal function subTo(param1:BigInteger, param2:BigInteger) : void{}
      
      public function clone() : BigInteger{return null;}
      
      public function pow(param1:int) : BigInteger{return null;}
      
      public function flipBit(param1:int) : BigInteger{return null;}
      
      public function xor(param1:BigInteger) : BigInteger{return null;}
      
      public function or(param1:BigInteger) : BigInteger{return null;}
      
      public function max(param1:BigInteger) : BigInteger{return null;}
      
      bi_internal function fromInt(param1:int) : void{}
      
      bi_internal function isEven() : Boolean{return false;}
      
      public function toString(param1:Number = 16) : String{return null;}
      
      public function setBit(param1:int) : BigInteger{return null;}
      
      public function abs() : BigInteger{return null;}
      
      bi_internal function nbits(param1:int) : int{return 0;}
      
      public function sigNum() : int{return 0;}
      
      public function toByteArray() : ByteArray{return null;}
      
      bi_internal function squareTo(param1:BigInteger) : void{}
      
      private function op_and(param1:int, param2:int) : int{return 0;}
      
      protected function fromRadix(param1:String, param2:int = 10) : void{}
      
      bi_internal function dlShiftTo(param1:int, param2:BigInteger) : void{}
      
      private function op_xor(param1:int, param2:int) : int{return 0;}
   }
}
