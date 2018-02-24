package catchInsect
{
   import catchInsect.event.CatchInsectEvent;
   import catchInsect.event.InsectEvent;
   import ddt.CoreManager;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CatchInsectManager extends CoreManager
   {
      
      public static const UPDATE_INFO:String = "updateInfo";
      
      public static var isToRoom:Boolean;
      
      private static var _instance:CatchInsectManager;
       
      
      private var _self:SelfInfo;
      
      private var _model:CatchInsectModel;
      
      private var _hallStateView:HallStateView;
      
      private var _catchInsectIcon:MovieClip;
      
      private var _mapPath:String;
      
      private var _appearPos:Array;
      
      private var _catchInsectInfo:CatchInsectItemInfo;
      
      public var isReConnect:Boolean = false;
      
      public var loadUiModuleComplete:Boolean = false;
      
      private var _timer:TimerJuggler;
      
      private var _hasPrompted:DictionaryData;
      
      public var useCakeFlag:Boolean;
      
      private var _funcId:int = 0;
      
      public function CatchInsectManager(){super();}
      
      public static function get instance() : CatchInsectManager{return null;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CatchInsectEvent) : void{}
      
      private function updateScore(param1:PackageIn) : void{}
      
      private function enterScene(param1:PackageIn) : void{}
      
      public function initSceneData() : void{}
      
      public function getCatchInsectResource() : String{return null;}
      
      public function solveMonsterPath(param1:String) : String{return null;}
      
      public function reConnectCatchInectFunc() : void{}
      
      public function reConnect() : void{}
      
      public function reConnectLoadUiComplete() : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      protected function __timerHandler(param1:Event) : void{}
      
      public function showEnterIcon(param1:Boolean) : void{}
      
      public function onClickCatchInsectIcon() : void{}
      
      override protected function start() : void{}
      
      public function get catchInsectInfo() : CatchInsectItemInfo{return null;}
      
      public function exitGame() : void{}
      
      public function get model() : CatchInsectModel{return null;}
      
      public function get mapPath() : String{return null;}
      
      public function get isShowIcon() : Boolean{return false;}
   }
}
