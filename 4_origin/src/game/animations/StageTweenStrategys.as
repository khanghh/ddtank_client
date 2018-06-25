package game.animations
{
   public class StageTweenStrategys
   {
       
      
      public function StageTweenStrategys()
      {
         super();
      }
      
      public static function getTweenClassNameByShortName(shortName:String) : String
      {
         StrDefaultTween;
         StrLinearTween;
         StrHighSpeedLinearTween;
         StrDefaultTween;
         StrDirectlyTween;
         StrShockingLinearTween;
         StrStayTween;
         var _loc2_:* = shortName;
         if("default" !== _loc2_)
         {
            if("directly" !== _loc2_)
            {
               if("lowSpeedLinear" !== _loc2_)
               {
                  if("highSpeedLinear" !== _loc2_)
                  {
                     if("shockingLinear" !== _loc2_)
                     {
                        if("stay" !== _loc2_)
                        {
                           return "game.animations.StrDefaultTween";
                        }
                        return "game.animations.StrStayTween";
                     }
                     return "game.animations.StrShockingLinearTween";
                  }
                  return "game.animations.StrHighSpeedLinearTween";
               }
               return "game.animations.StrLinearTween";
            }
            return "game.animations.StrDirectlyTween";
         }
         return "game.animations.StrDefaultTween";
      }
   }
}
