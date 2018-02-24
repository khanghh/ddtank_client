package ddt.manager
{
import flash.events.Event;
import flash.events.EventDispatcher;

    public class DDTSettings extends EventDispatcher
    {
        private static var _instance : DDTSettings;

        public static function get Instance() : DDTSettings
        {
            if (_instance == null)
            {
                _instance = new DDTSettings();
            }
            return _instance;
        }

        public function DDTSettings()
        {

        }
    }
}