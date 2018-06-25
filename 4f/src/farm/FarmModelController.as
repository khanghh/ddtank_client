package farm{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.MD5;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.view.chat.ChatData;   import farm.analyzer.FarmFriendListAnalyzer;   import farm.analyzer.FarmTreePoultryListAnalyzer;   import farm.analyzer.FoodComposeListAnalyzer;   import farm.analyzer.SuperPetFoodPriceAnalyzer;   import farm.control.FarmComposeHouseController;   import farm.modelx.FieldVO;   import farm.modelx.SuperPetFoodPriceInfo;   import flash.events.TimerEvent;   import flash.net.URLVariables;   import flash.utils.Timer;   import road7th.comm.PackageIn;      public class FarmModelController extends CoreManager   {            private static var _instance:FarmModelController;            public static var MAXLEVEL:int = 0;                   private var _model:FarmModel;            private var _timer:Timer;            private var _canGoFarm:Boolean = true;            private var _landInfoVector:Vector.<FieldVO>;            public var gropPrice:int;            public var midAutumnFlag:Boolean;            public var FightPoultryFlag:Boolean;            public function FarmModelController() { super(); }
            public static function get instance() : FarmModelController { return null; }
            public function setup() : void { }
            public function get model() : FarmModel { return null; }
            public function stopTimer() : void { }
            public function startTimer() : void { }
            public function sendEnterFarmPkg(useid:int) : void { }
            public function goFarm(id:int, name:String) : void { }
            public function sowSeed(fieldId:int, seedsId:int) : void { }
            public function accelerateField(type:int, fieldId:int, manureId:int) : void { }
            public function getHarvest(fieldId:int) : void { }
            public function payField(arr:Array, time:int, bool:Boolean) : void { }
            public function updateFriendListStolen() : void { }
            public function setupFoodComposeList(anlyer:FoodComposeListAnalyzer) : void { }
            public function killCrop(fieldId:int) : void { }
            public function farmHelperSetSwitch(temp:Array, isAuto:Boolean) : void { }
            public function helperRenewMoney(hour:int, bool:Boolean) : void { }
            public function arrange() : void { }
            public function exitFarm(playerID:int) : void { }
            public function openPayFieldFrame(fieldId:int) : void { }
            public function getTreePoultryListData(analyzer:FarmTreePoultryListAnalyzer) : void { }
            private function initEvent() : void { }
            private function __arrangeFriendFarmHandler(event:CrazyTankSocketEvent) : void { }
            protected function __onFarmBoosFullLevel(event:PkgEvent) : void { }
            protected function __onInviteWake(event:PkgEvent) : void { }
            protected function __onFarmLandInfo(event:PkgEvent) : void { }
            protected function __updateBuyExpExpNum(event:PkgEvent) : void { }
            private function __timerhandler(event:TimerEvent) : void { }
            private function __onEnterFarm(e:PkgEvent) : void { }
            override protected function start() : void { }
            private function __gainFieldHandler(event:PkgEvent) : void { }
            private function __payField(event:PkgEvent) : void { }
            private function __onSeeding(e:PkgEvent) : void { }
            private function __onDoMature(event:PkgEvent) : void { }
            private function __onKillCrop(event:PkgEvent) : void { }
            private function __onHelperSwitch(event:PkgEvent) : void { }
            private function __onHelperPay(event:PkgEvent) : void { }
            private function __onExitFarm(event:PkgEvent) : void { }
            public function updateSetupFriendListLoader() : void { }
            public function updateSetupFriendListStolen(itemID:int) : void { }
            public function creatSuperPetFoodPriceList() : void { }
            protected function __onloadSpuerPetFoodPricetListComplete(event:LoaderEvent) : void { }
            public function setupSuperPetFoodPriceList(analyzer:SuperPetFoodPriceAnalyzer) : void { }
            public function setupFriendList(analyzer:FarmFriendListAnalyzer) : void { }
            public function setupFriendStolen(analyzer:FarmFriendListAnalyzer) : void { }
            public function getCurrentMoney() : int { return 0; }
            public function getCurrentSuperPetFoodPriceInfo() : SuperPetFoodPriceInfo { return null; }
   }}