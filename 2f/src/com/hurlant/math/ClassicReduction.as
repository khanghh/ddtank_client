package com.hurlant.math
{
   use namespace bi_internal;
   
   class ClassicReduction implements IReduction
   {
       
      
      private var m:BigInteger;
      
      function ClassicReduction(param1:BigInteger){super();}
      
      public function revert(param1:BigInteger) : BigInteger{return null;}
      
      public function reduce(param1:BigInteger) : void{}
      
      public function convert(param1:BigInteger) : BigInteger{return null;}
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void{}
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void{}
   }
}
