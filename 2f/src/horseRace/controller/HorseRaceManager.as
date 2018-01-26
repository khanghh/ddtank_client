package horseRace.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.chat.ChatData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import horseRace.events.HorseRaceEvents;
   import horseRace.view.HorseRaceMatchView;
   import horseRace.view.HorseRaceView;
   import road7th.comm.PackageIn;
   
   public class HorseRaceManager extends EventDispatcher
   {
      
      private static var _instance:HorseRaceManager;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _isShowIcon:Boolean;
      
      private var _matchView:HorseRaceMatchView;
      
      public var showBuyCountFram:Boolean = true;
      
      public var showPingzhangBuyFram:Boolean = true;
      
      private var _horseRaceView:HorseRaceView;
      
      public var horseRaceCanRaceTime:int = 0;
      
      public var itemInfoList:Array;
      
      public var buffCD:int;
      
      public function HorseRaceManager(){super();}
      
      public static function get Instance() : HorseRaceManager{return null;}
      
      public function setup() : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function updateCount(param1:PackageIn) : void{}
      
      private function show_msg(param1:PackageIn) : void{}
      
      private function flush_buffItem(param1:PackageIn) : void{}
      
      private function syn_onesecond(param1:PackageIn) : void{}
      
      private function allPlayerRaceEnd(param1:PackageIn) : void{}
      
      private function initPlayerData(param1:PackageIn) : void{}
      
      private function startFiveCountDown(param1:PackageIn) : void{}
      
      private function beginRace(param1:PackageIn) : void{}
      
      private function playerSpeedChange(param1:PackageIn) : void{}
      
      private function playerRaceEnd(param1:PackageIn) : void{}
      
      private function _open_close(param1:CrazyTankSocketEvent) : void{}
      
      public function get isShowIcon() : Boolean{return false;}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      public function enterView() : void{}
      
      private function showMatchView() : void{}
      
      public function showRaceView() : void{}
      
      public function addEnterIcon() : void{}
      
      private function disposeEnterIcon() : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      private function __completeShow(param1:UIModuleEvent) : void{}
   }
}
