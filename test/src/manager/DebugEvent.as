package manager
{
    import flash.events.Event;
    public class DebugEvent extends Event
    {
        private var _cmd:String;

        public function get cmd() : String
        {
            return _cmd;
        }

        public function DebugEvent(type:String, cmd:String)
        {
            _cmd = cmd;
            super(type);
        }
    }
}
