package ddt.manager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import road7th.comm.AutoByteSocket;
	import road7th.comm.PackageIn;
	import road7th.comm.SocketEvent;
	
	public class AutoSocketManager extends EventDispatcher
	{
		
		public static const PACKAGE_CONTENT_START_INDEX:int = 20;
		
		private static var _instance:AutoSocketManager;
		
		
		private var _socket:AutoByteSocket;
		
		private var _out:ddt.manager.AutoSocketOut;
		
		private var _isLogin:Boolean;
		
		private var _isChangeChannel:Boolean;
		
		private var _isRefresh:Boolean = false;
		
		public function AutoSocketManager()
		{
			_socket = new AutoByteSocket(false, false);
			_socket.addEventListener("connect",__socketConnected);
			_socket.addEventListener("close",__socketClose);
			_socket.addEventListener("data",__socketData);
			_socket.addEventListener("error",__socketError);
			_out = new AutoSocketOut(_socket);
		}
		
		protected function __socketError(event:ErrorEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function __socketData(event:SocketEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function __socketClose(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function __socketConnected(event:Event):void
		{
			ChatManager.Instance.sysChatYellow("Connected");
		}
		
		public static function get Instance() : AutoSocketManager
		{
			if(_instance == null)
			{
				_instance = new AutoSocketManager;
			}
			return _instance;
		}
		
		public function get isChangeChannel() : Boolean
		{
			return _isChangeChannel;
		}
		
		public function set isChangeChannel(param1:Boolean) : void
		{
			_isChangeChannel = param1;
		}
		
		public function set isLogin(param1:Boolean) : void
		{
			_isLogin = param1;
		}
		
		public function get isLogin() : Boolean
		{
			return _isLogin;
		}
		
		public function get socket() : AutoByteSocket
		{
			return _socket;
		}
		
		public function get out() : AutoSocketOut
		{
			return _out;
		}
		
		public function connect(param1:String, param2:Number) : void
		{
			_socket.connect(param1,param2);
		}
	}
}
