package com.hurlant.math{   use namespace bi_internal;      class MontgomeryReduction implements IReduction   {                   private var um:int;            private var mp:int;            private var mph:int;            private var mpl:int;            private var mt2:int;            private var m:BigInteger;            function MontgomeryReduction(m:BigInteger) { super(); }
            public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void { }
            public function revert(x:BigInteger) : BigInteger { return null; }
            public function convert(x:BigInteger) : BigInteger { return null; }
            public function reduce(x:BigInteger) : void { }
            public function sqrTo(x:BigInteger, r:BigInteger) : void { }
   }}