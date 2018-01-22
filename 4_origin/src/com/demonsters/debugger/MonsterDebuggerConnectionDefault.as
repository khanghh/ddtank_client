package com.demonsters.debugger
{
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   class MonsterDebuggerConnectionDefault implements IMonsterDebuggerConnection
   {
       
      
      private const MAX_QUEUE_LENGTH:int = 500;
      
      private var _socket:Socket;
      
      private var _connecting:Boolean;
      
      private var _process:Boolean;
      
      private var _bytes:ByteArray;
      
      private var _package:ByteArray;
      
      private var _length:uint;
      
      private var _retry:Timer;
      
      private var _timeout:Timer;
      
      private var _address:String;
      
      private var _port:int;
      
      private var _queue:Array;
      
      function MonsterDebuggerConnectionDefault()
      {
         _queue = [];
         super();
         _socket = new Socket();
         _socket.addEventListener("connect",connectHandler,false,0,false);
         _socket.addEventListener("close",closeHandler,false,0,false);
         _socket.addEventListener("ioError",closeHandler,false,0,false);
         _socket.addEventListener("securityError",closeHandler,false,0,false);
         _socket.addEventListener("socketData",dataHandler,false,0,false);
         _connecting = false;
         _process = false;
         _address = "127.0.0.1";
         _port = 5840;
         _timeout = new Timer(2000,1);
         _timeout.addEventListener("timer",closeHandler,false,0,false);
         _retry = new Timer(1000,1);
         _retry.addEventListener("timer",retryHandler,false,0,false);
      }
      
      public function set address(param1:String) : void
      {
         _address = param1;
      }
      
      public function get connected() : Boolean
      {
         if(_socket == null)
         {
            return false;
         }
         return _socket.connected;
      }
      
      public function processQueue() : void
      {
         if(!_process)
         {
            _process = true;
            if(_queue.length > 0)
            {
               next();
            }
         }
      }
      
      public function send(param1:String, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         if(param3 && param1 == "com.demonsters.debugger.core" && _socket.connected)
         {
            _loc4_ = new MonsterDebuggerData(param1,param2).bytes;
            _socket.writeUnsignedInt(_loc4_.length);
            _socket.writeBytes(_loc4_);
            _socket.flush();
            return;
         }
         _queue.push(new MonsterDebuggerData(param1,param2));
         if(_queue.length > 500)
         {
            _queue.shift();
         }
         if(_queue.length > 0)
         {
            next();
         }
      }
      
      public function connect() : void
      {
         if(!_connecting && MonsterDebugger.enabled)
         {
            try
            {
               Security.loadPolicyFile("xmlsocket://" + _address + ":" + _port);
               _connecting = true;
               _socket.connect(_address,_port);
               _retry.stop();
               _timeout.reset();
               _timeout.start();
               return;
            }
            catch(e:Error)
            {
               closeHandler();
               return;
            }
         }
      }
      
      private function next() : void
      {
         if(!MonsterDebugger.enabled)
         {
            return;
         }
         if(!_process)
         {
            return;
         }
         if(!_socket.connected)
         {
            connect();
            return;
         }
         var _loc1_:ByteArray = MonsterDebuggerData(_queue.shift()).bytes;
         _socket.writeUnsignedInt(_loc1_.length);
         _socket.writeBytes(_loc1_);
         _socket.flush();
         _loc1_ = null;
         if(_queue.length > 0)
         {
            next();
         }
      }
      
      private function connectHandler(param1:Event) : void
      {
         _timeout.stop();
         _retry.stop();
         _connecting = false;
         _bytes = new ByteArray();
         _package = new ByteArray();
         _length = 0;
         _socket.writeUTFBytes("<hello/>\n");
         _socket.writeByte(0);
         _socket.flush();
      }
      
      private function retryHandler(param1:TimerEvent) : void
      {
         _retry.stop();
         connect();
      }
      
      private function closeHandler(param1:Event = null) : void
      {
         MonsterDebuggerUtils.resume();
         if(!_retry.running)
         {
            _connecting = false;
            _process = false;
            _timeout.stop();
            _retry.reset();
            _retry.start();
         }
      }
      
      private function dataHandler(param1:ProgressEvent) : void
      {
         _bytes = new ByteArray();
         _socket.readBytes(_bytes,0,_socket.bytesAvailable);
         _bytes.position = 0;
         processPackage();
      }
      
      private function processPackage() : void
      {
         var _loc2_:* = 0;
         var _loc1_:* = null;
         if(_bytes.bytesAvailable == 0)
         {
            return;
         }
         if(_length == 0)
         {
            _length = _bytes.readUnsignedInt();
            _package = new ByteArray();
         }
         if(_package.length < _length && _bytes.bytesAvailable > 0)
         {
            _loc2_ = uint(_bytes.bytesAvailable);
            if(_loc2_ > _length - _package.length)
            {
               _loc2_ = uint(_length - _package.length);
            }
            _bytes.readBytes(_package,_package.length,_loc2_);
         }
         if(_length != 0 && _package.length == _length)
         {
            _loc1_ = MonsterDebuggerData.read(_package);
            if(_loc1_.id != null)
            {
               MonsterDebuggerCore.handle(_loc1_);
            }
            _length = 0;
            _package = null;
         }
         if(_length == 0 && _bytes.bytesAvailable > 0)
         {
            processPackage();
         }
      }
   }
}
