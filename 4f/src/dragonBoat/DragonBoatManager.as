package dragonBoat
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import dragonBoat.analyzer.DragonBoatActiveDataAnalyzer;
   import dragonBoat.data.DragonBoatActiveInfo;
   import dragonBoat.data.DragonBoatAwardInfo;
   import dragonBoat.event.DragonBoatEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import hall.player.HallPlayerView;
   import road7th.StarlingMain;
   import road7th.comm.PackageIn;
   import starling.scene.hall.HallScene;
   import starling.scene.hall.StaticLayer;
   
   public class DragonBoatManager extends CoreManager
   {
      
      public static const END_UPDATE:String = "DragonBoatEndUpdate";
      
      public static const BOAT_RES_LOAD_COMPLETE:String = "DragonBoatBoatResLoadComplete";
      
      public static const BUILD_OR_DECORATE_UPDATE:String = "DragonBoatBuildOrDecorateUpdate";
      
      public static const REFRESH_BOAT_STATUS:String = "DragonBoatRefreshBoatStatus";
      
      public static const UPDATE_RANK_INFO:String = "DragBoatUpdateRankInfo";
      
      public static const DRAGONBOAT_CHIP:int = 11690;
      
      public static const KINGSTATUE_CHIP:int = 11771;
      
      public static const LINSHI_CHIP:int = 201309;
      
      private static var _instance:DragonBoatManager;
       
      
      private var _activeInfo:DragonBoatActiveInfo;
      
      private var _boatExpList:Array;
      
      private var _awardsListSelf:Array;
      
      private var _awardsListOther:Array;
      
      private var _awardsInfoSelf:Object;
      
      private var _awardsInfoOther:Object;
      
      private var _boatCompleteExp:int;
      
      private var _useableScore:int;
      
      private var _totalScore:int;
      
      private var _periodType:int = 0;
      
      private var _isLoadBoatResComplete:Boolean;
      
      private var _isHadOpenedFrame:Boolean;
      
      private var _playerView:HallPlayerView;
      
      private var _btn:BaseButton;
      
      public var type:int;
      
      private var isShowed:Boolean;
      
      public function DragonBoatManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DragonBoatManager{return null;}
      
      public function get activeInfo() : DragonBoatActiveInfo{return null;}
      
      public function get boatCompleteStatus() : int{return 0;}
      
      public function get boatInWhatStatus() : int{return 0;}
      
      public function get useableScore() : int{return 0;}
      
      public function get totalScore() : int{return 0;}
      
      public function get isStart() : Boolean{return false;}
      
      public function get isCanBuildOrDecorate() : Boolean{return false;}
      
      public function get isLoadBoatResComplete() : Boolean{return false;}
      
      public function templateDataSetup(param1:DragonBoatActiveDataAnalyzer) : void{}
      
      public function getAwardInfoByRank(param1:int, param2:int) : Array{return null;}
      
      private function createInventoryItemInfo(param1:DragonBoatAwardInfo) : InventoryItemInfo{return null;}
      
      public function setup() : void{}
      
      public function setPlayerView(param1:HallPlayerView, param2:BaseButton) : void{}
      
      public function updateNPCStatus() : void{}
      
      public function addToHall() : void{}
      
      public function removeFromHall() : void{}
      
      private function pkgHandler(param1:PkgEvent) : void{}
      
      private function updateSelfRank(param1:PackageIn) : void{}
      
      private function updateOtherRank(param1:PackageIn) : void{}
      
      private function openOrClose(param1:PackageIn) : void{}
      
      private function showChat() : void{}
      
      public function setOpenFrameParam() : void{}
      
      private function buildOrDecorate(param1:PackageIn) : void{}
      
      private function refreshBoatStatus(param1:PackageIn) : void{}
      
      public function get isBuildEnd() : Boolean{return false;}
      
      public function get periodType() : int{return 0;}
      
      override protected function start() : void{}
   }
}
