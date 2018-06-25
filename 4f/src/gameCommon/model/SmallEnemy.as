package gameCommon.model{   import ddt.events.LivingEvent;      [Event(name="modelChanged",type="tank.events.LivingEvent")]   public class SmallEnemy extends Living   {                   public var stateType:int;            private var _modelID:int;            public function SmallEnemy(id:int, team:int, maxBlood:int) { super(null,null,null); }
            public function set modelID(value:int) : void { }
            public function get modelID() : int { return 0; }
            override public function dispose() : void { }
   }}