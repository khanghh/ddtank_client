package dice{   import ddt.manager.StateManager;   import dice.controller.DiceController;   import dice.event.DiceEvent;   import flash.events.EventDispatcher;      public class DiceControl extends EventDispatcher   {            private static var _instance:DiceControl;                   public function DiceControl() { super(); }
            public static function get instance() : DiceControl { return null; }
            public function setup() : void { }
            private function __showPetIslandHandler(e:DiceEvent) : void { }
   }}