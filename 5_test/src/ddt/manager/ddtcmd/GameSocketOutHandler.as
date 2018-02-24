/**
 * Created by hoanghongkhang on 6/23/17.
 */
package ddt.manager.ddtcmd
{
import ddt.manager.ChatManager;
import ddt.manager.DDTSettings;
import ddt.manager.GameSocketOut;
import ddt.manager.SocketManager;

public class GameSocketOutHandler extends AbstractCommandHandler
    {
        private const CMD:String = "#out";
        public function GameSocketOutHandler()
        {
            super();
        }

        public override function get cmd():String
        {
            return CMD;
        }

        public override function HandleCommand(param:Array):void
        {
            var funcName:String = "null";
            var scope:GameSocketOut = SocketManager.Instance.out;
            var func:Function = null;
            var funcArgs:Array = new Array();
            for each (var args:String in param)
            {
                var attrs:Array = args.split('=');
                switch (attrs[0])
                {
                    case "func":
                        funcName = attrs[1];
                        func = scope[funcName];
                        break;
                    case "bool":
                        funcArgs.push(Boolean(attrs[1]));
                        break;
                    case "byte":
                        funcArgs.push(int(attrs[1]));
                        break;
                    case "int":
                        funcArgs.push(int(attrs[1]));
                        break;
                    case "string":
                        funcArgs.push(attrs[1]);
                        break;
                }
            }
            if (func)
            {
                switch (funcArgs.length)
                {
                    case 0:
                        ChatManager.Instance.sysChatYellow("call " + funcName + "();");
                        func.call(scope);
                        break;
                    case 1:
                        ChatManager.Instance.sysChatYellow("call " + funcName + "(" + funcArgs[0] + ");");
                        func.call(scope, funcArgs[0]);
                        break;
                    case 2:
                        ChatManager.Instance.sysChatYellow("call " + funcName + "(" + funcArgs[0] + "," + funcArgs[1] + ");");
                        func.call(scope, funcArgs[0], funcArgs[1]);
                        break;
                    case 3:
                        ChatManager.Instance.sysChatYellow("call " + funcName + "(" + funcArgs[0] + "," + funcArgs[1] +"," + funcArgs[2] + ");");
                        func.call(scope, funcArgs[0], funcArgs[1], funcArgs[2]);
                        break;
                    case 4:
                        ChatManager.Instance.sysChatYellow("call " + funcName + "(" + funcArgs[0] + "," + funcArgs[1] + "," + funcArgs[2] + "," + funcArgs[3] + ");");
                        func.call(scope, funcArgs[0], funcArgs[1], funcArgs[2], funcArgs[3]);
                        break;
                    case 5:
                        ChatManager.Instance.sysChatYellow("call " + funcName + "(" + funcArgs[0] + "," + funcArgs[1] + "," + funcArgs[2] + "," + funcArgs[3] + "," + funcArgs[4] + ");");
                        func.call(scope, funcArgs[0], funcArgs[1], funcArgs[2], funcArgs[3], funcArgs[4]);
                        break;

                }
            }
        }
    }
}