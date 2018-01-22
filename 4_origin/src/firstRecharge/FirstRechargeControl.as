package firstRecharge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import firstRecharge.data.RechargeData;
   import firstRecharge.event.FirstRechageEvent;
   import firstRecharge.view.AccumulationView;
   import firstRecharge.view.FirstTouchView;
   import road7th.comm.PackageIn;
   
   public class FirstRechargeControl
   {
      
      private static var _instance:FirstRechargeControl;
       
      
      private var _isShowFirst:Boolean;
      
      private var _firstTouchView:FirstTouchView;
      
      private var _accumulationView:AccumulationView;
      
      public function FirstRechargeControl()
      {
         super();
      }
      
      public static function get Instance() : FirstRechargeControl
      {
         if(!_instance)
         {
            _instance = new FirstRechargeControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         FirstRechargeManger.Instance.addEventListener("firstRechageOpen",__onOpenView);
         FirstRechargeManger.Instance.addEventListener("firstRechageClose",__onCloseView);
         SocketManager.Instance.addEventListener("cumulatecharge_data",cumlatechargeData);
      }
      
      protected function __onOpenView(param1:FirstRechageEvent) : void
      {
         showView();
      }
      
      protected function __onCloseView(param1:FirstRechageEvent) : void
      {
         closeView();
      }
      
      protected function cumlatechargeData(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = {};
            _loc4_.userId = _loc3_.readInt();
            _loc5_ = _loc3_.readInt();
            _loc4_.chargeMoney = _loc3_.readInt();
            _loc6_++;
         }
         if(_loc5_ == 1)
         {
            _isShowFirst = true;
         }
         else
         {
            _isShowFirst = false;
         }
      }
      
      private function closeView() : void
      {
         if(_firstTouchView)
         {
            ObjectUtils.disposeObject(_firstTouchView);
            _firstTouchView = null;
         }
      }
      
      private function showView() : void
      {
         _isShowFirst = true;
         if(_isShowFirst)
         {
            if(!_firstTouchView)
            {
               AssetModuleLoader.addModelLoader("firstRecharge",6);
               AssetModuleLoader.startCodeLoader(gemstoneCompHander);
            }
            else
            {
               _firstTouchView = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.firstView");
               _firstTouchView.setGoodsList(FirstRechargeManger.Instance.getGoodsList_haiwai());
               LayerManager.Instance.addToLayer(_firstTouchView,3,true,1);
            }
         }
         else if(!_accumulationView)
         {
            AssetModuleLoader.addModelLoader("firstRecharge",6);
            AssetModuleLoader.startCodeLoader(gemstoneCompHander);
         }
         else
         {
            _accumulationView = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.accumulationView");
            LayerManager.Instance.addToLayer(_accumulationView,3,true);
         }
      }
      
      private function gemstoneCompHander() : void
      {
         if(_isShowFirst)
         {
            if(_firstTouchView == null)
            {
               _firstTouchView = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.firstView");
               _firstTouchView.setGoodsList(FirstRechargeManger.Instance.getGoodsList_haiwai());
               LayerManager.Instance.addToLayer(_firstTouchView,3,true,2);
            }
         }
         else if(_accumulationView == null)
         {
            _accumulationView = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.accumulationView");
            LayerManager.Instance.addToLayer(_accumulationView,3,true);
         }
      }
      
      public function setGoods(param1:RechargeData) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1.RewardItemID;
         _loc2_.StrengthenLevel = param1.StrengthenLevel;
         _loc2_.AgilityCompose = param1.AgilityCompose;
         _loc2_.AttackCompose = param1.AttackCompose;
         _loc2_.LuckCompose = param1.LuckCompose;
         _loc2_.DefendCompose = param1.DefendCompose;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.CanCompose = false;
         _loc2_.CanStrengthen = false;
         _loc2_.ValidDate = param1.RewardItemValid;
         _loc2_.BindType = 4;
         return _loc2_;
      }
   }
}
