package roomList.movingNotification{   import ddt.data.analyze.MovingNotificationAnalyzer;   import flash.display.DisplayObjectContainer;      public class MovingNotificationManager   {            private static var _instance:MovingNotificationManager;                   private var _list:Array;            private var _view:MovingNotificationView;            public function MovingNotificationManager() { super(); }
            public static function get Instance() : MovingNotificationManager { return null; }
            public function setup(analyzer:MovingNotificationAnalyzer) : void { }
            public function showIn(display:DisplayObjectContainer) : void { }
            public function get view() : MovingNotificationView { return null; }
            public function hide() : void { }
   }}