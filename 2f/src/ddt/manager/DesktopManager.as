package ddt.manager{   import com.pickgliss.loader.LoadResourceManager;   import flash.external.ExternalInterface;      public class DesktopManager   {            private static var _instance:DesktopManager;                   private var _desktopType:int;            private var _landersAwardFlag:Boolean;            public function DesktopManager() { super(); }
            public static function get Instance() : DesktopManager { return null; }
            public function checkIsDesktop() : void { }
            private function landersAward() : void { }
            private function SetIsDesktop() : void { }
            public function get isDesktop() : Boolean { return false; }
            public function get desktopType() : int { return 0; }
            public function backToLogin() : void { }
            public function get landersAwardFlag() : Boolean { return false; }
   }}