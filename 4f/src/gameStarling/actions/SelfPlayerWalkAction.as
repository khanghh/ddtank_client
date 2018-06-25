package gameStarling.actions{   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.view.characterStarling.GameCharacter3D;   import flash.geom.Point;   import flash.geom.Rectangle;   import gameCommon.actions.BaseAction;   import gameCommon.model.Player;   import gameStarling.objects.GameLocalPlayer3D;   import gameStarling.objects.SimpleObject3D;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import room.RoomManager;      public class SelfPlayerWalkAction extends BaseAction   {                   private var _player:GameLocalPlayer3D;            private var _end:Point;            private var _count:int;            private var _currentReverse:int;            private var _transmissionGate:Boolean = true;            public function SelfPlayerWalkAction(player:GameLocalPlayer3D, $reverse:int = 1) { super(); }
            override public function connect(action:BaseAction) : Boolean { return false; }
            private function isDirkeyDown() : Boolean { return false; }
            override public function prepare() : void { }
            override public function execute() : void { }
            private function transmissionGate() : void { }
            private function sendAction() : void { }
            private function finish() : void { }
   }}