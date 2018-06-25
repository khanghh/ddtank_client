package ddt.notification{   import flash.utils.Dictionary;   import road7th.comm.PackageIn;      public class SocketNotificationManager   {            private static var instance:SocketNotificationManager;                   private var _p1Dic:Dictionary;            public function SocketNotificationManager(single:inner) { super(); }
            public static function getInstance() : SocketNotificationManager { return null; }
            public function addNotificationListener(lv1:int, lv2:int, handler:Function) : void { }
            public function removeNotificationListener(lv1:int, lv2:int, handler:Function) : void { }
            public function dispatchNotification(lv1:int, lv2:int, pkg:PackageIn) : void { }
   }}class inner{          function inner() { super(); }
}