package game.actions{   import flash.events.Event;   import game.objects.GamePlayer;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;      public class WeaponShootAction extends BaseAction   {                   private var _player:GamePlayer;            public function WeaponShootAction(player:GamePlayer) { super(); }
            override public function prepare() : void { }
            private function __onPlayComplete(e:Event) : void { }
            override public function execute() : void { }
   }}