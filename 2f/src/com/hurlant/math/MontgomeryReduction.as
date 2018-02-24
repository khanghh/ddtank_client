package com.hurlant.math
{
   use namespace bi_internal;
   
   class MontgomeryReduction implements IReduction
   {
       
      
      private var um:int;
      
      private var mp:int;
      
      private var mph:int;
      
      private var mpl:int;
      
      private var mt2:int;
      
      private var m:BigInteger;
      
      function MontgomeryReduction(param1:BigInteger){super();}
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void{}
      
      public function revert(param1:BigInteger) : BigInteger{return null;}
      
      public function convert(param1:BigInteger) : BigInteger{return null;}
      
      public function reduce(param1:BigInteger) : void{}
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void{}
   }
}
