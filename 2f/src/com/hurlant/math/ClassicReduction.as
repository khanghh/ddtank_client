package com.hurlant.math{   use namespace bi_internal;      class ClassicReduction implements IReduction   {                   private var m:BigInteger;            function ClassicReduction(m:BigInteger) { super(); }
            public function revert(x:BigInteger) : BigInteger { return null; }
            public function reduce(x:BigInteger) : void { }
            public function convert(x:BigInteger) : BigInteger { return null; }
            public function sqrTo(x:BigInteger, r:BigInteger) : void { }
            public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void { }
   }}