package farm
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.MD5;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.chat.ChatData;
   import farm.analyzer.FarmFriendListAnalyzer;
   import farm.analyzer.FarmTreePoultryListAnalyzer;
   import farm.analyzer.FoodComposeListAnalyzer;
   import farm.analyzer.SuperPetFoodPriceAnalyzer;
   import farm.control.FarmComposeHouseController;
   import farm.modelx.FieldVO;
   import farm.modelx.SuperPetFoodPriceInfo;
   import flash.events.TimerEvent;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   
   public class FarmModelController extends CoreManager
   {
      
      private static var _instance:FarmModelController;
      
      public static var MAXLEVEL:int = 0;
       
      
      private var _model:FarmModel;
      
      private var _timer:Timer;
      
      private var _canGoFarm:Boolean = true;
      
      private var _landInfoVector:Vector.<FieldVO>;
      
      public var gropPrice:int;
      
      public var midAutumnFlag:Boolean;
      
      public var FightPoultryFlag:Boolean;
      
      public function FarmModelController(){super();}
      
      public static function get instance() : FarmModelController{return null;}
      
      public function setup() : void{}
      
      public function get model() : FarmModel{return null;}
      
      public function stopTimer() : void{}
      
      public function startTimer() : void{}
      
      public function sendEnterFarmPkg(param1:int) : void{}
      
      public function goFarm(param1:int, param2:String) : void{}
      
      public function sowSeed(param1:int, param2:int) : void{}
      
      public function accelerateField(param1:int, param2:int, param3:int) : void{}
      
      public function getHarvest(param1:int) : void{}
      
      public function payField(param1:Array, param2:int, param3:Boolean) : void{}
      
      public function updateFriendListStolen() : void{}
      
      public function setupFoodComposeList(param1:FoodComposeListAnalyzer) : void{}
      
      public function killCrop(param1:int) : void{}
      
      public function farmHelperSetSwitch(param1:Array, param2:Boolean) : void{}
      
      public function helperRenewMoney(param1:int, param2:Boolean) : void{}
      
      public function arrange() : void{}
      
      public function exitFarm(param1:int) : void{}
      
      public function openPayFieldFrame(param1:int) : void{}
      
      public function getTreePoultryListData(param1:FarmTreePoultryListAnalyzer) : void{}
      
      private function initEvent() : void{}
      
      private function __arrangeFriendFarmHandler(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onFarmBoosFullLevel(param1:PkgEvent) : void{}
      
      protected function __onInviteWake(param1:PkgEvent) : void{}
      
      protected function __onFarmLandInfo(param1:PkgEvent) : void{}
      
      protected function __updateBuyExpExpNum(param1:PkgEvent) : void{}
      
      private function __timerhandler(param1:TimerEvent) : void{}
      
      private function __onEnterFarm(param1:PkgEvent) : void{}
      
      override protected function start() : void{}
      
      private function __gainFieldHandler(param1:PkgEvent) : void{}
      
      private function __payField(param1:PkgEvent) : void{}
      
      private function __onSeeding(param1:PkgEvent) : void{}
      
      private function __onDoMature(param1:PkgEvent) : void{}
      
      private function __onKillCrop(param1:PkgEvent) : void{}
      
      private function __onHelperSwitch(param1:PkgEvent) : void{}
      
      private function __onHelperPay(param1:PkgEvent) : void{}
      
      private function __onExitFarm(param1:PkgEvent) : void{}
      
      public function updateSetupFriendListLoader() : void{}
      
      public function updateSetupFriendListStolen(param1:int) : void{}
      
      public function creatSuperPetFoodPriceList() : void{}
      
      protected function __onloadSpuerPetFoodPricetListComplete(param1:LoaderEvent) : void{}
      
      public function setupSuperPetFoodPriceList(param1:SuperPetFoodPriceAnalyzer) : void{}
      
      public function setupFriendList(param1:FarmFriendListAnalyzer) : void{}
      
      public function setupFriendStolen(param1:FarmFriendListAnalyzer) : void{}
      
      public function getCurrentMoney() : int{return 0;}
      
      public function getCurrentSuperPetFoodPriceInfo() : SuperPetFoodPriceInfo{return null;}
   }
}
