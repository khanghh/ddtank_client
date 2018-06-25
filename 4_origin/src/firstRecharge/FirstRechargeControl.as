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
      
      protected function __onOpenView(event:FirstRechageEvent) : void
      {
         showView();
      }
      
      protected function __onCloseView(event:FirstRechageEvent) : void
      {
         closeView();
      }
      
      protected function cumlatechargeData(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var type:int = 0;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            obj = {};
            obj.userId = pkg.readInt();
            type = pkg.readInt();
            obj.chargeMoney = pkg.readInt();
            i++;
         }
         if(type == 1)
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
      
      public function setGoods(data:RechargeData) : InventoryItemInfo
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = data.RewardItemID;
         info.StrengthenLevel = data.StrengthenLevel;
         info.AgilityCompose = data.AgilityCompose;
         info.AttackCompose = data.AttackCompose;
         info.LuckCompose = data.LuckCompose;
         info.DefendCompose = data.DefendCompose;
         info = ItemManager.fill(info);
         info.CanCompose = false;
         info.CanStrengthen = false;
         info.ValidDate = data.RewardItemValid;
         info.BindType = 4;
         return info;
      }
   }
}
