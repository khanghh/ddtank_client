package ddt.manager
{
    import com.pickgliss.ui.ComponentFactory;
    import com.pickgliss.ui.LayerManager;

    import ddt.manager.ddtcmd.GameSocketOutHandler;
    import ddt.manager.ddtcmd.PackageCommandHandler;
    import ddt.manager.ddtcmd.RetrieveHandler;
    import ddt.manager.ddtcmd.SendPackageHandler;
    import ddt.manager.view.DDTConsole;

    import flash.external.ExternalInterface;
    import flash.utils.Dictionary;

    import ddt.manager.ddtcmd.AutoPVPHandler;
    import ddt.manager.ddtcmd.ConsortionBankHandler;
    import ddt.manager.ddtcmd.DDQiYuanJoinRewardHandler;
    import ddt.manager.ddtcmd.ICommandHandler;
    import ddt.manager.ddtcmd.SettingsHandler;
    import ddt.manager.ddtcmd.WasteRecycleStartTurnHandler;

    import game.view.GameViewBase;
    import game.view.heroAuto.HeroAutoView;
    import game.view.map.MapView;
    import game.view.matchGameAuto.MatchGameAutoView;

    import gameCommon.GameControl;

    import gameCommon.model.GameInfo;
    import gameCommon.model.LocalPlayer;

    import phy.maps.Map;

    import road7th.comm.PackageOut;

    import room.RoomManager;

    public class DDTManager
    {
        private static var _instance:DDTManager;
        private var _settings:DDTSettings;
        private var _commands:Dictionary;

        private var _ddtConsole:DDTConsole;

        function DDTManager()
        {
            _settings = new DDTSettings();
            _commands = new Dictionary();
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("handle", handle);
            }
//            _ddtConsole = new DDTConsole(this);
//			LayerManager.Instance.addToLayer(_ddtConsole,4,false,0,false);
            RegisterCommandHandler(new ConsortionBankHandler());
            RegisterCommandHandler(new DDQiYuanJoinRewardHandler());
            RegisterCommandHandler(new WasteRecycleStartTurnHandler());
            RegisterCommandHandler(new PackageCommandHandler());
            RegisterCommandHandler(new SettingsHandler());
            RegisterCommandHandler(new SendPackageHandler());
            RegisterCommandHandler(new AutoPVPHandler());
            RegisterCommandHandler(new RetrieveHandler());
            RegisterCommandHandler(new GameSocketOutHandler());
            RegisterUI();
        }

        public static function get Instance():DDTManager
        {
            if (_instance == null)
            {
                _instance = new DDTManager();
            }
            return _instance;
        }

        public function get Settings():DDTSettings
        {
            return _settings;
        }

        public function handle(param1:String):void
        {
            var args:Array = null;
            args = param1.split(" ");
            var cmd:String = args[0];
            var handler:ICommandHandler = null;

            try
            {
                ChatManager.Instance.sysChatYellow("cmd: " + cmd);
                if (cmd == "#test")
                {
                    ComponentFactory.Instance.creatCustomObject("game.view.matchGameAuto.matchGameAutoView");
                }
                else if (cmd == "#connect")
                {
                    ChatManager.Instance.sysChatYellow("Connecting...");
                    AutoSocketManager.Instance.connect("127.0.0.1", 5800);

                }
                else if (cmd == "#test2")
                {
                    ChatManager.Instance.sysChatYellow("Sending...");
                    var pkg:PackageOut = new PackageOut(50);
                    pkg.writeUTF("dfbfdbdfb");
                    AutoSocketManager.Instance.out.sendPackage(pkg);
                }
                if (cmd == "#roominfo")
                {
                    ChatManager.Instance.sysChatYellow("RoomType: " + RoomManager.Instance.current.type.toString());
//					ChatManager.Instance.sysChatYellow("matchRoom: " + (StateManager.getState("matchRoom") != null).toString());
//					if (RoomManager.Instance.current != null)
//					{
//						ChatManager.Instance.sysChatYellow("started: " + RoomManager.Instance.current.started.toString());
//						ChatManager.Instance.sysChatYellow("isReady: " + RoomManager.Instance.current.selfRoomPlayer.isReady .toString());
//					}
                }
                else if (cmd == "#gameinfo")
                {
                    var a:GameInfo = new GameInfo();
                    a.roomType = 0;
                }
                else if (cmd == "#angle")
                {
                    ChatManager.Instance.sysChatYellow("direction: " + GameControl.Instance.Current.selfGamePlayer.direction);
                    ChatManager.Instance.sysChatYellow("angle: " + GameControl.Instance.Current.selfGamePlayer.calcBombAngle());
                    ChatManager.Instance.sysChatYellow("playerAngle: " + GameControl.Instance.Current.selfGamePlayer.playerAngle);
                    ChatManager.Instance.sysChatYellow("maxAngle: " + GameControl.Instance.Current.selfGamePlayer.currentWeapInfo.armMaxAngle);
                    ChatManager.Instance.sysChatYellow("minAngle: " + GameControl.Instance.Current.selfGamePlayer.currentWeapInfo.armMinAngle);
                }
                else if (cmd == "#selfPoint")
                {
                    var selfPlayer:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
                    var map:MapView = selfPlayer.currentMap;
                    ChatManager.Instance.sysChatYellow("selfPoint: " + GameControl.Instance.Current.selfGamePlayer.pos.x + ", " + GameControl.Instance.Current.selfGamePlayer.pos.y);
                    ChatManager.Instance.sysChatYellow("map x,y: " + map.bound.x + ", " + map.bound.y);
                    ChatManager.Instance.sysChatYellow("map w,h: " + map.bound.width + ", " + map.bound.height);
                }
                else if (cmd == "#isEmpty")
                {
                    var selfPlayer:LocalPlayer = GameControl.Instance.Current.selfGamePlayer;
                    var map:MapView = selfPlayer.currentMap;
                    var x:int = args[1];
                    var y:int = args[2];
                    ChatManager.Instance.sysChatYellow("x,y: " + x + "," + y);
                    ChatManager.Instance.sysChatYellow(((map.ground != null && !map.ground.IsEmpty(x, y)) || (map.stone != null && !map.stone.IsEmpty(x, y))).toString());
                }
                else
                {
                    handler = _commands[cmd];
                    if (handler != null)
                    {
                        handler.HandleCommand(args);
                    }
                    else
                    {
                        //ChatManager.Instance.sysChatYellow("Error: command not found !");
                    }
                }

            }
            catch (e:Error)
            {
                ChatManager.Instance.sysChatYellow(e.message + e.getStackTrace());
            }
        }

        public function get ddtConsole():DDTConsole
        {
            return _ddtConsole;
        }

        public function RegisterCommandHandler(handler:ICommandHandler):void
        {
            if (_commands[handler.cmd] === undefined)
            {
                _commands[handler.cmd] = handler;
            }
        }

        public function RegisterUI():void
        {
            _ddtConsole = new DDTConsole();
            LayerManager.Instance.addToLayer(_ddtConsole, LayerManager.STAGE_TOP_LAYER, false, 0, false);
        }
    }
}