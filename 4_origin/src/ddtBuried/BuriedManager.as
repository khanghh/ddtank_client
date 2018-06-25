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
      
      public function set isOpening(bool:Boolean) : void
      {
         _isOpening = bool;
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
      
      private function playerEnterHander(e:PkgEvent) : void
      {
         var i:int = 0;
         var data:* = null;
         serverConfigInfo = ServerConfigManager.instance.serverConfigInfo["SearchGoodsFreeCount"];
         cardPayinfo = ServerConfigManager.instance.serverConfigInfo["SearchGoodsTakeCardMoney"];
         takeCardPayList = cardPayinfo.Value.split("|");
         pay_count = payMoneyList.length;
         totol_count = pay_count + int(serverConfigInfo.Value);
         dispose();
         mapdataList = new Vector.<MapItemData>();
         var pkg:PackageIn = e.pkg;
         mapID = pkg.readInt();
         level = pkg.readInt();
         nowPosition = pkg.readInt();
         _num = pkg.readInt();
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
         var count:int = pkg.readInt();
         if(count == 0)
         {
            return;
         }
         for(i = 0; i < count; )
         {
            data = new MapItemData();
            data.type = pkg.readInt();
            data.tempID = pkg.readInt();
            mapdataList.push(data);
            i++;
         }
         timesReachEnd = pkg.readInt();
         stateRewardsGained = pkg.readInt();
         timesBuyDice = pkg.readInt();
         dispatchEvent(new BuriedEvent("buriedOpenView"));
      }
      
      private function loadComplete() : void
      {
         SocketManager.Instance.out.enterBuried();
      }
      
      public function checkMoney(bool:Boolean, money:int, fun:Function = null) : Boolean
      {
         _money = money;
         _outFun = fun;
         if(bool)
         {
            if(PlayerManager.Instance.Self.BandMoney < money)
            {
               if(fun != null)
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
         else if(PlayerManager.Instance.Self.Money < money)
         {
            LeavePageManager.showFillFrame();
            return true;
         }
         return false;
      }
      
      private function initAlertFarme() : void
      {
         var frame:* = null;
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("buried.alertInfo.noBindMoney"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         frame.addEventListener("response",onResponseHander);
      }
      
      private function onResponseHander(e:FrameEvent) : void
      {
         if(e.responseCode == 2 || e.responseCode == 3)
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
         e.currentTarget.dispose();
      }
      
      public function SearchGoodsTempHander(analyer:UpdateStarAnalyer) : void
      {
         upDateStarList = analyer.itemList;
      }
      
      public function searchGoodsPayHander(analyzer:SearchGoodsPayAnalyer) : void
      {
         payMoneyList = analyzer.itemList;
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
      
      private function removeEventHandler(e:PkgEvent) : void
      {
         var obj:Object = {};
         obj.key = e.pkg.readInt();
         obj.value = e.pkg.readInt();
         dispatchEvent(new BuriedEvent("buried_removeEvent",obj));
      }
      
      private function removeOneStepHandler(e:PkgEvent) : void
      {
         var obj:Object = {};
         obj.key = e.pkg.readInt();
         obj.value = e.pkg.readInt();
         dispatchEvent(new BuriedEvent("buried_oneStep",obj));
      }
      
      private function takeCardResponseHandler(e:PkgEvent) : void
      {
         takeCardLimit = e.pkg.readInt();
         var tempID:int = e.pkg.readInt();
         var count:int = e.pkg.readInt();
         var obj:Object = {};
         obj.tempID = tempID;
         obj.count = count;
         dispatchEvent(new BuriedEvent("take_card",obj));
      }
      
      private function flopCardHandler(e:PkgEvent) : void
      {
         var i:int = 0;
         var tempID:int = 0;
         var count:int = 0;
         var obj:* = null;
         isOpenBuried = true;
         cardInitList = [];
         takeCardLimit = e.pkg.readInt();
         var conut:int = e.pkg.readInt();
         for(i = 0; i < conut; )
         {
            tempID = e.pkg.readInt();
            count = e.pkg.readInt();
            obj = {};
            obj.tempID = tempID;
            obj.count = count;
            cardInitList.push(obj);
            i++;
         }
      }
      
      private function getGoodsHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         currGoodID = pkg.readInt();
         isGetGoods = true;
      }
      
      private function playNowPositionHander(e:PkgEvent) : void
      {
         isContinue = true;
         var pkg:PackageIn = e.pkg;
         eventPosition = pkg.readInt();
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
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var num:int = bagInfo.getItemCountByTemplateId(11680);
         return num.toString();
      }
      
      public function setRemindRoll(bool:Boolean) : void
      {
         SharedManager.Instance.isRemindRoll = bool;
      }
      
      public function getRemindRoll() : Boolean
      {
         return SharedManager.Instance.isRemindRoll;
      }
      
      public function setRemindOverCard(bool:Boolean) : void
      {
         SharedManager.Instance.isRemindOverCard = bool;
      }
      
      public function getRemindOverCard() : Boolean
      {
         return SharedManager.Instance.isRemindOverCard;
      }
      
      public function setRemindOverBind(bool:Boolean) : void
      {
         SharedManager.Instance.isRemindOverCardBind = bool;
      }
      
      public function getRemindOverBind() : Boolean
      {
         return SharedManager.Instance.isRemindOverCardBind;
      }
      
      public function setRemindRollBind(bool:Boolean) : void
      {
         SharedManager.Instance.isRemindRollBind = bool;
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
      
      public function applyGray(child:DisplayObject) : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0,0,0,1,0]);
         applyFilter(child,matrix);
      }
      
      public function reGray(child:DisplayObject) : void
      {
         child.filters = null;
      }
      
      private function applyFilter(child:DisplayObject, matrix:Array) : void
      {
         var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
         var filters:Array = [];
         filters.push(filter);
         child.filters = filters;
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
      
      public function set stateRewardsGained(value:int) : void
      {
         _stateRewardsGained = value;
      }
      
      public function set timesReachEnd(value:int) : void
      {
         _timesReachEnd = value;
      }
      
      public function set timesBuyDice(value:int) : void
      {
         _timesBuyDice = value;
      }
      
      public function get num() : int
      {
         return _num;
      }
      
      public function set num(value:int) : void
      {
         _num = value;
      }
   }
}
