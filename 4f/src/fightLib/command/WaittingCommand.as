package fightLib.command{   import fightLib.FightLibCommandEvent;      public class WaittingCommand extends BaseFightLibCommand   {                   protected var _finishFun:Function;            public function WaittingCommand(finishFun:Function) { super(); }
            override public function finish() : void { }
            override public function excute() : void { }
            override public function dispose() : void { }
   }}