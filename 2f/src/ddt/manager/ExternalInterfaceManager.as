package ddt.manager{   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.net.sendToURL;      public class ExternalInterfaceManager   {            private static var loader:URLLoader;                   public function ExternalInterfaceManager() { super(); }
            public static function sendToAgent(op:int, userID:int = -1, nickName:String = "", serverName:String = "", num:int = -1, pName:String = "", nickName2:String = "") : void { }
            public static function sendTo360Agent(type:int) : void { }
            private static function getEvent(type:int) : String { return null; }
   }}