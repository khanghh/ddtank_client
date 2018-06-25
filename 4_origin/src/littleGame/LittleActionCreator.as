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
      
      public static function CreatAction(type:String, pkg:PackageIn = null, ... arg) : LittleAction
      {
         var action:* = null;
         var _loc5_:* = type;
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
                        action = new LittleLivingDieAction();
                     }
                  }
                  else
                  {
                     action = new UnInhaleAction();
                  }
               }
               else
               {
                  action = new RemoveObjectAction();
               }
            }
            else
            {
               action = new AddObjectAction();
            }
         }
         else
         {
            action = new InhaleAction();
         }
         return action;
      }
   }
}
