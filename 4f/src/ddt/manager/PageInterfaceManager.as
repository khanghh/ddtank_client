package ddt.manager{   import flash.external.ExternalInterface;   import flash.system.fscommand;      public class PageInterfaceManager   {                   public function PageInterfaceManager() { super(); }
            public static function changePageTitle() : void { }
            public static function restorePageTitle() : void { }
            public static function askForFavorite() : void { }
            private static function call(functionName:String, ... arg) : void { }
   }}