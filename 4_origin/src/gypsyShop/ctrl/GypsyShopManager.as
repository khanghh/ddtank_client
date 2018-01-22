package gypsyShop.ctrl
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionItemVo;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import baglocked.BaglockedManager;
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelperDataModuleLoad;
   import gypsyShop.GypsyShopEvent;
   import gypsyShop.model.GypsyNPCModel;
   import gypsyShop.model.GypsyPurchaseModel;
   import gypsyShop.model.GypsyShopModel;
   import gypsyShop.npcBehavior.GypsyNPCAdapter;
   import gypsyShop.npcBehavior.GypsyNPCBhvr;
   import gypsyShop.npcBehavior.IGypsyNPCBehavior;
   import hall.HallStateView;
   import road7th.data.DictionaryData;
   
   public class GypsyShopManager extends CoreManager
   {
      
      private static var instance:GypsyShopManager;
       
      
      public var showRmbRefreshAlertAgain:Boolean = true;
      
      private var _npcBehavior:IGypsyNPCBehavior;
      
      private var _modelShop:GypsyShopModel;
      
      private var _gypsyShopFrameIsShowing:Boolean;
      
      public function GypsyShopManager(param1:inner)
      {
         super();
         _npcBehavior = new GypsyNPCAdapter(null);
      }
      
      public static function getInstance() : GypsyShopManager
      {
         if(!instance)
         {
            instance = new GypsyShopManager(new inner());
         }
         return instance;
      }
      
      public function init(param1:HallStateView) : void
      {
         var _loc2_:GypsyNPCBhvr = new GypsyNPCBhvr(null);
         _loc2_.hallView = param1;
         npcBehavior = _loc2_;
      }
      
      public function setup() : void
      {
         GypsyNPCModel.getInstance().init();
         _modelShop = GypsyShopModel.getInstance();
      }
      
      override protected function start() : void
      {
         showMainFrame();
      }
      
      public function showMainFrame() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createAvatarCollectionUnitDataLoader(),LoaderCreate.Instance.createHorsePicCherishDataLoader()],showGypsyShopFrame);
      }
      
      private function showGypsyShopFrame() : void
      {
         dispatchEvent(new GypsyShopEvent("gyps_show_main",_modelShop));
         _gypsyShopFrameIsShowing = true;
      }
      
      public function isAvatarActivated(param1:int) : Boolean
      {
         var _loc3_:Array = AvatarCollectionManager.instance.maleUnitList;
         var _loc10_:Array = AvatarCollectionManager.instance.femaleUnitList;
         var _loc11_:Array = AvatarCollectionManager.instance.weaponUnitList;
         var _loc16_:int = 0;
         var _loc15_:* = _loc3_;
         for each(var _loc8_ in _loc3_)
         {
            var _loc14_:int = 0;
            var _loc13_:* = _loc8_.totalItemList;
            for each(var _loc2_ in _loc8_.totalItemList)
            {
               if(_loc2_.itemInfo.TemplateID == param1)
               {
                  return _loc2_.isActivity;
               }
            }
         }
         var _loc20_:int = 0;
         var _loc19_:* = _loc10_;
         for each(var _loc6_ in _loc10_)
         {
            var _loc18_:int = 0;
            var _loc17_:* = _loc6_.totalItemList;
            for each(var _loc9_ in _loc6_.totalItemList)
            {
               if(_loc9_.itemInfo.TemplateID == param1)
               {
                  return _loc9_.isActivity;
               }
            }
         }
         var _loc24_:int = 0;
         var _loc23_:* = _loc11_;
         for each(var _loc12_ in _loc11_)
         {
            var _loc22_:int = 0;
            var _loc21_:* = _loc12_.totalItemList;
            for each(var _loc7_ in _loc12_.totalItemList)
            {
               if(_loc7_.itemInfo.TemplateID == param1)
               {
                  return _loc7_.isActivity;
               }
            }
         }
         var _loc4_:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         var _loc26_:int = 0;
         var _loc25_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            if(_loc5_.TemplateID == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hideMainFrame() : void
      {
         _gypsyShopFrameIsShowing = false;
         dispatchEvent(new GypsyShopEvent("gyps_hide_main"));
      }
      
      public function refreshNPC() : void
      {
         GypsyNPCModel.getInstance().refreshNPCState();
      }
      
      public function showNPC() : void
      {
         trace("show npc");
         _npcBehavior.show();
      }
      
      public function hideNPC() : void
      {
         trace("hide npc");
         _npcBehavior.hide();
      }
      
      public function disposeNPC() : void
      {
         GypsyNPCModel.getInstance().dispose();
         _npcBehavior.dispose();
      }
      
      public function newRareItemsUpdate() : void
      {
         dispatchEvent(new GypsyShopEvent("gyps_rare_update"));
      }
      
      public function newItemListUpdate() : void
      {
         dispatchEvent(new GypsyShopEvent("gyps_item_list_update"));
      }
      
      public function updateBuyResult() : void
      {
         dispatchEvent(new GypsyShopEvent("gyps_buy_result"));
      }
      
      public function itemBuyBtnClicked(param1:int) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(GypsyPurchaseModel.getInstance().getUseBind() && !GypsyPurchaseModel.getInstance().isBindMoneyEnough(param1))
         {
            GypsyPurchaseModel.getInstance().updateShowAlertRmbTicketBuy(true);
         }
         else if(!GypsyPurchaseModel.getInstance().getUseBind() && !GypsyPurchaseModel.getInstance().isMoneyEnough(param1))
         {
            GypsyPurchaseModel.getInstance().updateShowAlertRmbTicketBuy(true);
         }
         if(GypsyPurchaseModel.getInstance().isShowRmbTicketBuyAgain())
         {
            dispatchEvent(new GypsyShopEvent("gyps_money_needed",param1));
         }
         else
         {
            confirmToBuy(param1);
         }
      }
      
      public function confirmToBuy(param1:int) : void
      {
         _modelShop.requestBuyItem(param1);
      }
      
      public function refreshBtnClicked() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!GypsyPurchaseModel.getInstance().isHonourEnough())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("gypsy.honourNotEnough"),0,true,3);
         }
         else if(GypsyPurchaseModel.getInstance().isShowHonourRefreshAgain())
         {
            dispatchEvent(new GypsyShopEvent("gyps_honour_needed"));
         }
         else
         {
            confirmToRefresh();
         }
      }
      
      public function confirmToRefresh() : void
      {
         _modelShop.requestManualRefreshList();
      }
      
      public function refreshWithRmbBtnClicked() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!GypsyPurchaseModel.getInstance().isRefreshRmbEnough())
         {
            LeavePageManager.showFillFrame();
         }
         else if(GypsyPurchaseModel.getInstance().isShowRMBRefreshAgain())
         {
            dispatchEvent(new GypsyShopEvent("gyps_rmb_needed"));
         }
         else
         {
            confirmToRefreshWithRMB();
         }
      }
      
      public function confirmToRefreshWithRMB() : void
      {
         _modelShop.requestManualRefreshListWithRMB();
      }
      
      public function dispose() : void
      {
         _modelShop && _modelShop.dispose();
         GypsyNPCModel.getInstance().dispose();
         _npcBehavior.dispose();
      }
      
      public function set npcBehavior(param1:IGypsyNPCBehavior) : void
      {
         _npcBehavior = param1;
      }
      
      public function get npcBehavior() : IGypsyNPCBehavior
      {
         return _npcBehavior;
      }
      
      public function get gypsyShopFrameIsShowing() : Boolean
      {
         return _gypsyShopFrameIsShowing;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
