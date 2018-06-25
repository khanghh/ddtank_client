package gameCommon.model{   import ddt.events.LivingEvent;   import flash.utils.Dictionary;      [Event(name="attackingChanged",type="ddt.events.LivingEvent")]   public class TurnedLiving extends Living   {                   protected var _isAttacking:Boolean = false;            private var _fightBuffs:Dictionary;            public function TurnedLiving(id:int, team:int, maxBlood:int, templeId:int = 0) { super(null,null,null,null); }
            public function get isAttacking() : Boolean { return false; }
            public function set isAttacking(value:Boolean) : void { }
            override public function beginNewTurn() : void { }
            override public function die(widthAction:Boolean = true) : void { }
            public function hasState(stateId:int) : Boolean { return false; }
            public function addState(stateId:int, pic:String = "") : void { }
            public function startAttacking() : void { }
            public function stopAttacking() : void { }
            override public function dispose() : void { }
   }}