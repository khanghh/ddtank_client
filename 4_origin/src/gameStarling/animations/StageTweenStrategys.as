package gameStarling.animations
{
   public class StageTweenStrategys
   {
       
      
      public function StageTweenStrategys()
      {
         super();
      }
      
      public static function getTweenClassNameByShortName(param1:String) : String
      {
         StrDefaultTween;
         StrLinearTween;
         StrHighSpeedLinearTween;
         StrDirectlyTween;
         StrShockingLinearTween;
         StrStayTween;
         var _loc2_:* = param1;
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
                           return "gameStarling.animations.StrDefaultTween";
                        }
                        return "gameStarling.animations.StrStayTween";
                     }
                     return "gameStarling.animations.StrShockingLinearTween";
                  }
                  return "gameStarling.animations.StrHighSpeedLinearTween";
               }
               return "gameStarling.animations.StrLinearTween";
            }
            return "gameStarling.animations.StrDirectlyTween";
         }
         return "gameStarling.animations.StrDefaultTween";
      }
   }
}
