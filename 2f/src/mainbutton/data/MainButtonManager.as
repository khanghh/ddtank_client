package mainbutton.data{   import flash.utils.Dictionary;   import mainbutton.MainButton;      public class MainButtonManager   {            private static var _instance:MainButtonManager;                   private var _HallIconList:Dictionary;            public function MainButtonManager() { super(); }
            public static function get instance() : MainButtonManager { return null; }
            public function gethallIconInfo(analyzer:HallIconDataAnalyz) : void { }
            public function getInfoByID(key:String) : MainButton { return null; }
   }}