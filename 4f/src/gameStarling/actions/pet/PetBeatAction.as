package gameStarling.actions.pet{   import flash.geom.Point;   import gameCommon.actions.BaseAction;   import gameCommon.model.Living;   import gameCommon.model.Player;   import gameStarling.objects.GamePet3D;   import gameStarling.objects.GamePlayer3D;      public class PetBeatAction extends BaseAction   {                   private var _pet:GamePet3D;            private var _act:String;            private var _pt:Point;            private var _targets:Array;            private var _master:GamePlayer3D;            private var _updated:Boolean = false;            public function PetBeatAction(pet:GamePet3D, master:GamePlayer3D, act:String, pt:Point, targets:Array) { super(); }
            override public function prepare() : void { }
            private function updateHp() : void { }
            override public function cancel() : void { }
            private function finish() : void { }
            override public function executeAtOnce() : void { }
            override public function execute() : void { }
   }}