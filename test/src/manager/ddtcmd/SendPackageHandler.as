/**
 * Created by hoanghongkhang on 6/23/17.
 */
package manager.ddtcmd {
import ddt.manager.ChatManager;
import ddt.manager.SocketManager;

import road7th.comm.PackageOut;

    public class SendPackageHandler extends AbstractCommandHandler
    {
        private const CMD:String = "#send";
        public function SendPackageHandler()
        {
            super();
        }

        public override function get cmd():String
        {
            return CMD;
        }

        public override function HandleCommand(param:Array):void
        {
            var pkg:PackageOut = null;

            for each (var args:String in param)
            {
                var attrs:Array = args.split('=');

                switch (attrs[0])
                {
                    case "code":
                        pkg = new PackageOut(int(attrs[1]));
                        break;
                    case "byte":
                            if (pkg)
                                pkg.writeByte(int(attrs[1]));
                            break;
                    case "bool":
                            if (pkg)
                              pkg.writeBoolean(Boolean(attrs[1]));
                            break;
                    case "int":
                            if (pkg)
                               pkg.writeInt(int(attrs[1]));
                            break;
                    case "double":
                            if (pkg)
                                pkg.writeDouble(Number(attrs[1]));
                            break;
                    case "float":
                            if (pkg)
                                pkg.writeFloat(Number(attrs[1]));
                            break;
                    case "date":
                            if (pkg)
                            {
                                var date:Date = new Date();
                                date.setTime(Date.parse(attrs[1]));
                                pkg.writeDate(date);
                            }
                            break;
                    case "array":
                            if (pkg)
                            {
                                ChatManager.Instance.sysChatYellow(attrs[1]);
                                var str:String = attrs[1].substr(1, attrs[1].length - 2);
                                ChatManager.Instance.sysChatYellow("substr: " + str);
                                var arr:Array = str.split(',');
                                ChatManager.Instance.sysChatYellow("sendArray: ");
                                for (var i:int = 0; i < arr.length; i++)
                                {
                                    pkg.writeByte(int(arr[i]));
                                    ChatManager.Instance.sysChatYellow(arr[i] + " ");
                                }
                            }
                            break;
                }
            }
            if (pkg)
            {
                SocketManager.Instance.socket.send(pkg);
            }
            else {
                ChatManager.Instance.sysChatYellow("missing package code.");
            }
        }
    }
}