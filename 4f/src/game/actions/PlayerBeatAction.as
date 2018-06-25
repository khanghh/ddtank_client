package game.actions{   import ddt.view.character.GameCharacter;   import game.objects.GameLocalPlayer;   import game.objects.GamePlayer;   import gameCommon.actions.BaseAction;      public class PlayerBeatAction extends BaseAction   {                   private var _player:GamePlayer;            private var _count:int;            public function PlayerBeatAction(player:GamePlayer) { super(); }
            override public function prepare() : void { }
            override public function execute() : void { }
   }}