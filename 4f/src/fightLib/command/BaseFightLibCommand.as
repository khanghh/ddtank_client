package fightLib.command
{
   import fightLib.FightLibCommandEvent;
   import fightLib.IFightLibCommand;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class BaseFightLibCommand implements IFightLibCommand
   {
       
      
      protected var _dispather:EventDispatcher;
      
      private var _excuteFunArr:Array;
      
      protected var _completeFunArr:Array;
      
      protected var _prepareFun:Function;
      
      protected var _undoFunArr:Array;
      
      public function BaseFightLibCommand(){super();}
      
      public function set completeFunArr(param1:Array) : void{}
      
      public function get completeFunArr() : Array{return null;}
      
      public function get prepareFun() : Function{return null;}
      
      public function set prepareFun(param1:Function) : void{}
      
      public function excute() : void{}
      
      public function finish() : void{}
      
      public function undo() : void{}
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void{}
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void{}
      
      public function dispatchEvent(param1:Event) : Boolean{return false;}
      
      public function hasEventListener(param1:String) : Boolean{return false;}
      
      public function willTrigger(param1:String) : Boolean{return false;}
      
      public function get undoFunArr() : Array{return null;}
      
      public function set undoFunArr(param1:Array) : void{}
      
      public function dispose() : void{}
      
      public function get excuteFunArr() : Array{return null;}
      
      public function set excuteFunArr(param1:Array) : void{}
   }
}
