package baglocked{   import ddt.CoreManager;      public class BaglockedManager extends CoreManager   {            public static var PWD:String = "";            public static var TEMP_PWD:String = "";            public static var LOCK_SETTING:int = 0;            private static var _instance:BaglockedManager;                   public function BaglockedManager() { super(); }
            public static function get Instance() : BaglockedManager { return null; }
            override protected function start() : void { }
            public function onShow() : void { }
   }}