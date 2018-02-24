package ddt.manager
{
   import catchInsect.event.CatchInsectEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.view.CheckCodeFrame;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import littleGame.LittleGamePacketQueue;
   import littleGame.events.LittleGameSocketEvent;
   import petsBag.PetsBagManager;
   import road7th.comm.ByteSocket;
   import road7th.comm.PackageIn;
   import road7th.comm.SocketEvent;
   
   public class SocketManager extends EventDispatcher
   {
      
      public static const PACKAGE_CONTENT_START_INDEX:int = 20;
      
      private static var _instance:SocketManager;
       
      
      private var _socket:ByteSocket;
      
      private var _out:GameSocketOut;
      
      private var _isLogin:Boolean;
      
      private var _isChangeChannel:Boolean;
      
      private var _isRefresh:Boolean = false;
      
      public function SocketManager(){super();}
      
      public static function get Instance() : SocketManager{return null;}
      
      public function get isChangeChannel() : Boolean{return false;}
      
      public function set isChangeChannel(param1:Boolean) : void{}
      
      public function set isLogin(param1:Boolean) : void{}
      
      public function get isLogin() : Boolean{return false;}
      
      public function get socket() : ByteSocket{return null;}
      
      public function get out() : GameSocketOut{return null;}
      
      public function connect(param1:String, param2:Number) : void{}
      
      private function __socketConnected(param1:Event) : void{}
      
      public function refresh() : void{}
      
      private function __socketClose(param1:Event) : void{}
      
      private function __socketError(param1:ErrorEvent) : void{}
      
      private function __systemAlertResponse(param1:FrameEvent) : void{}
      
      private function __socketData(param1:SocketEvent) : void{}
      
      private function createNewChickenBoxEvent(param1:PackageIn) : void{}
      
      private function CSMTimeBoxHandler(param1:PackageIn) : void{}
      
      private function activitySystem(param1:PackageIn) : void{}
      
      private function activityPackageHandler(param1:PackageIn) : void{}
      
      private function recharge(param1:PackageIn) : void{}
      
      private function kitUser(param1:String) : void{}
      
      private function errorAlert(param1:String) : void{}
      
      private function __onAlertClose(param1:FrameEvent) : void{}
      
      private function cleanLocalFile(param1:String) : void{}
      
      private function createDiceSystemEvent(param1:PackageIn) : void{}
      
      private function createLittleGameEvent(param1:PackageIn) : void{}
      
      private function createGameRoomEvent(param1:PackageIn) : void{}
      
      private function treasurePkgHandler(param1:PackageIn) : void{}
      
      private function createGameEvent(param1:PackageIn) : void{}
   }
}
