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
      
      public function BaseFightLibCommand()
      {
         super();
         _dispather = new EventDispatcher();
         _excuteFunArr = [];
         _completeFunArr = [];
         _undoFunArr = [];
      }
      
      public function set completeFunArr(param1:Array) : void
      {
         _completeFunArr = param1;
      }
      
      public function get completeFunArr() : Array
      {
         return _completeFunArr;
      }
      
      public function get prepareFun() : Function
      {
         return _prepareFun;
      }
      
      public function set prepareFun(param1:Function) : void
      {
         _prepareFun = param1;
      }
      
      public function excute() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _excuteFunArr;
         for each(var _loc1_ in _excuteFunArr)
         {
            _loc1_();
         }
      }
      
      public function finish() : void
      {
         if(_completeFunArr == null)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _completeFunArr;
         for each(var _loc1_ in _completeFunArr)
         {
            _loc1_();
         }
         dispatchEvent(new FightLibCommandEvent("finish"));
      }
      
      public function undo() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _undoFunArr;
         for each(var _loc1_ in _undoFunArr)
         {
            _loc1_();
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispather.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispather.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return _dispather.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _dispather.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return _dispather.willTrigger(param1);
      }
      
      public function get undoFunArr() : Array
      {
         return _undoFunArr;
      }
      
      public function set undoFunArr(param1:Array) : void
      {
         _undoFunArr = param1;
      }
      
      public function dispose() : void
      {
         _dispather = null;
         _excuteFunArr = null;
         _completeFunArr = null;
         _prepareFun = null;
         _undoFunArr = null;
      }
      
      public function get excuteFunArr() : Array
      {
         return _excuteFunArr;
      }
      
      public function set excuteFunArr(param1:Array) : void
      {
         _excuteFunArr = param1;
      }
   }
}
