package littleGame.actions
{
   import littleGame.LittleGameManager;
   import littleGame.model.LittlePlayer;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   import road7th.comm.PackageIn;
   
   public class InhaleAction extends LittleLivingMoveAction
   {
       
      
      private var _life:int = 0;
      
      private var _lifeTime:int = 0;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _dx:int;
      
      private var _dy:int;
      
      private var _endAction:String;
      
      private var _direction:String;
      
      private var _headType:int;
      
      public function InhaleAction(){super(null,null,null);}
      
      override public function parsePackege(param1:Scenario, param2:PackageIn = null) : void{}
      
      override public function prepare() : void{}
      
      public function toString() : String{return null;}
      
      override public function execute() : void{}
      
      override protected function finish() : void{}
      
      private function synchronous() : void{}
   }
}
