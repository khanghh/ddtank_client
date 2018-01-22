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
      
      public function completeHander(param1:RechargeAnalyer) : void
      {
         _goodsList = param1.goodsList;
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
      
      public function set ShowIcon(param1:Function) : void
      {
         callback = param1;
      }
      
      private function __firstRechargeOpen(param1:CrazyTankSocketEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         _goodsList_haiwai = new Vector.<RechargeData>();
         var _loc6_:PackageIn = param1.pkg;
         var _loc5_:Boolean = _loc6_.readBoolean();
         if(_loc5_)
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
         rechargeMoneyTotal = _loc6_.readInt();
         rechargeGiftBagValue = _loc6_.readInt();
         var _loc4_:int = _loc6_.readInt();
         rechargeEndTime = _loc6_.readUTF();
         var _loc3_:int = _loc6_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc2_ = new RechargeData();
            _loc2_.RewardItemID = _loc6_.readInt();
            _loc2_.RewardItemCount = _loc6_.readInt();
            _loc2_.RewardItemValid = _loc6_.readInt();
            _loc2_.IsBind = _loc6_.readBoolean();
            _loc2_.StrengthenLevel = _loc6_.readInt();
            _loc2_.AttackCompose = _loc6_.readInt();
            _loc2_.DefendCompose = _loc6_.readInt();
            _loc2_.AgilityCompose = _loc6_.readInt();
            _loc2_.LuckCompose = _loc6_.readInt();
            _goodsList_haiwai.push(_loc2_);
            _loc7_++;
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
      
      protected function getSpree(param1:CrazyTankSocketEvent) : void
      {
      }
      
      protected function cumlatechargeOpen(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _isOpen = _loc2_.readBoolean();
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
      
      protected function cumlatechargeOver(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _isOver = _loc2_.readBoolean();
      }
      
      public function show() : void
      {
         dispatchEvent(new FirstRechageEvent("firstRechageOpen"));
      }
      
      private function gemstoneProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "firstRecharge")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
   }
}
