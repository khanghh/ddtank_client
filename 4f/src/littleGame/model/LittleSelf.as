package littleGame.model{   import ddt.data.player.SelfInfo;   import ddt.ddt_internal;   import littleGame.actions.LittleAction;   import littleGame.actions.LittleSelfMoveAction;   import littleGame.data.Node;   import littleGame.events.LittleLivingEvent;      use namespace ddt_internal;      [Event(name="inhaledChanged",type="littleGame.events.LittleLivingEvent")]   [Event(name="getscore",type="littleGame.events.LittleLivingEvent")]   [Event(name="collide",type="littleGame.events.LittleLivingEvent")]   public class LittleSelf extends LittlePlayer   {                   private var _inhaled:Boolean = false;            public function LittleSelf(self:SelfInfo, id:int, x:int, y:int, type:int) { super(null,null,null,null,null); }
            override public function stand() : void { }
            public function collideByNode(node:Node) : Boolean { return false; }
            override public function get isSelf() : Boolean { return false; }
            override public function toString() : String { return null; }
            public function getScore(score:int) : void { }
            public function get inhaled() : Boolean { return false; }
            public function set inhaled(value:Boolean) : void { }
   }}