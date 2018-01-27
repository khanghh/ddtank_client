package road7th.comm
{
import ddt.manager.ChatManager;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.net.Socket;
import flash.utils.ByteArray;

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

    public function sendString(param1:String) : void{}

    public function close() : void{}

    private function handleConnect(param1:Event) : void{}

    private function handleClose(param1:Event) : void{}

    private function handleIoError(param1:ErrorEvent) : void{}

    private function handleIncoming(param1:ProgressEvent) : void{}

    private function readPackage() : void{}

    private function copyByteArray(param1:ByteArray) : ByteArray{return null;}

    public function decrptBytes(param1:ByteArray, param2:int, param3:ByteArray) : ByteArray{return null;}

    public function dispose() : void{}

    private function traceArr(param1:ByteArray) : void {}

//================================================================================================

    private var _showPkgIn : Boolean = false;

    private var _showPkgOut : Boolean = false;

    private var _tracePkgIn : int = -1;

    private var _tracePkgOut : int = -1;

    private var _tracePkgLen : int = -1;

    public function get IsShowPkgIn() : Boolean
    {
        return _showPkgIn;
    }

    public function get IsShowPkgOut() : Boolean
    {
        return _showPkgOut;
    }

    public function toggleShowPkgIn() : void
    {
        _showPkgIn = !_showPkgIn;
    }

    public function toggleShowPkgOut() : void
    {
        _showPkgOut = !_showPkgOut;
    }

    public function tracePkgIn(code:int) : void
    {
        _tracePkgIn = code;
    }

    public function tracePkgOut(code:int) : void
    {
        _tracePkgOut = code;
    }

    public function tracePkgLen(len:int) : void
    {
        _tracePkgLen = len;
    }

    private function handlePackage(param1:PackageIn) : void
    {
        if(!_debug)
        {
        }
        try
        {
            if(param1.checkSum == param1.calculateCheckSum())
            {
                param1.position = 20;
                dispatchEvent(new SocketEvent("data",param1));
                if(_showPkgIn){
                    ChatManager.Instance.sysChatYellow("PackageIn: " + param1.code);
                }
                if (_tracePkgIn != -1)
                {
                    if (param1.code == _tracePkgIn)
                    {
                        tracePkg(param1, "tracePkgIn " + _tracePkgIn + ": ", _tracePkgLen);
                    }
                }
            }
            return;
        }
        catch(err:Error)
        {
            return;
        }
    }

    public function send(param1:PackageOut) : void
    {
        if(_showPkgOut){
            ChatManager.Instance.sysChatYellow("PackageOut: " + param1.code);
        }
        if (_tracePkgOut != -1)
        {
            if (param1.code == _tracePkgOut)
            {
                tracePkg(param1, "tracePkgOut " + _tracePkgOut + ": ", _tracePkgLen);
            }
        }
        var _loc2_:int = 0;
        if(_socket && _socket.connected)
        {
            param1.pack();
            if(!_debug)
            {
            }
            if(_encrypted)
            {
                _loc2_ = 0;
                while(_loc2_ < param1.length)
                {
                    if(_loc2_ > 0)
                    {
                        SEND_KEY[_loc2_ % 8] = SEND_KEY[_loc2_ % 8] + param1[_loc2_ - 1] ^ _loc2_;
                        param1[_loc2_] = (param1[_loc2_] ^ SEND_KEY[_loc2_ % 8]) + param1[_loc2_ - 1];
                    }
                    else
                    {
                        param1[0] = param1[0] ^ SEND_KEY[0];
                    }
                    _loc2_++;
                }
            }
            _socket.writeBytes(param1,0,param1.length);
            _socket.flush();
        }
    }

    private function tracePkg(param1:ByteArray, param2:String, param3:int = -1) : void
    {
        var _loc6_:int = 0;
        var _loc4_:* = param2;
        var _loc5_:int = param3 < 0?param1.length:param3;
        _loc6_ = 0;
        while(_loc6_ < _loc5_)
        {
            _loc4_ = _loc4_ + (String(param1[_loc6_]) + ", ");
            _loc6_++;
        }
        ChatManager.Instance.sysChatYellow(_loc4_);
    }



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
