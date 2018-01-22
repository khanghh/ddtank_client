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
       
      
      public function LittleActionCreator(){super();}
      
      public static function CreatAction(param1:String, param2:PackageIn = null, ... rest) : LittleAction{return null;}
   }
}
