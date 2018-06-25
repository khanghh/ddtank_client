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
      
      public function ByteSocket(encrypted:Boolean = true, debug:Boolean = false)
      {
         super();
         _readBuffer = new ByteArray();
         _send_fsm = new FSM(2059198199,1501);
         _receive_fsm = new FSM(2059198199,1501);
         _headerTemp = new ByteArray();
         _encrypted = encrypted;
         _debug = debug;
         setKey(KEY);
      }
      
      public function setKey(key:Array) : void
      {
         var i:int = 0;
         RECEIVE_KEY = new ByteArray();
         SEND_KEY = new ByteArray();
         for(i = 0; i < 8; )
         {
            RECEIVE_KEY.writeByte(key[i]);
            SEND_KEY.writeByte(key[i]);
            i++;
         }
      }
      
      public function resetKey() : void
      {
         setKey(KEY);
      }
      
      public function setFsm(adder:int, muliter:int) : void
      {
         _send_fsm.setup(adder,muliter);
         _receive_fsm.setup(adder,muliter);
      }
      
      public function connect(ip:String, port:Number) : void
      {
         try
         {
            if(_socket)
            {
               close();
            }
            _socket = new Socket();
            addEvent(_socket);
            _ip = ip;
            _port = port;
            _readBuffer.position = 0;
            _readOffset = 0;
            _writeOffset = 0;
            _socket.connect(ip,port);
            return;
         }
         catch(err:Error)
         {
            dispatchEvent(new ErrorEvent("error",false,false,err.message));
            return;
         }
      }
      
      private function addEvent(socket:Socket) : void
      {
         socket.addEventListener("connect",this.handleConnect);
         socket.addEventListener("close",this.handleClose);
         socket.addEventListener("socketData",handleIncoming);
         socket.addEventListener("ioError",handleIoError);
         socket.addEventListener("securityError",handleIoError);
      }
      
      private function removeEvent(socket:Socket) : void
      {
         socket.removeEventListener("connect",this.handleConnect);
         socket.removeEventListener("close",this.handleClose);
         socket.removeEventListener("socketData",handleIncoming);
         socket.removeEventListener("ioError",handleIoError);
         socket.removeEventListener("securityError",handleIoError);
      }
      
      public function get connected() : Boolean
      {
         return _socket && _socket.connected;
      }
      
      public function isSame(ip:String, port:int) : Boolean
      {
         return _ip == ip && port == _port;
      }
      
      public function send(pkg:PackageOut) : void
      {
         var i:int = 0;
         if(_socket && _socket.connected)
         {
            pkg.pack();
            if(!_debug)
            {
            }
            if(_encrypted)
            {
               for(i = 0; i < pkg.length; )
               {
                  if(i > 0)
                  {
                     SEND_KEY[i % 8] = SEND_KEY[i % 8] + pkg[i - 1] ^ i;
                     pkg[i] = (pkg[i] ^ SEND_KEY[i % 8]) + pkg[i - 1];
                  }
                  else
                  {
                     pkg[0] = pkg[0] ^ SEND_KEY[0];
                  }
                  i++;
               }
            }
            _socket.writeBytes(pkg,0,pkg.length);
            _socket.flush();
         }
      }
      
      public function sendString(data:String) : void
      {
         if(_socket.connected)
         {
            _socket.writeUTF(data);
            _socket.flush();
         }
      }
      
      public function close() : void
      {
         removeEvent(_socket);
         if(_socket.connected)
         {
            _socket.close();
         }
      }
      
      private function handleConnect(event:Event) : void
      {
         try
         {
            _send_fsm.reset();
            _receive_fsm.reset();
            _send_fsm.setup(2059198199,1501);
            _receive_fsm.setup(2059198199,1501);
            dispatchEvent(new Event("connect"));
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function handleClose(event:Event) : void
      {
         try
         {
            removeEvent(_socket);
            dispatchEvent(new Event("close"));
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function handleIoError(event:ErrorEvent) : void
      {
         try
         {
            dispatchEvent(new ErrorEvent("error",false,false,event.text));
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private function handleIncoming(event:ProgressEvent) : void
      {
         var len:int = 0;
         if(_socket.bytesAvailable > 0)
         {
            len = _socket.bytesAvailable;
            _socket.readBytes(_readBuffer,_writeOffset,_socket.bytesAvailable);
            _writeOffset = _writeOffset + len;
            if(_writeOffset > 1)
            {
               _readBuffer.position = 0;
               _readOffset = 0;
               if(_readBuffer.bytesAvailable >= 20)
               {
                  readPackage();
               }
            }
         }
      }
      
      private function readPackage() : void
      {
         var len:int = 0;
         var buff:* = null;
         var dataLeft:int = _writeOffset - _readOffset;
         while(true)
         {
            len = 0;
            while(_readOffset + 4 < _writeOffset)
            {
               _headerTemp.position = 0;
               _headerTemp.writeByte(_readBuffer[_readOffset]);
               _headerTemp.writeByte(_readBuffer[_readOffset + 1]);
               _headerTemp.writeByte(_readBuffer[_readOffset + 2]);
               _headerTemp.writeByte(_readBuffer[_readOffset + 3]);
               if(_encrypted)
               {
                  _headerTemp = decrptBytes(_headerTemp,4,copyByteArray(RECEIVE_KEY));
               }
               _headerTemp.position = 0;
               if(_headerTemp.readShort() == 29099)
               {
                  len = _headerTemp.readUnsignedShort();
                  break;
               }
               _readOffset = Number(_readOffset) + 1;
            }
            dataLeft = _writeOffset - _readOffset;
            if(dataLeft >= len && len != 0)
            {
               _readBuffer.position = _readOffset;
               buff = new PackageIn();
               if(_encrypted)
               {
                  buff.loadE(_readBuffer,len,RECEIVE_KEY);
               }
               else
               {
                  buff.load(_readBuffer,len);
               }
               _readOffset = _readOffset + len;
               dataLeft = _writeOffset - _readOffset;
               handlePackage(buff);
               if(dataLeft < 20)
               {
                  break;
               }
               continue;
            }
            break;
         }
         _readBuffer.position = 0;
         if(dataLeft > 0)
         {
            _readBuffer.writeBytes(_readBuffer,_readOffset,dataLeft);
         }
         _readOffset = 0;
         _writeOffset = dataLeft;
      }
      
      private function copyByteArray(src:ByteArray) : ByteArray
      {
         var i:int = 0;
         var result:ByteArray = new ByteArray();
         for(i = 0; i < src.length; )
         {
            result.writeByte(src[i]);
            i++;
         }
         return result;
      }
      
      public function decrptBytes(src:ByteArray, len:int, key:ByteArray) : ByteArray
      {
         var i:int = 0;
         var result:ByteArray = new ByteArray();
         for(i = 0; i < len; )
         {
            result.writeByte(src[i]);
            i++;
         }
         for(i = 0; i < len; )
         {
            if(i > 0)
            {
               key[i % 8] = key[i % 8] + src[i - 1] ^ i;
               result[i] = src[i] - src[i - 1] ^ key[i % 8];
            }
            else
            {
               result[0] = src[0] ^ key[0];
            }
            i++;
         }
         return result;
      }
      
      private function tracePkg(src:ByteArray, des:String, len:int = -1) : void
      {
         var i:int = 0;
         var str:* = des;
         var l:int = len < 0?src.length:len;
         for(i = 0; i < l; )
         {
            str = str + (String(src[i]) + ", ");
            i++;
         }
      }
      
      private function traceArr(arr:ByteArray) : void
      {
         var i:int = 0;
         var str:String = "[";
         for(i = 0; i < arr.length; )
         {
            str = str + (arr[i] + " ");
            i++;
         }
         str = str + "]";
      }
      
      private function handlePackage(pkg:PackageIn) : void
      {
         if(!_debug)
         {
         }
         try
         {
            if(pkg.checkSum == pkg.calculateCheckSum())
            {
               pkg.position = 20;
               dispatchEvent(new SocketEvent("data",pkg));
            }
            return;
         }
         catch(err:Error)
         {
            return;
         }
      }
      
      public function dispose() : void
      {
         if(_socket.connected)
         {
            _socket.close();
         }
         _socket = null;
      }
   }
}

class FSM
{
    
   
   private var _state:int;
   
   private var _adder:int;
   
   private var _multiper:int;
   
   function FSM(adder:int, multiper:int)
   {
      super();
      setup(adder,multiper);
   }
   
   public function getState() : int
   {
      return _state;
   }
   
   public function reset() : void
   {
      _state = 0;
   }
   
   public function setup(adder:int, multiper:int) : void
   {
      _adder = adder;
      _multiper = multiper;
      updateState();
   }
   
   public function updateState() : int
   {
      _state = (~_state + _adder) * _multiper;
      _state = _state ^ _state >> 16;
      return _state;
   }
}
