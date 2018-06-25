package armShell{   import ddt.CoreManager;   import ddt.events.CEvent;   import flash.events.IEventDispatcher;      public class ArmShellManager extends CoreManager   {            public static const SHOWARMSHELLFRAME:String = "showArmShellFrame";            private static var _instance:ArmShellManager;                   public function ArmShellManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : ArmShellManager { return null; }
            public function showArmShellFrame() : void { }
            override protected function start() : void { }
   }}