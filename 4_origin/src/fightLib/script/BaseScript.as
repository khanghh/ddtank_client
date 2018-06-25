package fightLib.script
{
   import fightLib.IFightLibCommand;
   import fightLib.command.BaseFightLibCommand;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class BaseScript extends EventDispatcher
   {
       
      
      protected var _type:int;
      
      protected var _commonds:Array;
      
      protected var _index:int;
      
      protected var _initialized:Boolean;
      
      protected var _isPaused:Boolean;
      
      protected var _currentCommand:IFightLibCommand;
      
      protected var _host:Object;
      
      private var _hasRestarted:Boolean;
      
      public function BaseScript(host:Object)
      {
         super();
         _host = host;
         _initialized = false;
         _commonds = [];
         initializeScript();
      }
      
      protected function initializeScript() : void
      {
         _initialized = true;
      }
      
      public function start() : void
      {
         if(_initialized)
         {
            initEvents();
            _index = 0;
            next();
            return;
         }
         throw new Error("在脚本初始化前调用脚本");
      }
      
      public function restart() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _commonds;
         for each(var command in _commonds)
         {
            command.undo();
         }
         removeEvents();
         _isPaused = false;
         _currentCommand = null;
         start();
         _hasRestarted = true;
      }
      
      public function next() : void
      {
         if(_index < _commonds.length)
         {
            _index = Number(_index) + 1;
            _commonds[Number(_index)].excute();
         }
         else
         {
            finish();
         }
      }
      
      private function initEvents() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _commonds;
         for each(var command in _commonds)
         {
            command.addEventListener("finish",__finishHandler);
            command.addEventListener("wait",__waitHandler);
         }
      }
      
      private function removeEvents() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _commonds;
         for each(var command in _commonds)
         {
            command.removeEventListener("complete",__finishHandler);
            command.removeEventListener("deactivate",__waitHandler);
         }
      }
      
      protected function __finishHandler(evt:Event) : void
      {
         if(!_isPaused)
         {
            next();
         }
      }
      
      protected function __waitHandler(evt:Event) : void
      {
         pause();
      }
      
      public function finish() : void
      {
         _index = 0;
         removeEvents();
         dispatchEvent(new Event("complete"));
      }
      
      public function pause() : void
      {
         _isPaused = true;
         _currentCommand = _commonds[_index - 1];
      }
      
      public function continueScript() : void
      {
         _isPaused = false;
         if(_currentCommand)
         {
            _currentCommand.finish();
         }
      }
      
      public function get hasRestarted() : Boolean
      {
         return _hasRestarted;
      }
      
      public function dispose() : void
      {
         _host = null;
         var _loc3_:int = 0;
         var _loc2_:* = _commonds;
         for each(var command in _commonds)
         {
            command.dispose();
         }
         _commonds = null;
         _currentCommand = null;
      }
   }
}
