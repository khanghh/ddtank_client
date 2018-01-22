package littleGame
{
   import littleGame.interfaces.ILittleObject;
   import littleGame.object.BigBoguInhaled;
   import littleGame.object.BoguGiveUp;
   import littleGame.object.NormalBoguInhaled;
   import road7th.comm.PackageIn;
   
   public class ObjectCreator
   {
       
      
      public function ObjectCreator()
      {
         super();
      }
      
      public static function CreatObject(param1:String, param2:PackageIn = null) : ILittleObject
      {
         var _loc3_:* = null;
         var _loc4_:* = param1;
         if("normalbogu" !== _loc4_)
         {
            if("bigbogu" !== _loc4_)
            {
               if("bogugiveup" === _loc4_)
               {
                  _loc3_ = new BoguGiveUp();
               }
            }
            else
            {
               _loc3_ = new BigBoguInhaled();
            }
         }
         else
         {
            _loc3_ = new NormalBoguInhaled();
         }
         return _loc3_;
      }
   }
}
