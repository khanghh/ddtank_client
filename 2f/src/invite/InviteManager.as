package invite{   import ddt.CoreManager;   import ddt.data.InviteInfo;   import ddt.events.CEvent;      public class InviteManager extends CoreManager   {            public static const SHOW_RESPONSEINVITEFRAME:String = "showResponseInviteFrame";            public static const CLEAR_RESPONSEINVITEFRAME:String = "clearResponseInviteFrame";            private static var _ins:InviteManager;                   private var _enabled:Boolean = true;            private var _inviteFrameInfo:InviteInfo;            public function InviteManager() { super(); }
            public static function get Instance() : InviteManager { return null; }
            public function setup() : void { }
            private function __showResponseInviteFrameHandler(event:CEvent) : void { }
            private function __clearResponseInviteFrameHandler(event:CEvent) : void { }
            public function get enabled() : Boolean { return false; }
            public function set enabled(value:Boolean) : void { }
            public function clearResponseInviteFrame() : void { }
            public function showResponseInviteFrame(info:InviteInfo) : void { }
   }}