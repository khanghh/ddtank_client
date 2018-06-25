package dragonBones.utils
{
   public final class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function getEaseValue(value:Number, easing:Number) : Number
      {
         var valueEase:* = 1;
         if(easing > 1)
         {
            valueEase = Number(0.5 * (1 - Math.cos(value * 3.14159265358979)));
            easing = easing - 1;
         }
         else if(easing > 0)
         {
            valueEase = Number(1 - Math.pow(1 - value,2));
         }
         else if(easing < 0)
         {
            easing = easing * -1;
            valueEase = Number(Math.pow(value,2));
         }
         return (valueEase - value) * easing + value;
      }
   }
}
