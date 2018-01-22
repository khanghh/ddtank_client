package prayIndiana
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import prayIndiana.model.PrayIndianaModel;
   import road7th.comm.PackageIn;
   import tool.LoaderClass;
   
   public class PrayIndianaManager extends EventDispatcher
   {
      
      private static var _instance:PrayIndianaManager;
      
      public static const UPDATEGOODS:String = "updateGoods";
      
      public static const PRAYSTART:String = "prayStart";
      
      public static const UPDATE_LOTTERYNUMBER:String = "updateLotterynumber";
      
      public static const UPDATE_LOTTERY:String = "updatelottery";
      
      public static const PRAYINDIANA_OPEN_FRAME:String = "prayindianaOpenFrame";
      
      public static const PRAYINDIANA_DISPOSE:String = "prayindianaDispose";
       
      
      private var _model:PrayIndianaModel;
      
      public var showBuyCountFram:Boolean = true;
      
      public var showBuyCountFram1:Boolean = true;
      
      public var showBuyCountFram2:Boolean = true;
      
      public var showBuyCountFram3:Boolean = true;
      
      public function PrayIndianaManager(param1:PrivateClass)
      {
         super();
      }
      
      public static function get Instance() : PrayIndianaManager
      {
         if(PrayIndianaManager._instance == null)
         {
            PrayIndianaManager._instance = new PrayIndianaManager(new PrivateClass());
         }
         return PrayIndianaManager._instance;
      }
      
      public function setup() : void
      {
         _model = new PrayIndianaModel();
         SocketManager.Instance.addEventListener("pray_indiana",__pkgHandler);
      }
      
      private function __pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 170)
         {
            case 0:
               activityOpen(_loc4_);
               break;
            case 1:
               prayEnter(_loc4_);
               break;
            case 2:
               prayGoodsRefresh(_loc4_);
               break;
            case 3:
               prayExtract(_loc4_);
               break;
            case 4:
               prayProbabiliy(_loc4_);
         }
      }
      
      private function activityOpen(param1:PackageIn = null) : void
      {
         _model.isOpen = param1.readBoolean();
         var _loc4_:Date = param1.readDate();
         var _loc2_:Date = param1.readDate();
         var _loc3_:String = _loc4_.getFullYear() + "/" + (_loc4_.getMonth() + 1) + "/" + _loc4_.getDate() + " - " + _loc2_.getFullYear() + "/" + (_loc2_.getMonth() + 1) + "/" + _loc2_.getDate();
         _model.gameTimes = LanguageMgr.GetTranslation("prayIndianaMangaer.gameTimes") + _loc3_;
         _model.prayInfo = ServerConfigManager.instance.prayActivityConfig;
         showPrayIndianaIcon(_model.isOpen);
      }
      
      private function prayEnter(param1:PackageIn) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = param1.readInt();
         if(_loc2_ < 1)
         {
            return;
         }
         _model.goodsAll = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = {};
            _loc3_.Position = param1.readInt();
            _loc3_.TemplateID = param1.readInt();
            _loc3_.StrengthLevel = param1.readInt();
            _loc3_.Count = param1.readInt();
            _loc3_.ValidDate = param1.readInt();
            _loc3_.AttackCompose = param1.readInt();
            _loc3_.DefendCompose = param1.readInt();
            _loc3_.AgilityCompose = param1.readInt();
            _loc3_.LuckCompose = param1.readInt();
            _loc3_.IsBind = param1.readBoolean();
            _loc3_.Quality = param1.readInt();
            _loc3_.IsSelect = param1.readBoolean();
            _model.goodsAll.push(_loc3_);
            _loc4_++;
         }
         _model.probabilityNum = param1.readInt();
         _model.PrayGoodsCount = param1.readInt();
         _model.UpdateRateCount = param1.readInt();
         _model.PrayLotteryGoodsCount = param1.readInt();
         if(StateManager.currentStateType == "main" && _model.isOpen)
         {
            LoaderClass.Instance.loadUIModule(showPrayIndianaView,null,"prayIndiana");
         }
      }
      
      private function prayExtract(param1:PackageIn) : void
      {
         _model.position = param1.readInt();
         _model.templateID = param1.readInt();
         _model.probabilityNum = param1.readInt();
         _model.PrayGoodsCount = param1.readInt();
         _model.UpdateRateCount = param1.readInt();
         _model.PrayLotteryGoodsCount = param1.readInt();
         dispatchEvent(new Event("updatelottery"));
      }
      
      private function prayGoodsRefresh(param1:PackageIn) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = param1.readInt();
         if(_loc2_ < 1)
         {
            return;
         }
         _model.goodsAll = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = {};
            _loc3_.Position = param1.readInt();
            _loc3_.TemplateID = param1.readInt();
            _loc3_.StrengthLevel = param1.readInt();
            _loc3_.Count = param1.readInt();
            _loc3_.ValidDate = param1.readInt();
            _loc3_.AttackCompose = param1.readInt();
            _loc3_.DefendCompose = param1.readInt();
            _loc3_.AgilityCompose = param1.readInt();
            _loc3_.LuckCompose = param1.readInt();
            _loc3_.IsBind = param1.readBoolean();
            _loc3_.Quality = param1.readInt();
            _loc3_.IsSelect = param1.readBoolean();
            _model.goodsAll.push(_loc3_);
            _loc4_++;
         }
         _model.probabilityNum = param1.readInt();
         _model.PrayGoodsCount = param1.readInt();
         _model.UpdateRateCount = param1.readInt();
         _model.PrayLotteryGoodsCount = param1.readInt();
         dispatchEvent(new Event("updateLotterynumber"));
         dispatchEvent(new Event("updateGoods"));
      }
      
      private function prayProbabiliy(param1:PackageIn) : void
      {
         _model.type = param1.readInt();
         _model.IsPray = param1.readBoolean();
         _model.probabilityNum = param1.readInt();
         _model.PrayGoodsCount = param1.readInt();
         _model.UpdateRateCount = param1.readInt();
         _model.PrayLotteryGoodsCount = param1.readInt();
         if(_model.IsPray == true)
         {
            if(_model.type == 1)
            {
               dispatchEvent(new Event("prayStart"));
            }
            dispatchEvent(new Event("updateLotterynumber"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("PrayIndianaMangaer.MoneyTip"));
         }
      }
      
      public function showPrayIndianaIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("prayIndiana",param1);
         dispatchEvent(new Event("prayindianaDispose"));
      }
      
      public function onClickIcon() : void
      {
         SocketManager.Instance.out.prayIndianaEnter();
      }
      
      private function showPrayIndianaView() : void
      {
         dispatchEvent(new Event("prayindianaOpenFrame"));
      }
      
      public function get isOpen() : Boolean
      {
         return _model == null?false:Boolean(_model.isOpen);
      }
      
      public function get model() : PrayIndianaModel
      {
         return _model;
      }
      
      public function set model(param1:PrayIndianaModel) : void
      {
         _model = param1;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
