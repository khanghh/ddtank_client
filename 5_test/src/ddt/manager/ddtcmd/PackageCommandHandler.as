/**
 * Created by hoanghongkhang on 6/23/17.
 */
package ddt.manager.ddtcmd {
import ddt.manager.ChatManager;
import ddt.manager.DDTSettings;
import ddt.manager.SocketManager;

public class PackageCommandHandler extends AbstractCommandHandler{

        private const CMD:String = "#pkg";

        public function PackageCommandHandler()
        {
            super();
        }

        public override function get cmd():String
        {
            return CMD;
        }

        public override function HandleCommand(param:Array):void
        {
            for each (var args:String in param)
            {
                var attrs:Array = args.split('=');
                switch (attrs[0])
                {
                    case "showPkgIn":
                        SocketManager.Instance.socket.toggleShowPkgIn();
                        ChatManager.Instance.sysChatYellow("IsShowPkgIn: " + SocketManager.Instance.socket.IsShowPkgIn.toString());
                        break;
                    case "showPkgOut":
                        SocketManager.Instance.socket.toggleShowPkgOut();
                        ChatManager.Instance.sysChatYellow("IsShowPkgOut: " + SocketManager.Instance.socket.IsShowPkgOut.toString());
                        break;
                    case "tracePkgIn":
                        SocketManager.Instance.socket.tracePkgIn(int(attrs[1]));
                        ChatManager.Instance.sysChatYellow("tracePkgIn: " + attrs[1]);
                        break;
                    case "tracePkgOut":
                        SocketManager.Instance.socket.tracePkgOut(int(attrs[1]));
                        ChatManager.Instance.sysChatYellow("tracePkgOut: " + attrs[1]);
                        break;
                    case "tracePkgLen":
                        SocketManager.Instance.socket.tracePkgLen(int(attrs[1]));
                        ChatManager.Instance.sysChatYellow("tracePkgLen: " + attrs[1]);
                        break;
                }
            }
        }
    }
}
