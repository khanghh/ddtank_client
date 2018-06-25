package littleGame.actions{   import littleGame.model.LittleLiving;      public class LittleLivingBornAction extends LittleAction   {                   private var _life:int;            private var _lifeTime:int;            public function LittleLivingBornAction(living:LittleLiving, life:int = 10) { super(); }
            override public function prepare() : void { }
            override public function execute() : void { }
            override protected function finish() : void { }
   }}