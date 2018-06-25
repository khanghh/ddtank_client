package invite{   import flash.events.EventDispatcher;      public class InviteControl extends EventDispatcher   {            private static var _ins:InviteControl;                   public function InviteControl() { super(); }
            public static function get instance() : InviteControl { return null; }
   }}