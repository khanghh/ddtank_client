package firstRecharge
{
   import com.pickgliss.events.UIModuleEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.view.UIModuleSmallLoading;
   import firstRecharge.analyer.RechargeAnalyer;
   import firstRecharge.data.RechargeData;
   import firstRecharge.event.FirstRechageEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class FirstRechargeManger extends EventDispatcher
   {
      
      private static var _instance:FirstRechargeManger;
      
      public static const REMOVEFIRSTRECHARGEICON:String = "removefirstrechargeicon";
      
      public static const ADDFIRSTRECHARGEICON:String = "addfirstrechargeicon";
       
      
      private var _isOpen:Boolean;
      
      private var callback:Function;
      
      private var _isOver:Boolean;
      
      private var startTime:Date;
      
      private var endTime:Date;
      
      public var openFun:Function;
      
      public var endFun:Function;
      
      private var _goodsList:Vector.<RechargeData>;
      
      public var _goodsList_haiwai:Vector.<RechargeData>;
      
      public var rechargeMoneyTotal:int;
      
      public var rechargeGiftBagValue:int;
      
      public var rechargeEndTime:String;
      
      private var _isopen:Boolean = false;
      
      public function FirstRechargeManger()
      {
         super();
         _goodsList = new Vector.<RechargeData>();
         _goodsList_haiwai = new Vector.<RechargeData>();
      }
      
      public static function get Instance() : FirstRechargeManger
      {
         if(!_instance)
         {
            _instance = new FirstRechargeManger();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      public function completeHander(analyzer:RechargeAnalyer) : void
      {
         _goodsList = analyzer.goodsList;
         WonderfulActivityManager.Instance.updateChargeActiveTemplateXml();
      }
      
      public function getGoodsList() : Vector.<RechargeData>
      {
         return _goodsList;
      }
      
      public function getGoodsList_haiwai() : Vector.<RechargeData>
      {
         return _goodsList_haiwai;
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("cumulatecharge_open",cumlatechargeOpen);
         SocketManager.Instance.addEventListener("cumulatecharge_over",cumlatechargeOver);
         SocketManager.Instance.addEventListener("get_spree",getSpree);
         SocketManager.Instance.addEventListener("firstRecharge_open",__firstRechargeOpen);
      }
      
      public function get isopen() : Boolean
      {
         return _isopen;
      }
      
      public function set ShowIcon(value:Function) : void
      {
         callback = value;
      }
      
      private function __firstRechargeOpen(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var rechargeData:* = null;
         _goodsList_haiwai = new Vector.<RechargeData>();
         var pkg:PackageIn = e.pkg;
         var active:Boolean = pkg.readBoolean();
         if(active)
         {
            _isopen = true;
         }
         else
         {
            _isopen = false;
            dispatchEvent(new Event("removefirstrechargeicon"));
         }
         if(callback != null)
         {
            callback(_isopen);
         }
         rechargeMoneyTotal = pkg.readInt();
         rechargeGiftBagValue = pkg.readInt();
         var _rechargeGiftBagId:int = pkg.readInt();
         rechargeEndTime = pkg.readUTF();
         var _rechargeGiftBagItemNum:int = pkg.readInt();
         for(i = 0; i < _rechargeGiftBagItemNum; )
         {
            rechargeData = new RechargeData();
            rechargeData.RewardItemID = pkg.readInt();
            rechargeData.RewardItemCount = pkg.readInt();
            rechargeData.RewardItemValid = pkg.readInt();
            rechargeData.IsBind = pkg.readBoolean();
            rechargeData.StrengthenLevel = pkg.readInt();
            rechargeData.AttackCompose = pkg.readInt();
            rechargeData.DefendCompose = pkg.readInt();
            rechargeData.AgilityCompose = pkg.readInt();
            rechargeData.LuckCompose = pkg.readInt();
            _goodsList_haiwai.push(rechargeData);
            i++;
         }
         if(!_isopen)
         {
            dispatchEvent(new FirstRechageEvent("firstRechageClose"));
         }
         else
         {
            dispatchEvent(new Event("addfirstrechargeicon"));
         }
      }
      
      protected function getSpree(event:CrazyTankSocketEvent) : void
      {
      }
      
      protected function cumlatechargeOpen(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _isOpen = pkg.readBoolean();
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.firstRechargeLoader],loadRewardComplete);
         if(_isOpen)
         {
            dispatchEvent(new FirstRechageEvent("firstRechageClose"));
         }
      }
      
      private function loadRewardComplete() : void
      {
         if(openFun != null)
         {
            openFun();
         }
      }
      
      protected function cumlatechargeOver(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _isOver = pkg.readBoolean();
      }
      
      public function show() : void
      {
         dispatchEvent(new FirstRechageEvent("firstRechageOpen"));
      }
      
      private function gemstoneProgress(pEvent:UIModuleEvent) : void
      {
         if(pEvent.module == "firstRecharge")
         {
            UIModuleSmallLoading.Instance.progress = pEvent.loader.progress * 100;
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
   }
}
