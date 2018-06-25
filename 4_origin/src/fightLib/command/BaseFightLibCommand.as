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
      
      public function set completeFunArr(value:Array) : void
      {
         _completeFunArr = value;
      }
      
      public function get completeFunArr() : Array
      {
         return _completeFunArr;
      }
      
      public function get prepareFun() : Function
      {
         return _prepareFun;
      }
      
      public function set prepareFun(value:Function) : void
      {
         _prepareFun = value;
      }
      
      public function excute() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _excuteFunArr;
         for each(var fun in _excuteFunArr)
         {
            fun();
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
         for each(var fun in _completeFunArr)
         {
            fun();
         }
         dispatchEvent(new FightLibCommandEvent("finish"));
      }
      
      public function undo() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _undoFunArr;
         for each(var fun in _undoFunArr)
         {
            fun();
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         _dispather.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispather.removeEventListener(type,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return _dispather.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return _dispather.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return _dispather.willTrigger(type);
      }
      
      public function get undoFunArr() : Array
      {
         return _undoFunArr;
      }
      
      public function set undoFunArr(value:Array) : void
      {
         _undoFunArr = value;
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
      
      public function set excuteFunArr(value:Array) : void
      {
         _excuteFunArr = value;
      }
   }
}
