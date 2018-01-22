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
      
      public function FarmModelController()
      {
         super();
      }
      
      public static function get instance() : FarmModelController
      {
         return _instance || new FarmModelController();
      }
      
      public function setup() : void
      {
         _model = new FarmModel();
         _landInfoVector = new Vector.<FieldVO>();
         initEvent();
         FarmComposeHouseController.instance().setup();
      }
      
      public function get model() : FarmModel
      {
         return _model;
      }
      
      public function stopTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
         _canGoFarm = true;
      }
      
      public function startTimer() : void
      {
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__timerhandler);
         }
         _timer.reset();
         _timer.start();
      }
      
      public function sendEnterFarmPkg(param1:int) : void
      {
         SocketManager.Instance.out.enterFarm(param1);
         if(param1 == PlayerManager.Instance.Self.ID)
         {
            startTimer();
         }
      }
      
      public function goFarm(param1:int, param2:String) : void
      {
         if(PlayerManager.Instance.Self.ID == param1 && PlayerManager.Instance.Self.Grade < 19)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.goFarm.need20",19));
            return;
         }
         if(_canGoFarm)
         {
            _model.currentFarmerName = param2;
            sendEnterFarmPkg(param1);
            _canGoFarm = false;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.goFarm.internal"));
         }
      }
      
      public function sowSeed(param1:int, param2:int) : void
      {
         SocketManager.Instance.out.seeding(param1,param2);
      }
      
      public function accelerateField(param1:int, param2:int, param3:int) : void
      {
         SocketManager.Instance.out.doMature(param1,param2,param3);
      }
      
      public function getHarvest(param1:int) : void
      {
         SocketManager.Instance.out.toGather(model.currentFarmerId,param1);
      }
      
      public function payField(param1:Array, param2:int, param3:Boolean) : void
      {
         SocketManager.Instance.out.toSpread(param1,param2,param3);
      }
      
      public function updateFriendListStolen() : void
      {
         updateSetupFriendListStolen(model.currentFarmerId);
      }
      
      public function setupFoodComposeList(param1:FoodComposeListAnalyzer) : void
      {
         dispatchEvent(new FarmEvent("accelerateField"));
      }
      
      public function killCrop(param1:int) : void
      {
         SocketManager.Instance.out.toKillCrop(param1);
      }
      
      public function farmHelperSetSwitch(param1:Array, param2:Boolean) : void
      {
         SocketManager.Instance.out.toFarmHelper(param1,param2);
      }
      
      public function helperRenewMoney(param1:int, param2:Boolean) : void
      {
         SocketManager.Instance.out.toHelperRenewMoney(param1,param2);
      }
      
      public function arrange() : void
      {
         SocketManager.Instance.out.arrange(_model.currentFarmerId);
      }
      
      public function exitFarm(param1:int) : void
      {
         SocketManager.Instance.out.exitFarm(param1);
      }
      
      public function openPayFieldFrame(param1:int) : void
      {
         dispatchEvent(new CEvent("openview",{
            "type":2,
            "fieldId":param1
         }));
      }
      
      public function getTreePoultryListData(param1:FarmTreePoultryListAnalyzer) : void
      {
         _model.farmPoultryInfo = param1.list;
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(81,17),__onFarmLandInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,1),__onEnterFarm);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,4),__gainFieldHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,2),__onSeeding);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,6),__payField);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,3),__onDoMature);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,9),__onHelperSwitch);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,7),__onKillCrop);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,8),__onHelperPay);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,16),__onExitFarm);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,19),__updateBuyExpExpNum);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,34),__onInviteWake);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,35),__onFarmBoosFullLevel);
         SocketManager.Instance.addEventListener("arrangeFriendFarm",__arrangeFriendFarmHandler);
      }
      
      private function __arrangeFriendFarmHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.arrange" + _loc2_));
         if(_loc2_ == 0)
         {
            _model.isArrange = true;
         }
         else
         {
            _model.isArrange = false;
         }
         dispatchEvent(new FarmEvent("arrangeFriendFarm"));
      }
      
      protected function __onFarmBoosFullLevel(param1:PkgEvent) : void
      {
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 21;
         _loc2_.childChannelArr = [7,14];
         _loc2_.type = 110;
         _loc2_.msg = LanguageMgr.GetTranslation("farm.poultry.farmBossFullLevel");
         ChatManager.Instance.chat(_loc2_);
      }
      
      protected function __onInviteWake(param1:PkgEvent) : void
      {
         var _loc2_:int = !!PlayerManager.Instance.Self.Sex?2:1;
         var _loc3_:ChatData = new ChatData();
         _loc3_.channel = 21;
         _loc3_.childChannelArr = [7,14];
         _loc3_.type = 109;
         _loc3_.msg = LanguageMgr.GetTranslation("farm.poultry.inviteWake" + _loc2_,PlayerManager.Instance.Self.SpouseName);
         ChatManager.Instance.chat(_loc3_);
      }
      
      protected function __onFarmLandInfo(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _landInfoVector.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new FieldVO();
            _loc4_.fieldID = _loc3_.readInt();
            _loc4_.seedID = _loc3_.readInt();
            _loc4_.plantTime = _loc3_.readDate();
            _loc3_.readInt();
            _loc4_.AccelerateTime = _loc3_.readInt();
            _landInfoVector.push(_loc4_);
            _loc5_++;
         }
         midAutumnFlag = _loc3_.readBoolean();
         model.selfFieldsInfo = _landInfoVector;
      }
      
      protected function __updateBuyExpExpNum(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _model.buyExpRemainNum = _loc2_.readInt();
         dispatchEvent(new FarmEvent("updateBuyExpRemainNum"));
      }
      
      private function __timerhandler(param1:TimerEvent) : void
      {
         _timer.currentCount % 120 == 0;
         if(_timer.currentCount % 120 == 0)
         {
         }
         if(_timer.currentCount % 60 == 0)
         {
            dispatchEvent(new FarmEvent("frushField"));
         }
         if(_timer.currentCount % 2 == 0)
         {
            _canGoFarm = true;
         }
      }
      
      private function __onEnterFarm(param1:PkgEvent) : void
      {
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc17_:int = 0;
         var _loc8_:int = 0;
         var _loc18_:int = 0;
         var _loc11_:* = null;
         var _loc5_:* = null;
         model.fieldsInfo = null;
         model.fieldsInfo = new Vector.<FieldVO>();
         var _loc15_:PackageIn = param1.pkg;
         _model.currentFarmerId = _loc15_.readInt();
         var _loc19_:Boolean = _loc15_.readBoolean();
         var _loc2_:int = _loc15_.readInt();
         var _loc13_:Date = _loc15_.readDate();
         var _loc9_:int = _loc15_.readInt();
         var _loc4_:int = _loc15_.readInt();
         var _loc6_:int = _loc15_.readInt();
         var _loc16_:int = _loc15_.readInt();
         model.helperArray = [];
         model.helperArray.push(_loc19_);
         model.helperArray.push(_loc2_);
         model.helperArray.push(_loc13_);
         model.helperArray.push(_loc9_);
         model.helperArray.push(_loc4_);
         model.helperArray.push(_loc6_);
         _loc12_ = 0;
         while(_loc12_ < _loc16_)
         {
            _loc10_ = _loc15_.readInt();
            _loc14_ = _loc15_.readInt();
            _loc7_ = _loc15_.readDate();
            _loc3_ = _loc15_.readDate();
            _loc17_ = _loc15_.readInt();
            _loc8_ = _loc15_.readInt();
            _loc18_ = _loc15_.readInt();
            if(model.getfieldInfoById(_loc10_) == null)
            {
               _loc11_ = new FieldVO();
               _loc11_.fieldID = _loc10_;
               _loc11_.seedID = _loc14_;
               _loc11_.payTime = _loc7_;
               _loc11_.plantTime = _loc3_;
               _loc11_.fieldValidDate = _loc8_;
               _loc11_.AccelerateTime = _loc18_;
               _loc11_.gainCount = _loc17_;
               _loc11_.autoSeedID = _loc2_;
               _loc11_.isAutomatic = _loc19_;
               model.fieldsInfo.push(_loc11_);
            }
            else
            {
               _loc5_ = model.getfieldInfoById(_loc10_);
               _loc5_.seedID = _loc14_;
               _loc5_.payTime = _loc7_;
               _loc5_.plantTime = _loc3_;
               _loc5_.fieldValidDate = _loc8_;
               _loc5_.AccelerateTime = _loc18_;
               _loc5_.gainCount = _loc17_;
               _loc5_.autoSeedID = _loc2_;
               _loc5_.isAutomatic = _loc19_;
            }
            _loc12_++;
         }
         if(_model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            gropPrice = _loc15_.readInt();
            _model.payFieldMoney = _loc15_.readUTF();
            _model.payAutoMoney = _loc15_.readUTF();
            _model.autoPayTime = _loc15_.readDate();
            _model.autoValidDate = _loc15_.readInt();
            _model.vipLimitLevel = _loc15_.readInt();
            _model.selfFieldsInfo = _model.fieldsInfo.concat();
            _model.isAutoId = _loc2_;
            _model.buyExpRemainNum = _loc15_.readInt();
            PlayerManager.Instance.Self.isFarmHelper = _loc19_;
         }
         else
         {
            _model.isArrange = _loc15_.readBoolean();
         }
         show();
         dispatchEvent(new FarmEvent("fieldsInfoReady"));
         SocketManager.Instance.out.getFarmPoultryLevel(FarmModelController.instance.model.currentFarmerId);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("openview",{"type":1}));
      }
      
      private function __gainFieldHandler(param1:PkgEvent) : void
      {
         var _loc2_:FieldVO = null;
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            model.gainFieldId = param1.pkg.readInt();
            _loc2_ = model.getfieldInfoById(model.gainFieldId);
            _loc2_.seedID = param1.pkg.readInt();
            _loc2_.plantTime = param1.pkg.readDate();
            _loc2_.gainCount = param1.pkg.readInt();
            _loc2_.AccelerateTime = param1.pkg.readInt();
            dispatchEvent(new FarmEvent("gainField"));
         }
      }
      
      private function __payField(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:* = null;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         _model.currentFarmerId = _loc4_.readInt();
         var _loc5_:int = param1.pkg.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc7_ = _loc4_.readInt();
            _loc11_ = _loc4_.readInt();
            _loc6_ = _loc4_.readDate();
            _loc2_ = _loc4_.readDate();
            _loc12_ = _loc4_.readInt();
            _loc8_ = _loc4_.readInt();
            _loc13_ = _loc4_.readInt();
            if(model.getfieldInfoById(_loc7_) == null)
            {
               _loc10_ = new FieldVO();
               _loc10_.fieldID = _loc7_;
               _loc10_.seedID = _loc11_;
               _loc10_.payTime = _loc6_;
               _loc10_.plantTime = _loc2_;
               _loc10_.fieldValidDate = _loc8_;
               _loc10_.AccelerateTime = _loc13_;
               _loc10_.gainCount = _loc12_;
               model.fieldsInfo.push(_loc10_);
            }
            else
            {
               _loc3_ = model.getfieldInfoById(_loc7_);
               _loc3_.seedID = _loc11_;
               _loc3_.payTime = _loc6_;
               _loc3_.plantTime = _loc2_;
               _loc3_.fieldValidDate = _loc8_;
               _loc3_.AccelerateTime = _loc13_;
               _loc3_.gainCount = _loc12_;
            }
            dispatchEvent(new FarmEvent("fieldsInfoReady"));
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.payField.success"));
            _loc9_++;
         }
      }
      
      private function __onSeeding(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc9_:int = _loc5_.readInt();
         var _loc2_:int = _loc5_.readInt();
         var _loc3_:Date = _loc5_.readDate();
         var _loc8_:Date = _loc5_.readDate();
         var _loc6_:int = _loc5_.readInt();
         var _loc7_:int = _loc5_.readInt();
         var _loc4_:FieldVO = model.getfieldInfoById(_loc9_);
         _loc4_.seedID = _loc2_;
         _loc4_.plantTime = _loc3_;
         _loc4_.gainCount = _loc6_;
         model.seedingFieldInfo = _loc4_;
         dispatchEvent(new FarmEvent("hasSeeding"));
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.seeding.success"));
      }
      
      private function __onDoMature(param1:PkgEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1.pkg.readBoolean();
            if(_loc4_)
            {
               model.matureId = param1.pkg.readInt();
               _loc2_ = model.getfieldInfoById(model.matureId);
               _loc2_.gainCount = param1.pkg.readInt();
               _loc2_.AccelerateTime = param1.pkg.readInt();
               dispatchEvent(new FarmEvent("accelerateField"));
            }
            _loc5_++;
         }
      }
      
      private function __onKillCrop(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Boolean = param1.pkg.readBoolean();
         if(_loc4_)
         {
            model.killCropId = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            _loc5_ = param1.pkg.readInt();
            _loc2_ = model.getfieldInfoById(model.killCropId);
            _loc2_.seedID = _loc3_;
            _loc2_.AccelerateTime = _loc5_;
            dispatchEvent(new FarmEvent("killCropField"));
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.killCrop.success"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.killCrop.fail"));
         }
      }
      
      private function __onHelperSwitch(param1:PkgEvent) : void
      {
         model.helperArray = [];
         var _loc7_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Date = param1.pkg.readDate();
         var _loc6_:int = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         model.helperArray.push(_loc7_);
         model.helperArray.push(_loc2_);
         model.helperArray.push(_loc3_);
         model.helperArray.push(_loc6_);
         model.helperArray.push(_loc4_);
         model.helperArray.push(_loc5_);
         PlayerManager.Instance.Self.isFarmHelper = _loc7_;
         if(_loc7_)
         {
            dispatchEvent(new FarmEvent("beginHelper"));
         }
         else
         {
            dispatchEvent(new FarmEvent("stopHelper"));
         }
      }
      
      private function __onHelperPay(param1:PkgEvent) : void
      {
         var _loc3_:Date = param1.pkg.readDate();
         var _loc2_:int = param1.pkg.readInt();
         model.autoPayTime = _loc3_;
         model.autoValidDate = _loc2_;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farms.helperMoneyComfirmPnlSuccess"));
         model.dispatchEvent(new FarmEvent("payHepler"));
      }
      
      private function __onExitFarm(param1:PkgEvent) : void
      {
      }
      
      public function updateSetupFriendListLoader() : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_["selfid"] = PlayerManager.Instance.Self.ID;
         _loc2_["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         _loc2_["rnd"] = Math.random();
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FarmGetUserFieldInfos.ashx"),6,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.updateSetupFriendListLoaderFailure");
         _loc1_.analyzer = new FarmFriendListAnalyzer(setupFriendList);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      public function updateSetupFriendListStolen(param1:int) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["selfid"] = PlayerManager.Instance.Self.ID;
         _loc3_["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         _loc3_["friendID"] = param1;
         _loc3_["rnd"] = Math.random();
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FarmGetUserFieldInfosSingle.ashx"),6,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.updateSetupFriendListLoaderFailure");
         _loc2_.analyzer = new FarmFriendListAnalyzer(setupFriendStolen);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      public function creatSuperPetFoodPriceList() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetExpItemPrice.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadSpuerPetFoodPricetListComposeListFail");
         _loc1_.analyzer = new SuperPetFoodPriceAnalyzer(setupSuperPetFoodPriceList);
         _loc1_.addEventListener("complete",__onloadSpuerPetFoodPricetListComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      protected function __onloadSpuerPetFoodPricetListComplete(param1:LoaderEvent) : void
      {
         dispatchEvent(new FarmEvent("loaderSuperPetFoodPricetList"));
      }
      
      public function setupSuperPetFoodPriceList(param1:SuperPetFoodPriceAnalyzer) : void
      {
         model.priceList = param1.list;
         dispatchEvent(new FarmEvent("loaderSuperPetFoodPricetList"));
      }
      
      public function setupFriendList(param1:FarmFriendListAnalyzer) : void
      {
         model.friendStateList = param1.list;
         dispatchEvent(new FarmEvent("friendInfoReady"));
      }
      
      public function setupFriendStolen(param1:FarmFriendListAnalyzer) : void
      {
         model.friendStateListStolenInfo = param1.list;
         dispatchEvent(new FarmEvent("friendList_updateStolen"));
      }
      
      public function getCurrentMoney() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 21 - model.buyExpRemainNum;
         _loc2_ = 0;
         while(_loc2_ < model.priceList.length)
         {
            if(model.priceList[_loc2_].Count == _loc1_)
            {
               return model.priceList[_loc2_].Money;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function getCurrentSuperPetFoodPriceInfo() : SuperPetFoodPriceInfo
      {
         var _loc2_:int = 0;
         var _loc1_:int = 21 - model.buyExpRemainNum;
         _loc2_ = 0;
         while(_loc2_ < model.priceList.length)
         {
            if(model.priceList[_loc2_].Count == _loc1_)
            {
               return model.priceList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
