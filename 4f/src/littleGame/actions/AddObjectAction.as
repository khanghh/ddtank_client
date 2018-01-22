package littleGame.actions
{
   import littleGame.LittleGameManager;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   import road7th.comm.PackageIn;
   
   public class AddObjectAction extends LittleAction
   {
       
      
      private var _scene:Scenario;
      
      private var _pkg:PackageIn;
      
      public function AddObjectAction(){super();}
      
      override public function parsePackege(param1:Scenario, param2:PackageIn = null) : void{}
      
      override public function execute() : void{}
   }
}
