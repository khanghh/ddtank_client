package dice{   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import dice.controller.DiceController;   import road7th.comm.PackageIn;      public class DiceManager extends CoreManager   {            private static var _instance:DiceManager;                   private var _callBack:Function;            private var _isopen:Boolean = false;            private var _pkg:PackageIn;            public function DiceManager() { super(); }
            public static function get Instance() : DiceManager { return null; }
            public function setup(callBack:Function = null) : void { }
            public function get isopen() : Boolean { return false; }
            override protected function start() : void { }
            public function __showEnterIcon(event:CrazyTankSocketEvent) : void { }
            private function loaderDice() : void { }
            private function __hideEnterIcon(event:CrazyTankSocketEvent) : void { }
   }}