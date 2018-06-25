package armShell{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.events.CEvent;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class ArmShellControl extends EventDispatcher   {            private static var _instance:ArmShellControl;                   private var _armShellFrame:ArmShellFrame;            public function ArmShellControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : ArmShellControl { return null; }
            public function setup() : void { }
            public function __showArmShellFrame(event:CEvent) : void { }
   }}