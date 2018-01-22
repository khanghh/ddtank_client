package cmodule.decry
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class CRunner implements Debuggee
   {
       
      
      var timer:Timer;
      
      var forceSyncSystem:Boolean;
      
      var suspended:int = 0;
      
      var debugger:GDBMIDebugger;
      
      public function CRunner(param1:Boolean = false){super();}
      
      public function cancelDebug() : void{}
      
      public function get isRunning() : Boolean{return false;}
      
      public function createArgv(param1:Array) : Array{return null;}
      
      public function createEnv(param1:Object) : Array{return null;}
      
      public function startInit() : void{}
      
      private function startWork() : void{}
      
      public function work() : void{}
      
      public function startSystemBridge(param1:String, param2:int) : void{}
      
      public function rawAllocString(param1:String) : int{return 0;}
      
      public function rawAllocStringArray(param1:Array) : Array{return null;}
      
      public function resume() : void{}
      
      public function startSystem() : void{}
      
      public function rawAllocIntArray(param1:Array) : int{return 0;}
      
      public function startSystemLocal(param1:Boolean = false) : void{}
      
      public function suspend() : void{}
   }
}
