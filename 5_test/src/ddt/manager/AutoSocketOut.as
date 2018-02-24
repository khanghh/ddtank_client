package ddt.manager
{
import flash.utils.ByteArray;

import road7th.comm.AutoByteSocket;
import road7th.comm.PackageOut;

	public class AutoSocketOut
	{
		private var _socket:AutoByteSocket;
		public function AutoSocketOut(sock:AutoByteSocket)
		{
			_socket = sock;
		}


		
		public function sendPackage(param1:PackageOut) : void
		{
			ChatManager.Instance.sysChatYellow("code: " + param1.code.toString());
			_socket.send(param1);
		}

		public function sendMessage(msg:String) : void
		{
			var pkg:PackageOut = new PackageOut(50);
			pkg.writeUTF(msg);
			_socket.send(pkg);
			pkg.length
		}
		
		public function sendWind(num:int, data:ByteArray) : void
		{
			var pkg:PackageOut = new PackageOut(123);
			pkg.writeByte(num);
			pkg.writeBytes(data,0,data.length);
			sendPackage(pkg);
		}
	}
}