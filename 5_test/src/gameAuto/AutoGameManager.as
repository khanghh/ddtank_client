/**
 * Created by hoanghongkhang on 6/23/17.
 */

package gameAuto
{
import flash.events.Event;
import flash.events.EventDispatcher;

    public class AutoGameManager extends EventDispatcher
    {

        public static const AUTO_MATCH_GAME_TOGGLED : String = "autoMatchGameToggled";

        private var _isAutoMatchGame : Boolean = false;

        public function get IsAutoMatchGame() : Boolean
        {
            return _isAutoMatchGame;
        }

        private static var _instance : AutoGameManager;

        public static function get Instance() : AutoGameManager
        {
            if (_instance == null)
            {
                _instance = new AutoGameManager();
            }
            return _instance;
        }

        public function AutoGameManager()
        {

        }

        public function toggleAutoMatchGame() : Boolean
        {
            _isAutoMatchGame = !_isAutoMatchGame;
            dispatchEvent(new Event(AUTO_MATCH_GAME_TOGGLED));
            return _isAutoMatchGame;
        }

    }
}