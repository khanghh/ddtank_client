/**
 * Created by hoanghongkhang on 6/23/17.
 */

package rutexp
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import gameCommon.GameControl;

    public class RutExpManager extends EventDispatcher
    {

        public static const RUT_EXP_TOGGLED:String = "rutExpToggled";

        private var _isRutExp:Boolean = false;

        private var _hostId:int = 0;

        private var _guestId:int = 0;

        private var _isHost:Boolean = false;

        public function get IsRutExp():Boolean
        {
            return _isRutExp;
        }

        private static var _instance:RutExpManager;

        public static function get Instance():RutExpManager
        {
            if (_instance == null)
            {
                _instance = new RutExpManager();
            }
            return _instance;
        }

        public function RutExpManager()
        {
        }

        public function toggleRutExp():Boolean
        {
            _isRutExp = !_isRutExp;
            if (!_isRutExp)
            {
                _hostId = 0;
                _guestId = 0;
                _isHost = false;
            }
            dispatchEvent(new Event(RUT_EXP_TOGGLED));
            return _isRutExp;
        }

        public function setHostId(hostId:int):void
        {
            _hostId = hostId;
        }

        public function setGuestId(guestId:int):void
        {
            _guestId = guestId;
        }

        public function get HostId():int
        {
            return _hostId;
        }

        public function get GuestId():int
        {
            return _guestId;
        }

        public function get IsHost():Boolean
        {
            return _isHost;
        }

        public function set IsHost(isHost:Boolean):void
        {
            _isHost = isHost;
        }
    }
}