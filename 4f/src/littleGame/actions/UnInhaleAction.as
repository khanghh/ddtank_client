package littleGame.actions
{
   import littleGame.model.Scenario;
   import road7th.comm.PackageIn;
   
   public class UnInhaleAction extends LittleAction
   {
       
      
      private var _scene:Scenario;
      
      private var _endAction:String;
      
      private var _direction:String;
      
      public function UnInhaleAction(){super();}
      
      override public function prepare() : void{}
      
      override public function parsePackege(param1:Scenario, param2:PackageIn = null) : void{}
      
      override public function execute() : void{}
      
      public function toString() : String{return null;}
   }
}
