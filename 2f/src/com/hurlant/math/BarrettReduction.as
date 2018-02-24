package com.hurlant.math
{
   use namespace bi_internal;
   
   class BarrettReduction implements IReduction
   {
       
      
      private var r2:BigInteger;
      
      private var q3:BigInteger;
      
      private var mu:BigInteger;
      
      private var m:BigInteger;
      
      function BarrettReduction(param1:BigInteger){super();}
      
      public function reduce(param1:BigInteger) : void{}
      
      public function revert(param1:BigInteger) : BigInteger{return null;}
      
      public function convert(param1:BigInteger) : BigInteger{return null;}
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void{}
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void{}
   }
}
