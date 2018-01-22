package dragonBones.utils
{
   public final class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function getEaseValue(param1:Number, param2:Number) : Number
      {
         var _loc3_:* = 1;
         if(param2 > 1)
         {
            _loc3_ = Number(0.5 * (1 - Math.cos(param1 * 3.14159265358979)));
            param2 = param2 - 1;
         }
         else if(param2 > 0)
         {
            _loc3_ = Number(1 - Math.pow(1 - param1,2));
         }
         else if(param2 < 0)
         {
            param2 = param2 * -1;
            _loc3_ = Number(Math.pow(param1,2));
         }
         return (_loc3_ - param1) * param2 + param1;
      }
   }
}
