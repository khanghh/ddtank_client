package littleGame.actions{   import littleGame.model.LittleLiving;   import littleGame.model.Scenario;   import road7th.comm.PackageIn;      public class LittleLivingDieAction extends LittleAction   {                   private var _lifeTime:int;            private var _life:int;            private var _scene:Scenario;            public function LittleLivingDieAction(scene:Scenario = null, living:LittleLiving = null, life:int = 6) { super(); }
            override public function connect(action:LittleAction) : Boolean { return false; }
            override public function parsePackege(scene:Scenario, pkg:PackageIn = null) : void { }
            override public function prepare() : void { }
            override public function execute() : void { }
   }}