package game.actions.pet{   import flash.geom.Point;   import game.objects.GamePet;   import game.objects.GamePlayer;   import gameCommon.actions.BaseAction;   import gameCommon.model.Living;   import gameCommon.model.Player;      public class PetBeatAction extends BaseAction   {                   private var _pet:GamePet;            private var _act:String;            private var _pt:Point;            private var _targets:Array;            private var _master:GamePlayer;            private var _updated:Boolean = false;            public function PetBeatAction(pet:GamePet, master:GamePlayer, act:String, pt:Point, targets:Array) { super(); }
            override public function prepare() : void { }
            private function updateHp() : void { }
            override public function cancel() : void { }
            private function finish() : void { }
            override public function executeAtOnce() : void { }
            override public function execute() : void { }
   }}