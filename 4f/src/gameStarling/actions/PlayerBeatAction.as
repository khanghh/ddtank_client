package gameStarling.actions{   import ddt.view.characterStarling.GameCharacter3D;   import gameCommon.actions.BaseAction;   import gameStarling.objects.GameLocalPlayer3D;   import gameStarling.objects.GamePlayer3D;      public class PlayerBeatAction extends BaseAction   {                   private var _player:GamePlayer3D;            private var _count:int;            public function PlayerBeatAction(player:GamePlayer3D) { super(); }
            override public function prepare() : void { }
            override public function execute() : void { }
   }}