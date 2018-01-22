package cmodule.decry
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   
   public class CSystemBridge implements CSystem
   {
      
      static const TELL:int = 9;
      
      static const ACCESS:int = 3;
      
      static const EXIT:int = 10;
      
      static const FSIZE:int = 1;
      
      static const OPEN:int = 4;
      
      static const LSEEK:int = 8;
      
      static const PSIZE:int = 2;
      
      static const READ:int = 7;
      
      static const CLOSE:int = 5;
      
      static const SETUP:int = 11;
      
      static const WRITE:int = 6;
       
      
      private var curPackBuf:ByteArray;
      
      private var sock:Socket;
      
      private var requests:Object;
      
      private var sentPackId:int = 1;
      
      private var curPackLen:int;
      
      var argv:Array;
      
      private var handlers:Object;
      
      var env:Object;
      
      private var curPackId:int;
      
      public function CSystemBridge(param1:String, param2:int){super();}
      
      public function psize(param1:int) : int{return 0;}
      
      private function asyncReq(param1:Function, param2:Function) : *{return null;}
      
      public function setup(param1:Function) : void{}
      
      private function sockConnect(param1:Event) : void{}
      
      private function sockData(param1:ProgressEvent) : void{}
      
      public function read(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function exit(param1:int) : void{}
      
      private function sockError(param1:IOErrorEvent) : void{}
      
      public function tell(param1:int) : int{return 0;}
      
      public function ioctl(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function getargv() : Array{return null;}
      
      public function open(param1:int, param2:int, param3:int) : int{return 0;}
      
      private function handlePacket() : void{}
      
      public function getenv() : Object{return null;}
      
      public function write(param1:int, param2:int, param3:int) : int{return 0;}
      
      private function sendRequest(param1:ByteArray, param2:Function) : void{}
      
      public function lseek(param1:int, param2:int, param3:int) : int{return 0;}
      
      public function fsize(param1:int) : int{return 0;}
      
      public function access(param1:int, param2:int) : int{return 0;}
      
      public function close(param1:int) : int{return 0;}
   }
}
