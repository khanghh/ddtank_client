package setting.controll{   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.manager.SharedManager;      public class SettingController extends CoreManager   {            private static var _instance:SettingController;            public static const CLOSE_VIEW:String = "closeview";                   private var _isShow:Boolean;            public function SettingController() { super(); }
            public static function get Instance() : SettingController { return null; }
            override protected function start() : void { }
            public function switchVisible() : void { }
            public function showSetingView() : void { }
            public function hide() : void { }
            public function set isShow(value:Boolean) : void { }
            public function get isShow() : Boolean { return false; }
   }}