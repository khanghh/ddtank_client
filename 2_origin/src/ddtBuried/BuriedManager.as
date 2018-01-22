package ddtBuried
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.BagInfo;
   import ddt.data.ServerConfigInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import ddtBuried.analyer.SearchGoodsPayAnalyer;
   import ddtBuried.analyer.UpdateStarAnalyer;
   import ddtBuried.data.MapItemData;
   import ddtBuried.data.SearchGoodsData;
   import ddtBuried.data.UpdateStarData;
   import ddtBuried.event.BuriedEvent;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.filters.ColorMatrixFilter;
   import road7th.comm.PackageIn;
   
   public class BuriedManager extends EventDispatcher
   {
      
      private static var _instance:BuriedManager;
       
      
      public var mapdataList:Vector.<MapItemData>;
      
      public var mapID:int;
      
      public var level:int;
      
      public var nowPosition:int;
      
      private var serverConfigInfo:ServerConfigInfo;
      
      public var payMoneyList:Vector.<SearchGoodsData>;
      
      public var upDateStarList:Vector.<UpdateStarData>;
      
      public var pay_count:int;
      
      private var totol_count:int;
      
      public var limit:int;
      
      public var currPayLevel:int = -1;
      
      public var takeCardPayList:Array;
      
      public var eventPosition:int = -1;
      
      public var takeCardLimit:int;
      
      public var cardInitList:Array;
      
      public var currCardIndex:int;
      
      public var isContinue:Boolean;
      
      public var isGetGoods:Boolean;
      
      public var isOpenBuried:Boolean;
      
      public var isBuriedBox:Boolean;
      
      public var isGo:Boolean;
      
      public var isBack:Boolean;
      
      public var isBackToStart:Boolean;
      
      public var isGoEnd:Boolean;
      
      public var stoneNum:int;
      
      private var _isOpening:Boolean;
      
      private var cardPayinfo:ServerConfigInfo;
      
      public var currGoodID:int;
      
      private var _money:int;
      
      private var _outFun:Function;
      
      private var _timesReachEnd:int;
      
      private var _stateRewardsGained:int;
      
      public var _num:int;
      
      private var _timesBuyDice:int;
      
      public var boxNeedTimesList:Array;
      
      public var maxTimesCanGainRewards:int;
      
      public var isOver:Boolean;
      
      public function BuriedManager()
      {
         super();
      }
      
      public static function get Instance() : BuriedManager
      {
         if(!_instance)
         {
            _instance = new BuriedManager();
         }
         return _instance;
      }
      
      public function get isOpening() : Boolean
      {
         return _isOpening;
      }
      
      public function set isOpening(param1:Boolean) : void
      {
         _isOpening = param1;
      }
      
      public function setup() : void
      {
         initEvents();
      }
      
      public function enter() : void
      {
         AssetModuleLoader.addModelLoader("ddtburied",6);
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.loaderSearchGoodsPayMoney());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.loaderSearchGoodsTemp());
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function playerEnterHander(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         serverConfigInfo = ServerConfigManager.instance.serverConfigInfo["SearchGoodsFreeCount"];
         cardPayinfo = ServerConfigManager.instance.serverConfigInfo["SearchGoodsTakeCardMoney"];
         takeCardPayList = cardPayinfo.Value.split("|");
         pay_count = payMoneyList.length;
         totol_count = pay_count + int(serverConfigInfo.Value);
         dispose();
         mapdataList = new Vector.<MapItemData>();
         var _loc4_:PackageIn = param1.pkg;
         mapID = _loc4_.readInt();
         level = _loc4_.readInt();
         nowPosition = _loc4_.readInt();
         _num = _loc4_.readInt();
         isOver = false;
         if(num > pay_count)
         {
            limit = num - pay_count;
         }
         else
         {
            limit = num;
            currPayLevel = pay_count - num + 1;
         }
         var _loc2_:int = _loc4_.readInt();
         if(_loc2_ == 0)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = new MapItemData();
            _loc3_.type = _loc4_.readInt();
            _loc3_.tempID = _loc4_.readInt();
            mapdataList.push(_loc3_);
            _loc5_++;
         }
         timesReachEnd = _loc4_.readInt();
         stateRewardsGained = _loc4_.readInt();
         timesBuyDice = _loc4_.readInt();
         dispatchEvent(new BuriedEvent("buriedOpenView"));
      }
      
      private function loadComplete() : void
      {
         SocketManager.Instance.out.enterBuried();
      }
      
      public function checkMoney(param1:Boolean, param2:int, param3:Function = null) : Boolean
      {
         _money = param2;
         _outFun = param3;
         if(param1)
         {
            if(PlayerManager.Instance.Self.BandMoney < param2)
            {
               if(param3 != null)
               {
                  initAlertFarme();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               }
               return true;
            }
         }
         else if(PlayerManager.Instance.Self.Money < param2)
         {
            LeavePageManager.showFillFrame();
            return true;
         }
         return false;
      }
      
      private function initAlertFarme() : void
      {
         var _loc1_:* = null;
         _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _loc1_.addEventListener("response",onResponseHander);
      }
      
      private function onResponseHander(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            if(checkMoney(false,_money,_outFun))
            {
               return;
            }
            if(_outFun != null)
            {
               _outFun(false);
            }
         }
         param1.currentTarget.dispose();
      }
      
      public function SearchGoodsTempHander(param1:UpdateStarAnalyer) : void
      {
         upDateStarList = param1.itemList;
      }
      
      public function searchGoodsPayHander(param1:SearchGoodsPayAnalyer) : void
      {
         payMoneyList = param1.itemList;
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(98,16),playerEnterHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,25),playNowPositionHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,23),getGoodsHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,24),flopCardHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,32),takeCardResponseHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,33),removeEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(98,34),removeOneStepHandler);
      }
      
      private function removeEventHandler(param1:PkgEvent) : void
      {
         var _loc2_:Object = {};
         _loc2_.key = param1.pkg.readInt();
         _loc2_.value = param1.pkg.readInt();
         dispatchEvent(new BuriedEvent("buried_removeEvent",_loc2_));
      }
      
      private function removeOneStepHandler(param1:PkgEvent) : void
      {
         var _loc2_:Object = {};
         _loc2_.key = param1.pkg.readInt();
         _loc2_.value = param1.pkg.readInt();
         dispatchEvent(new BuriedEvent("buried_oneStep",_loc2_));
      }
      
      private function takeCardResponseHandler(param1:PkgEvent) : void
      {
         takeCardLimit = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Object = {};
         _loc3_.tempID = _loc4_;
         _loc3_.count = _loc2_;
         dispatchEvent(new BuriedEvent("take_card",_loc3_));
      }
      
      private function flopCardHandler(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         isOpenBuried = true;
         cardInitList = [];
         takeCardLimit = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc3_ = {};
            _loc3_.tempID = _loc5_;
            _loc3_.count = _loc2_;
            cardInitList.push(_loc3_);
            _loc6_++;
         }
      }
      
      private function getGoodsHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         currGoodID = _loc2_.readInt();
         isGetGoods = true;
      }
      
      private function playNowPositionHander(param1:PkgEvent) : void
      {
         isContinue = true;
         var _loc2_:PackageIn = param1.pkg;
         eventPosition = _loc2_.readInt();
         if(eventPosition - nowPosition == 1)
         {
            isGo = true;
         }
         else if(nowPosition - eventPosition == 1)
         {
            isBack = true;
         }
         else if(eventPosition == 0)
         {
            isBackToStart = true;
         }
         else if(eventPosition == 35)
         {
            isGoEnd = true;
         }
      }
      
      public function getBuriedStoneNum() : String
      {
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var _loc1_:int = _loc2_.getItemCountByTemplateId(11680);
         return _loc1_.toString();
      }
      
      public function setRemindRoll(param1:Boolean) : void
      {
         SharedManager.Instance.isRemindRoll = param1;
      }
      
      public function getRemindRoll() : Boolean
      {
         return SharedManager.Instance.isRemindRoll;
      }
      
      public function setRemindOverCard(param1:Boolean) : void
      {
         SharedManager.Instance.isRemindOverCard = param1;
      }
      
      public function getRemindOverCard() : Boolean
      {
         return SharedManager.Instance.isRemindOverCard;
      }
      
      public function setRemindOverBind(param1:Boolean) : void
      {
         SharedManager.Instance.isRemindOverCardBind = param1;
      }
      
      public function getRemindOverBind() : Boolean
      {
         return SharedManager.Instance.isRemindOverCardBind;
      }
      
      public function setRemindRollBind(param1:Boolean) : void
      {
         SharedManager.Instance.isRemindRollBind = param1;
      }
      
      public function getRemindRollBind() : Boolean
      {
         return SharedManager.Instance.isRemindRollBind;
      }
      
      public function dispose() : void
      {
         _outFun = null;
         currPayLevel = -1;
         _isOpening = false;
         isContinue = false;
         isGetGoods = false;
         isOpenBuried = false;
         isBuriedBox = false;
         isGo = false;
         isBack = false;
         isBackToStart = false;
         isGoEnd = false;
         isOver = false;
      }
      
      public function applyGray(param1:DisplayObject) : void
      {
         var _loc2_:Array = [];
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         applyFilter(param1,_loc2_);
      }
      
      public function reGray(param1:DisplayObject) : void
      {
         param1.filters = null;
      }
      
      private function applyFilter(param1:DisplayObject, param2:Array) : void
      {
         var _loc4_:ColorMatrixFilter = new ColorMatrixFilter(param2);
         var _loc3_:Array = [];
         _loc3_.push(_loc4_);
         param1.filters = _loc3_;
      }
      
      public function get timesReachEnd() : int
      {
         return _timesReachEnd;
      }
      
      public function get stateRewardsGained() : int
      {
         return _stateRewardsGained;
      }
      
      public function get timesBuyDice() : int
      {
         return _timesBuyDice;
      }
      
      public function set stateRewardsGained(param1:int) : void
      {
         _stateRewardsGained = param1;
      }
      
      public function set timesReachEnd(param1:int) : void
      {
         _timesReachEnd = param1;
      }
      
      public function set timesBuyDice(param1:int) : void
      {
         _timesBuyDice = param1;
      }
      
      public function get num() : int
      {
         return _num;
      }
      
      public function set num(param1:int) : void
      {
         _num = param1;
      }
   }
}
