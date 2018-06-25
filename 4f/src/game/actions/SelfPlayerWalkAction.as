package game.actions{   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.view.character.GameCharacter;   import flash.geom.Point;   import flash.geom.Rectangle;   import game.objects.GameLocalPlayer;   import game.objects.SimpleObject;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;   import gameCommon.model.Player;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import phy.object.PhysicalObj;   import room.RoomManager;      public class SelfPlayerWalkAction extends BaseAction   {                   private var _player:GameLocalPlayer;            private var _end:Point;            private var _count:int;            private var _currentReverse:int;            private var _transmissionGate:Boolean = true;            public function SelfPlayerWalkAction(player:GameLocalPlayer, $reverse:int = 1) { super(); }
            override public function connect(action:BaseAction) : Boolean { return false; }
            private function isDirkeyDown() : Boolean { return false; }
            override public function prepare() : void { }
            override public function execute() : void { }
            private function transmissionGate() : void { }
            private function sendAction() : void { }
            private function finish() : void { }
   }}