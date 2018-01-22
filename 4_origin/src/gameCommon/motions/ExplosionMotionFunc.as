package gameCommon.motions
{
   public class ExplosionMotionFunc extends BaseMotionFunc
   {
      
      private static var D:int = 10;
       
      
      public function ExplosionMotionFunc(param1:Object)
      {
         super(param1);
      }
      
      override public function getVectorByTime(param1:int) : Object
      {
         var _loc2_:* = param1 % 4;
         if(0 !== _loc2_)
         {
            if(1 !== _loc2_)
            {
               if(2 !== _loc2_)
               {
                  if(3 === _loc2_)
                  {
                     _result.x = Number(D);
                     _result.y = -D;
                  }
               }
               else
               {
                  _result.x = -D;
                  _result.y = Number(D);
               }
            }
            else
            {
               _result.x = Number(D);
               _result.y = Number(D);
            }
         }
         else
         {
            _result.x = -D;
            _result.y = -D;
         }
         return _result;
      }
   }
}
