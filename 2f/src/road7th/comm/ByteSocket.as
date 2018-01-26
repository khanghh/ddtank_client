package road7th.comm
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   
   [Event(name="connect",type="flash.events.Event")]
   [Event(name="close",type="flash.events.Event")]
   [Event(name="error",type="flash.events.ErrorEvent")]
   [Event(name="data",type="SocketEvent")]
   public class ByteSocket extends EventDispatcher
   {
      
      private static var KEY:Array = [174,191,86,120,171,205,239,241];
      
      public static var RECEIVE_KEY:ByteArray;
      
      public static var SEND_KEY:ByteArray;
       
      
      private var _debug:Boolean;
      
      private var _socket:Socket;
      
      private var _ip:String;
      
      private var _port:Number;
      
      private var _send_fsm:FSM;
      
      private var _receive_fsm:FSM;
      
      private var _encrypted:Boolean;
      
      private var _readBuffer:ByteArray;
      
      private var _readOffset:int;
      
      private var _writeOffset:int;
      
      private var _headerTemp:ByteArray;
      
      private var pkgNumber:int = 0;
      
      public function ByteSocket(param1:Boolean = true, param2:Boolean = false){super();}
      
      public function setKey(param1:Array) : void{}
      
      public function resetKey() : void{}
      
      public function setFsm(param1:int, param2:int) : void{}
      
      public function connect(param1:String, param2:Number) : void{}
      
      private function addEvent(param1:Socket) : void{}
      
      private function removeEvent(param1:Socket) : void{}
      
      public function get connected() : Boolean{return false;}
      
      public function isSame(param1:String, param2:int) : Boolean{return false;}
      
      public function send(param1:PackageOut) : void{}
      
      public function sendString(param1:String) : void{}
      
      public function close() : void{}
      
      private function handleConnect(param1:Event) : void{}
      
      private function handleClose(param1:Event) : void{}
      
      private function handleIoError(param1:ErrorEvent) : void{}
      
      private function handleIncoming(param1:ProgressEvent) : void{}
      
      private function readPackage() : void{}
      
      private function copyByteArray(param1:ByteArray) : ByteArray{return null;}
      
      public function decrptBytes(param1:ByteArray, param2:int, param3:ByteArray) : ByteArray{return null;}
      
      private function tracePkg(param1:ByteArray, param2:String, param3:int = -1) : void{}
      
      private function traceArr(param1:ByteArray) : void{}
      
      private function handlePackage(param1:PackageIn) : void{}
      
      public function dispose() : void{}
   }
}

class FSM
{
    
   
   private var _state:int;
   
   private var _adder:int;
   
   private var _multiper:int;
   
   function FSM(param1:int, param2:int){super();}
   
   public function getState() : int{return 0;}
   
   public function reset() : void{}
   
   public function setup(param1:int, param2:int) : void{}
   
   public function updateState() : int{return 0;}
}
