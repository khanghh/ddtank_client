package ddt.manager{   import catchInsect.event.CatchInsectEvent;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.LoaderSavingManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.view.CheckCodeFrame;   import flash.events.ErrorEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.external.ExternalInterface;   import littleGame.LittleGamePacketQueue;   import littleGame.events.LittleGameSocketEvent;   import petsBag.PetsBagManager;   import road7th.comm.ByteSocket;   import road7th.comm.PackageIn;   import road7th.comm.SocketEvent;      public class SocketManager extends EventDispatcher   {            public static const PACKAGE_CONTENT_START_INDEX:int = 20;            private static var _instance:SocketManager;                   private var _socket:ByteSocket;            private var _out:GameSocketOut;            private var _isLogin:Boolean;            private var _isChangeChannel:Boolean;            private var _isRefresh:Boolean = false;            public function SocketManager() { super(); }
            public static function get Instance() : SocketManager { return null; }
            public function get isChangeChannel() : Boolean { return false; }
            public function set isChangeChannel(value:Boolean) : void { }
            public function set isLogin(value:Boolean) : void { }
            public function get isLogin() : Boolean { return false; }
            public function get socket() : ByteSocket { return null; }
            public function get out() : GameSocketOut { return null; }
            public function connect(ip:String, port:Number) : void { }
            private function __socketConnected(event:Event) : void { }
            public function refresh() : void { }
            private function __socketClose(event:Event) : void { }
            private function __socketError(event:ErrorEvent) : void { }
            private function __systemAlertResponse(evt:FrameEvent) : void { }
            private function __socketData(event:SocketEvent) : void { }
            private function createNewChickenBoxEvent(pkg:PackageIn) : void { }
            private function CSMTimeBoxHandler(pkg:PackageIn) : void { }
            private function activitySystem(pkg:PackageIn) : void { }
            private function activityPackageHandler(pkg:PackageIn) : void { }
            private function recharge(pkg:PackageIn) : void { }
            private function kitUser(msg:String) : void { }
            private function errorAlert(msg:String) : void { }
            private function __onAlertClose(event:FrameEvent) : void { }
            private function cleanLocalFile(msg:String) : void { }
            private function createDiceSystemEvent(pkg:PackageIn) : void { }
            private function createLittleGameEvent(pkg:PackageIn) : void { }
            private function createGameRoomEvent(pkg:PackageIn) : void { }
            private function treasurePkgHandler(pkg:PackageIn) : void { }
            private function createGameEvent(pkg:PackageIn) : void { }
   }}