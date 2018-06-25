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
      
      public static function CreatObject(type:String, pkg:PackageIn = null) : ILittleObject
      {
         var object:* = null;
         var _loc4_:* = type;
         if("normalbogu" !== _loc4_)
         {
            if("bigbogu" !== _loc4_)
            {
               if("bogugiveup" === _loc4_)
               {
                  object = new BoguGiveUp();
               }
            }
            else
            {
               object = new BigBoguInhaled();
            }
         }
         else
         {
            object = new NormalBoguInhaled();
         }
         return object;
      }
   }
}
