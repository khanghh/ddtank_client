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
      
      public function sendEnterFarmPkg(useid:int) : void
      {
         SocketManager.Instance.out.enterFarm(useid);
         if(useid == PlayerManager.Instance.Self.ID)
         {
            startTimer();
         }
      }
      
      public function goFarm(id:int, name:String) : void
      {
         if(PlayerManager.Instance.Self.ID == id && PlayerManager.Instance.Self.Grade < 19)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.goFarm.need20",19));
            return;
         }
         if(_canGoFarm)
         {
            _model.currentFarmerName = name;
            sendEnterFarmPkg(id);
            _canGoFarm = false;
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.goFarm.internal"));
         }
      }
      
      public function sowSeed(fieldId:int, seedsId:int) : void
      {
         SocketManager.Instance.out.seeding(fieldId,seedsId);
      }
      
      public function accelerateField(type:int, fieldId:int, manureId:int) : void
      {
         SocketManager.Instance.out.doMature(type,fieldId,manureId);
      }
      
      public function getHarvest(fieldId:int) : void
      {
         SocketManager.Instance.out.toGather(model.currentFarmerId,fieldId);
      }
      
      public function payField(arr:Array, time:int, bool:Boolean) : void
      {
         SocketManager.Instance.out.toSpread(arr,time,bool);
      }
      
      public function updateFriendListStolen() : void
      {
         updateSetupFriendListStolen(model.currentFarmerId);
      }
      
      public function setupFoodComposeList(anlyer:FoodComposeListAnalyzer) : void
      {
         dispatchEvent(new FarmEvent("accelerateField"));
      }
      
      public function killCrop(fieldId:int) : void
      {
         SocketManager.Instance.out.toKillCrop(fieldId);
      }
      
      public function farmHelperSetSwitch(temp:Array, isAuto:Boolean) : void
      {
         SocketManager.Instance.out.toFarmHelper(temp,isAuto);
      }
      
      public function helperRenewMoney(hour:int, bool:Boolean) : void
      {
         SocketManager.Instance.out.toHelperRenewMoney(hour,bool);
      }
      
      public function arrange() : void
      {
         SocketManager.Instance.out.arrange(_model.currentFarmerId);
      }
      
      public function exitFarm(playerID:int) : void
      {
         SocketManager.Instance.out.exitFarm(playerID);
      }
      
      public function openPayFieldFrame(fieldId:int) : void
      {
         dispatchEvent(new CEvent("openview",{
            "type":2,
            "fieldId":fieldId
         }));
      }
      
      public function getTreePoultryListData(analyzer:FarmTreePoultryListAnalyzer) : void
      {
         _model.farmPoultryInfo = analyzer.list;
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
      
      private function __arrangeFriendFarmHandler(event:CrazyTankSocketEvent) : void
      {
         var state:int = event.pkg.readInt();
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.arrange" + state));
         if(state == 0)
         {
            _model.isArrange = true;
         }
         else
         {
            _model.isArrange = false;
         }
         dispatchEvent(new FarmEvent("arrangeFriendFarm"));
      }
      
      protected function __onFarmBoosFullLevel(event:PkgEvent) : void
      {
         var chatData:ChatData = new ChatData();
         chatData.channel = 21;
         chatData.childChannelArr = [7,14];
         chatData.type = 110;
         chatData.msg = LanguageMgr.GetTranslation("farm.poultry.farmBossFullLevel");
         ChatManager.Instance.chat(chatData);
      }
      
      protected function __onInviteWake(event:PkgEvent) : void
      {
         var sexId:int = !!PlayerManager.Instance.Self.Sex?2:1;
         var chatData:ChatData = new ChatData();
         chatData.channel = 21;
         chatData.childChannelArr = [7,14];
         chatData.type = 109;
         chatData.msg = LanguageMgr.GetTranslation("farm.poultry.inviteWake" + sexId,PlayerManager.Instance.Self.SpouseName);
         ChatManager.Instance.chat(chatData);
      }
      
      protected function __onFarmLandInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var landinfo:* = null;
         var pkg:PackageIn = event.pkg;
         var length:int = pkg.readInt();
         _landInfoVector.length = 0;
         for(i = 0; i < length; )
         {
            landinfo = new FieldVO();
            landinfo.fieldID = pkg.readInt();
            landinfo.seedID = pkg.readInt();
            landinfo.plantTime = pkg.readDate();
            pkg.readInt();
            landinfo.AccelerateTime = pkg.readInt();
            _landInfoVector.push(landinfo);
            i++;
         }
         midAutumnFlag = pkg.readBoolean();
         model.selfFieldsInfo = _landInfoVector;
      }
      
      protected function __updateBuyExpExpNum(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _model.buyExpRemainNum = pkg.readInt();
         dispatchEvent(new FarmEvent("updateBuyExpRemainNum"));
      }
      
      private function __timerhandler(event:TimerEvent) : void
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
      
      private function __onEnterFarm(e:PkgEvent) : void
      {
         var i:int = 0;
         var fieldID:int = 0;
         var seedID:int = 0;
         var payTime:* = null;
         var plantTime:* = null;
         var gainCount:int = 0;
         var fieldValidDate:int = 0;
         var AccelerateTime:int = 0;
         var vo:* = null;
         var existVo:* = null;
         model.fieldsInfo = null;
         model.fieldsInfo = new Vector.<FieldVO>();
         var p:PackageIn = e.pkg;
         _model.currentFarmerId = p.readInt();
         var isAutomatic:Boolean = p.readBoolean();
         var autoSeedID:int = p.readInt();
         var autoStartTime:Date = p.readDate();
         var autoTime:int = p.readInt();
         var seedNeedCount:int = p.readInt();
         var gainPlatCount:int = p.readInt();
         var fieldDicCount:int = p.readInt();
         model.helperArray = [];
         model.helperArray.push(isAutomatic);
         model.helperArray.push(autoSeedID);
         model.helperArray.push(autoStartTime);
         model.helperArray.push(autoTime);
         model.helperArray.push(seedNeedCount);
         model.helperArray.push(gainPlatCount);
         for(i = 0; i < fieldDicCount; )
         {
            fieldID = p.readInt();
            seedID = p.readInt();
            payTime = p.readDate();
            plantTime = p.readDate();
            gainCount = p.readInt();
            fieldValidDate = p.readInt();
            AccelerateTime = p.readInt();
            if(model.getfieldInfoById(fieldID) == null)
            {
               vo = new FieldVO();
               vo.fieldID = fieldID;
               vo.seedID = seedID;
               vo.payTime = payTime;
               vo.plantTime = plantTime;
               vo.fieldValidDate = fieldValidDate;
               vo.AccelerateTime = AccelerateTime;
               vo.gainCount = gainCount;
               vo.autoSeedID = autoSeedID;
               vo.isAutomatic = isAutomatic;
               model.fieldsInfo.push(vo);
            }
            else
            {
               existVo = model.getfieldInfoById(fieldID);
               existVo.seedID = seedID;
               existVo.payTime = payTime;
               existVo.plantTime = plantTime;
               existVo.fieldValidDate = fieldValidDate;
               existVo.AccelerateTime = AccelerateTime;
               existVo.gainCount = gainCount;
               existVo.autoSeedID = autoSeedID;
               existVo.isAutomatic = isAutomatic;
            }
            i++;
         }
         if(_model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            gropPrice = p.readInt();
            _model.payFieldMoney = p.readUTF();
            _model.payAutoMoney = p.readUTF();
            _model.autoPayTime = p.readDate();
            _model.autoValidDate = p.readInt();
            _model.vipLimitLevel = p.readInt();
            _model.selfFieldsInfo = _model.fieldsInfo.concat();
            _model.isAutoId = autoSeedID;
            _model.buyExpRemainNum = p.readInt();
            PlayerManager.Instance.Self.isFarmHelper = isAutomatic;
         }
         else
         {
            _model.isArrange = p.readBoolean();
         }
         show();
         dispatchEvent(new FarmEvent("fieldsInfoReady"));
         SocketManager.Instance.out.getFarmPoultryLevel(FarmModelController.instance.model.currentFarmerId);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("openview",{"type":1}));
      }
      
      private function __gainFieldHandler(event:PkgEvent) : void
      {
         var field:FieldVO = null;
         var bol:Boolean = event.pkg.readBoolean();
         if(bol)
         {
            model.gainFieldId = event.pkg.readInt();
            field = model.getfieldInfoById(model.gainFieldId);
            field.seedID = event.pkg.readInt();
            field.plantTime = event.pkg.readDate();
            field.gainCount = event.pkg.readInt();
            field.AccelerateTime = event.pkg.readInt();
            dispatchEvent(new FarmEvent("gainField"));
         }
      }
      
      private function __payField(event:PkgEvent) : void
      {
         var i:int = 0;
         var fieldID:int = 0;
         var seedID:int = 0;
         var payTime:* = null;
         var plantTime:* = null;
         var gainCount:int = 0;
         var fieldValidDate:int = 0;
         var AccelerateTime:int = 0;
         var vo:* = null;
         var existVo:* = null;
         var pkg:PackageIn = event.pkg;
         _model.currentFarmerId = pkg.readInt();
         var len:int = event.pkg.readInt();
         for(i = 0; i < len; )
         {
            fieldID = pkg.readInt();
            seedID = pkg.readInt();
            payTime = pkg.readDate();
            plantTime = pkg.readDate();
            gainCount = pkg.readInt();
            fieldValidDate = pkg.readInt();
            AccelerateTime = pkg.readInt();
            if(model.getfieldInfoById(fieldID) == null)
            {
               vo = new FieldVO();
               vo.fieldID = fieldID;
               vo.seedID = seedID;
               vo.payTime = payTime;
               vo.plantTime = plantTime;
               vo.fieldValidDate = fieldValidDate;
               vo.AccelerateTime = AccelerateTime;
               vo.gainCount = gainCount;
               model.fieldsInfo.push(vo);
            }
            else
            {
               existVo = model.getfieldInfoById(fieldID);
               existVo.seedID = seedID;
               existVo.payTime = payTime;
               existVo.plantTime = plantTime;
               existVo.fieldValidDate = fieldValidDate;
               existVo.AccelerateTime = AccelerateTime;
               existVo.gainCount = gainCount;
            }
            dispatchEvent(new FarmEvent("fieldsInfoReady"));
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.payField.success"));
            i++;
         }
      }
      
      private function __onSeeding(e:PkgEvent) : void
      {
         var p:PackageIn = e.pkg;
         var fieldID:int = p.readInt();
         var seedID:int = p.readInt();
         var plantTime:Date = p.readDate();
         var payTime:Date = p.readDate();
         var gainNum:int = p.readInt();
         var accelerateDate:int = p.readInt();
         var fieldInfo:FieldVO = model.getfieldInfoById(fieldID);
         fieldInfo.seedID = seedID;
         fieldInfo.plantTime = plantTime;
         fieldInfo.gainCount = gainNum;
         model.seedingFieldInfo = fieldInfo;
         dispatchEvent(new FarmEvent("hasSeeding"));
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.seeding.success"));
      }
      
      private function __onDoMature(event:PkgEvent) : void
      {
         var bol:Boolean = false;
         var i:int = 0;
         var field:* = null;
         var count:int = event.pkg.readInt();
         for(i = 0; i < count; )
         {
            bol = event.pkg.readBoolean();
            if(bol)
            {
               model.matureId = event.pkg.readInt();
               field = model.getfieldInfoById(model.matureId);
               field.gainCount = event.pkg.readInt();
               field.AccelerateTime = event.pkg.readInt();
               dispatchEvent(new FarmEvent("accelerateField"));
            }
            i++;
         }
      }
      
      private function __onKillCrop(event:PkgEvent) : void
      {
         var seedId:int = 0;
         var accelerateDate:int = 0;
         var field:* = null;
         var bol:Boolean = event.pkg.readBoolean();
         if(bol)
         {
            model.killCropId = event.pkg.readInt();
            seedId = event.pkg.readInt();
            accelerateDate = event.pkg.readInt();
            field = model.getfieldInfoById(model.killCropId);
            field.seedID = seedId;
            field.AccelerateTime = accelerateDate;
            dispatchEvent(new FarmEvent("killCropField"));
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.killCrop.success"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.killCrop.fail"));
         }
      }
      
      private function __onHelperSwitch(event:PkgEvent) : void
      {
         model.helperArray = [];
         var isAutomatic:Boolean = event.pkg.readBoolean();
         var autoSeedID:int = event.pkg.readInt();
         var autoStartTime:Date = event.pkg.readDate();
         var autoTime:int = event.pkg.readInt();
         var needSeedCount1:int = event.pkg.readInt();
         var gainCount:int = event.pkg.readInt();
         model.helperArray.push(isAutomatic);
         model.helperArray.push(autoSeedID);
         model.helperArray.push(autoStartTime);
         model.helperArray.push(autoTime);
         model.helperArray.push(needSeedCount1);
         model.helperArray.push(gainCount);
         PlayerManager.Instance.Self.isFarmHelper = isAutomatic;
         if(isAutomatic)
         {
            dispatchEvent(new FarmEvent("beginHelper"));
         }
         else
         {
            dispatchEvent(new FarmEvent("stopHelper"));
         }
      }
      
      private function __onHelperPay(event:PkgEvent) : void
      {
         var autoPayTime:Date = event.pkg.readDate();
         var autoValidDate:int = event.pkg.readInt();
         model.autoPayTime = autoPayTime;
         model.autoValidDate = autoValidDate;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farms.helperMoneyComfirmPnlSuccess"));
         model.dispatchEvent(new FarmEvent("payHepler"));
      }
      
      private function __onExitFarm(event:PkgEvent) : void
      {
      }
      
      public function updateSetupFriendListLoader() : void
      {
         var args:URLVariables = new URLVariables();
         args["selfid"] = PlayerManager.Instance.Self.ID;
         args["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FarmGetUserFieldInfos.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.updateSetupFriendListLoaderFailure");
         loader.analyzer = new FarmFriendListAnalyzer(setupFriendList);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function updateSetupFriendListStolen(itemID:int) : void
      {
         var args:URLVariables = new URLVariables();
         args["selfid"] = PlayerManager.Instance.Self.ID;
         args["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         args["friendID"] = itemID;
         args["rnd"] = Math.random();
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FarmGetUserFieldInfosSingle.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.updateSetupFriendListLoaderFailure");
         loader.analyzer = new FarmFriendListAnalyzer(setupFriendStolen);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      public function creatSuperPetFoodPriceList() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("PetExpItemPrice.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadSpuerPetFoodPricetListComposeListFail");
         loader.analyzer = new SuperPetFoodPriceAnalyzer(setupSuperPetFoodPriceList);
         loader.addEventListener("complete",__onloadSpuerPetFoodPricetListComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      protected function __onloadSpuerPetFoodPricetListComplete(event:LoaderEvent) : void
      {
         dispatchEvent(new FarmEvent("loaderSuperPetFoodPricetList"));
      }
      
      public function setupSuperPetFoodPriceList(analyzer:SuperPetFoodPriceAnalyzer) : void
      {
         model.priceList = analyzer.list;
         dispatchEvent(new FarmEvent("loaderSuperPetFoodPricetList"));
      }
      
      public function setupFriendList(analyzer:FarmFriendListAnalyzer) : void
      {
         model.friendStateList = analyzer.list;
         dispatchEvent(new FarmEvent("friendInfoReady"));
      }
      
      public function setupFriendStolen(analyzer:FarmFriendListAnalyzer) : void
      {
         model.friendStateListStolenInfo = analyzer.list;
         dispatchEvent(new FarmEvent("friendList_updateStolen"));
      }
      
      public function getCurrentMoney() : int
      {
         var i:int = 0;
         var buyExpRemainNum:int = 21 - model.buyExpRemainNum;
         for(i = 0; i < model.priceList.length; )
         {
            if(model.priceList[i].Count == buyExpRemainNum)
            {
               return model.priceList[i].Money;
            }
            i++;
         }
         return 0;
      }
      
      public function getCurrentSuperPetFoodPriceInfo() : SuperPetFoodPriceInfo
      {
         var i:int = 0;
         var buyExpRemainNum:int = 21 - model.buyExpRemainNum;
         for(i = 0; i < model.priceList.length; )
         {
            if(model.priceList[i].Count == buyExpRemainNum)
            {
               return model.priceList[i];
            }
            i++;
         }
         return null;
      }
   }
}
