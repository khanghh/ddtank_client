package com.hurlant.math
{
   use namespace bi_internal;
   
   public class NullReduction implements IReduction
   {
       
      
      public function NullReduction(){super();}
      
      public function reduce(param1:BigInteger) : void{}
      
      public function revert(param1:BigInteger) : BigInteger{return null;}
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void{}
      
      public function convert(param1:BigInteger) : BigInteger{return null;}
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void{}
   }
}
