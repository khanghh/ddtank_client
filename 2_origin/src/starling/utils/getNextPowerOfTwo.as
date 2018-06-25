package starling.utils
{
   public function getNextPowerOfTwo(number:Number) : int
   {
      var result:* = 0;
      if(number is int && number > 0 && (number & number - 1) == 0)
      {
         return number;
      }
      result = 1;
      number = number - 1.0e-9;
      while(result < number)
      {
         result = result << 1;
      }
      return result;
   }
}
