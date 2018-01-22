package littleGame
{
   import littleGame.actions.AddObjectAction;
   import littleGame.actions.InhaleAction;
   import littleGame.actions.LittleAction;
   import littleGame.actions.LittleLivingDieAction;
   import littleGame.actions.RemoveObjectAction;
   import littleGame.actions.UnInhaleAction;
   import road7th.comm.PackageIn;
   
   public class LittleActionCreator
   {
       
      
      public function LittleActionCreator()
      {
         super();
      }
      
      public static function CreatAction(param1:String, param2:PackageIn = null, ... rest) : LittleAction
      {
         var _loc4_:* = null;
         var _loc5_:* = param1;
         if("livingInhale" !== _loc5_)
         {
            if("addObject" !== _loc5_)
            {
               if("removeObject" !== _loc5_)
               {
                  if("livingUnInhale" !== _loc5_)
                  {
                     if("livingDie" === _loc5_)
                     {
                        _loc4_ = new LittleLivingDieAction();
                     }
                  }
                  else
                  {
                     _loc4_ = new UnInhaleAction();
                  }
               }
               else
               {
                  _loc4_ = new RemoveObjectAction();
               }
            }
            else
            {
               _loc4_ = new AddObjectAction();
            }
         }
         else
         {
            _loc4_ = new InhaleAction();
         }
         return _loc4_;
      }
   }
}
