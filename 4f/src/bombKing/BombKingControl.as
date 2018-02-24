package bombKing
{
   import bombKing.components.BKingPrizeTip;
   import bombKing.event.BombKingEvent;
   import bombKing.view.BombKingMainFrame;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.analyze.FightReportAnalyze;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.QueueManager;
   import ddt.manager.SocketManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLVariables;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class BombKingControl
   {
      
      private static var _instance:BombKingControl;
       
      
      private var _frameSprite:Sprite;
      
      private var _frame:BombKingMainFrame;
      
      private var _cmdID:int = 0;
      
      private var _cmdVec:Vector.<int>;
      
      private var _pkgVec:Vector.<PackageIn>;
      
      private var _showMsg:Boolean = true;
      
      private var _startGameId:int = 0;
      
      public var ReportID:String;
      
      public var isOpen:Boolean;
      
      public var status:int;
      
      public function BombKingControl(){super();}
      
      public static function get instance() : BombKingControl{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      protected function __onStartLoadBattleXml(param1:BombKingEvent) : void{}
      
      protected function __showTip(param1:PkgEvent) : void{}
      
      protected function __onEnterFrame(param1:Event) : void{}
      
      private function creatGameEvent(param1:int) : CrazyTankSocketEvent{return null;}
      
      public function getFightReportLoader(param1:String) : BaseLoader{return null;}
      
      public function getFightInfo(param1:FightReportAnalyze) : void{}
      
      private function play() : void{}
      
      public function reset() : void{}
      
      public function getFightTime() : int{return 0;}
      
      public function playByCmdId(param1:int) : int{return 0;}
      
      public function printVec() : void{}
      
      private function __onOpenView(param1:BombKingEvent) : void{}
      
      protected function onSmallLoadingClose(param1:Event) : void{}
      
      protected function onUIProgress(param1:UIModuleEvent) : void{}
      
      protected function createBombKingFrame(param1:UIModuleEvent) : void{}
      
      public function get frame() : BombKingMainFrame{return null;}
      
      public function set frame(param1:BombKingMainFrame) : void{}
   }
}
