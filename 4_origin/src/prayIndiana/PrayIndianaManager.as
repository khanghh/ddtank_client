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
      
      public function PrayIndianaManager(pct:PrivateClass)
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
      
      private function __pkgHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 170)
         {
            case 0:
               activityOpen(pkg);
               break;
            case 1:
               prayEnter(pkg);
               break;
            case 2:
               prayGoodsRefresh(pkg);
               break;
            case 3:
               prayExtract(pkg);
               break;
            case 4:
               prayProbabiliy(pkg);
         }
      }
      
      private function activityOpen(pkg:PackageIn = null) : void
      {
         _model.isOpen = pkg.readBoolean();
         var startT:Date = pkg.readDate();
         var endT:Date = pkg.readDate();
         var str:String = startT.getFullYear() + "/" + (startT.getMonth() + 1) + "/" + startT.getDate() + " - " + endT.getFullYear() + "/" + (endT.getMonth() + 1) + "/" + endT.getDate();
         _model.gameTimes = LanguageMgr.GetTranslation("prayIndianaMangaer.gameTimes") + str;
         _model.prayInfo = ServerConfigManager.instance.prayActivityConfig;
         showPrayIndianaIcon(_model.isOpen);
      }
      
      private function prayEnter(pkg:PackageIn) : void
      {
         var i:int = 0;
         var obj:* = null;
         var length:int = pkg.readInt();
         if(length < 1)
         {
            return;
         }
         _model.goodsAll = [];
         for(i = 0; i < length; )
         {
            obj = {};
            obj.Position = pkg.readInt();
            obj.TemplateID = pkg.readInt();
            obj.StrengthLevel = pkg.readInt();
            obj.Count = pkg.readInt();
            obj.ValidDate = pkg.readInt();
            obj.AttackCompose = pkg.readInt();
            obj.DefendCompose = pkg.readInt();
            obj.AgilityCompose = pkg.readInt();
            obj.LuckCompose = pkg.readInt();
            obj.IsBind = pkg.readBoolean();
            obj.Quality = pkg.readInt();
            obj.IsSelect = pkg.readBoolean();
            _model.goodsAll.push(obj);
            i++;
         }
         _model.probabilityNum = pkg.readInt();
         _model.PrayGoodsCount = pkg.readInt();
         _model.UpdateRateCount = pkg.readInt();
         _model.PrayLotteryGoodsCount = pkg.readInt();
         if(StateManager.currentStateType == "main" && _model.isOpen)
         {
            LoaderClass.Instance.loadUIModule(showPrayIndianaView,null,"prayIndiana");
         }
      }
      
      private function prayExtract(pkg:PackageIn) : void
      {
         _model.position = pkg.readInt();
         _model.templateID = pkg.readInt();
         _model.probabilityNum = pkg.readInt();
         _model.PrayGoodsCount = pkg.readInt();
         _model.UpdateRateCount = pkg.readInt();
         _model.PrayLotteryGoodsCount = pkg.readInt();
         dispatchEvent(new Event("updatelottery"));
      }
      
      private function prayGoodsRefresh(pkg:PackageIn) : void
      {
         var i:int = 0;
         var obj:* = null;
         var length:int = pkg.readInt();
         if(length < 1)
         {
            return;
         }
         _model.goodsAll = [];
         for(i = 0; i < length; )
         {
            obj = {};
            obj.Position = pkg.readInt();
            obj.TemplateID = pkg.readInt();
            obj.StrengthLevel = pkg.readInt();
            obj.Count = pkg.readInt();
            obj.ValidDate = pkg.readInt();
            obj.AttackCompose = pkg.readInt();
            obj.DefendCompose = pkg.readInt();
            obj.AgilityCompose = pkg.readInt();
            obj.LuckCompose = pkg.readInt();
            obj.IsBind = pkg.readBoolean();
            obj.Quality = pkg.readInt();
            obj.IsSelect = pkg.readBoolean();
            _model.goodsAll.push(obj);
            i++;
         }
         _model.probabilityNum = pkg.readInt();
         _model.PrayGoodsCount = pkg.readInt();
         _model.UpdateRateCount = pkg.readInt();
         _model.PrayLotteryGoodsCount = pkg.readInt();
         dispatchEvent(new Event("updateLotterynumber"));
         dispatchEvent(new Event("updateGoods"));
      }
      
      private function prayProbabiliy(pkg:PackageIn) : void
      {
         _model.type = pkg.readInt();
         _model.IsPray = pkg.readBoolean();
         _model.probabilityNum = pkg.readInt();
         _model.PrayGoodsCount = pkg.readInt();
         _model.UpdateRateCount = pkg.readInt();
         _model.PrayLotteryGoodsCount = pkg.readInt();
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
      
      public function showPrayIndianaIcon($isOpen:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("prayIndiana",$isOpen);
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
      
      public function set model(value:PrayIndianaModel) : void
      {
         _model = value;
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
