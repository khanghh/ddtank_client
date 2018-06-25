package com.hurlant.math{   use namespace bi_internal;      public class NullReduction implements IReduction   {                   public function NullReduction() { super(); }
            public function reduce(x:BigInteger) : void { }
            public function revert(x:BigInteger) : BigInteger { return null; }
            public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void { }
            public function convert(x:BigInteger) : BigInteger { return null; }
            public function sqrTo(x:BigInteger, r:BigInteger) : void { }
   }}