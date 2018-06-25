package road7th.comm
{
    import ddt.manager.ChatManager;

    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.ProgressEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;

    [Event(name="connect", type="flash.events.Event")]
    [Event(name="close", type="flash.events.Event")]
    [Event(name="error", type="flash.events.ErrorEvent")]
    [Event(name="data", type="road7th.comm.SocketEvent")]
    public class ByteSocket extends EventDispatcher
    {

        private static var KEY:Array = [174, 191, 86, 120, 171, 205, 239, 241];

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

        public function ByteSocket(encrypted:Boolean = true, debug:Boolean = false) { super(); }

        public function setKey(key:Array):void { }

        public function resetKey():void { }

        public function setFsm(adder:int, muliter:int):void { }

        public function connect(ip:String, port:Number):void { }

        private function addEvent(socket:Socket):void { }

        private function removeEvent(socket:Socket):void { }

        public function get connected():Boolean { return false; }

        public function isSame(ip:String, port:int):Boolean { return false; }

        public function sendString(data:String):void { }

        public function close():void { }

        private function handleConnect(event:Event):void { }

        private function handleClose(event:Event):void { }

        private function handleIoError(event:ErrorEvent):void { }

        private function handleIncoming(event:ProgressEvent):void { }

        private function readPackage():void { }

        private function copyByteArray(src:ByteArray):ByteArray { return null; }

        public function decrptBytes(src:ByteArray, len:int, key:ByteArray):ByteArray { return null; }


        private function traceArr(arr:ByteArray):void { }

        public function dispose():void { }

//================================================================================================

        private var _showPkgIn:Boolean = false;

        private var _showPkgOut:Boolean = false;

        private var _tracePkgIn:int = -1;

        private var _tracePkgOut:int = -1;

        private var _tracePkgLen:int = -1;

        public function get IsShowPkgIn():Boolean
        {
            return _showPkgIn;
        }

        public function get IsShowPkgOut():Boolean
        {
            return _showPkgOut;
        }

        public function toggleShowPkgIn():void
        {
            _showPkgIn = !_showPkgIn;
        }

        public function toggleShowPkgOut():void
        {
            _showPkgOut = !_showPkgOut;
        }

        public function tracePkgIn(code:int):void
        {
            _tracePkgIn = code;
        }

        public function tracePkgOut(code:int):void
        {
            _tracePkgOut = code;
        }

        public function tracePkgLen(len:int):void
        {
            _tracePkgLen = len;
        }

        private function handlePackage(pkg:PackageIn):void
        {
            if (!_debug)
            {
            }
            try
            {
                if (pkg.checkSum == pkg.calculateCheckSum())
                {
                    pkg.position = 20;
                    dispatchEvent(new SocketEvent("data", pkg));
                    if (_showPkgIn)
                    {
                        ChatManager.Instance.sysChatYellow("PackageIn: " + pkg.code);
                    }
                    if (_tracePkgIn != -1)
                    {
                        if (pkg.code == _tracePkgIn)
                        {
                            tracePkg(pkg, "tracePkgIn " + _tracePkgIn + ": ", _tracePkgLen);
                        }
                    }
                }
                return;
            }
            catch (err:Error)
            {
                return;
            }
        }

        public function send(pkg:PackageOut):void
        {
            if (_showPkgOut)
            {
                ChatManager.Instance.sysChatYellow("PackageOut: " + pkg.code);
            }
            if (_tracePkgOut != -1)
            {
                if (pkg.code == _tracePkgOut)
                {
                    tracePkg(pkg, "tracePkgOut " + _tracePkgOut + ": ", _tracePkgLen);
                }
            }
            var i:int = 0;
            if (_socket && _socket.connected)
            {
                pkg.pack();
                if (!_debug)
                {
                }
                if (_encrypted)
                {
                    i = 0;
                    while (i < pkg.length)
                    {
                        if (i > 0)
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
                _socket.writeBytes(pkg, 0, pkg.length);
                _socket.flush();
            }
        }

        private function tracePkg(src:ByteArray, des:String, len:int = -1):void
        {
            var i:int = 0;
            var str:* = des;
            var l:int = len < 0 ? src.length : len;
            i = 0;
            while (i < l)
            {
                str = str + (String(src[i]) + ", ");
                i++;
            }
            ChatManager.Instance.sysChatYellow(str);
        }

    }
}

class FSM
{
    private var _state:int;

    private var _adder:int;

    private var _multiper:int;

    function FSM(adder:int, multiper:int) { super(); }

    public function getState():int { return 0; }

    public function reset():void { }

    public function setup(adder:int, multiper:int):void { }

    public function updateState():int { return 0; }
}
