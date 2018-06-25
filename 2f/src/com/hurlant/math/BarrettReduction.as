package com.hurlant.math{   use namespace bi_internal;      class BarrettReduction implements IReduction   {                   private var r2:BigInteger;            private var q3:BigInteger;            private var mu:BigInteger;            private var m:BigInteger;            function BarrettReduction(m:BigInteger) { super(); }
            public function reduce(lx:BigInteger) : void { }
            public function revert(x:BigInteger) : BigInteger { return null; }
            public function convert(x:BigInteger) : BigInteger { return null; }
            public function sqrTo(x:BigInteger, r:BigInteger) : void { }
            public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void { }
   }}