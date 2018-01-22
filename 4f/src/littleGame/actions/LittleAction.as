package littleGame.actions
{
   import ddt.ddt_internal;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   import road7th.comm.PackageIn;
   
   public class LittleAction
   {
       
      
      protected var _isFinished:Boolean = false;
      
      protected var _isPrepare:Boolean = false;
      
      protected var _type:String;
      
      protected var _living:LittleLiving;
      
      public function LittleAction(){super();}
      
      ddt_internal function initializeLiving(param1:LittleLiving) : void{}
      
      public function parsePackege(param1:Scenario, param2:PackageIn = null) : void{}
      
      public function connect(param1:LittleAction) : Boolean{return false;}
      
      public function canReplace(param1:LittleAction) : Boolean{return false;}
      
      public function get isFinished() : Boolean{return false;}
      
      public function prepare() : void{}
      
      public function execute() : void{}
      
      protected function finish() : void{}
      
      public function cancel() : void{}
   }
}
