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
      
      public function GypsyShopManager(single:inner)
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
      
      public function init($hall:HallStateView) : void
      {
         var behavior:GypsyNPCBhvr = new GypsyNPCBhvr(null);
         behavior.hallView = $hall;
         npcBehavior = behavior;
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
      
      public function isAvatarActivated(templeteID:int) : Boolean
      {
         var listMale:Array = AvatarCollectionManager.instance.maleUnitList;
         var listFemale:Array = AvatarCollectionManager.instance.femaleUnitList;
         var listWeapon:Array = AvatarCollectionManager.instance.weaponUnitList;
         var _loc16_:int = 0;
         var _loc15_:* = listMale;
         for each(var vMale in listMale)
         {
            var _loc14_:int = 0;
            var _loc13_:* = vMale.totalItemList;
            for each(var voM in vMale.totalItemList)
            {
               if(voM.itemInfo.TemplateID == templeteID)
               {
                  return voM.isActivity;
               }
            }
         }
         var _loc20_:int = 0;
         var _loc19_:* = listFemale;
         for each(var vFemale in listFemale)
         {
            var _loc18_:int = 0;
            var _loc17_:* = vFemale.totalItemList;
            for each(var voF in vFemale.totalItemList)
            {
               if(voF.itemInfo.TemplateID == templeteID)
               {
                  return voF.isActivity;
               }
            }
         }
         var _loc24_:int = 0;
         var _loc23_:* = listWeapon;
         for each(var vWeapon in listWeapon)
         {
            var _loc22_:int = 0;
            var _loc21_:* = vWeapon.totalItemList;
            for each(var voW in vWeapon.totalItemList)
            {
               if(voW.itemInfo.TemplateID == templeteID)
               {
                  return voW.isActivity;
               }
            }
         }
         var items:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         var _loc26_:int = 0;
         var _loc25_:* = items;
         for each(var item in items)
         {
            if(item.TemplateID == templeteID)
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
      
      public function itemBuyBtnClicked(id:int) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(GypsyPurchaseModel.getInstance().getUseBind() && !GypsyPurchaseModel.getInstance().isBindMoneyEnough(id))
         {
            GypsyPurchaseModel.getInstance().updateShowAlertRmbTicketBuy(true);
         }
         else if(!GypsyPurchaseModel.getInstance().getUseBind() && !GypsyPurchaseModel.getInstance().isMoneyEnough(id))
         {
            GypsyPurchaseModel.getInstance().updateShowAlertRmbTicketBuy(true);
         }
         if(GypsyPurchaseModel.getInstance().isShowRmbTicketBuyAgain())
         {
            dispatchEvent(new GypsyShopEvent("gyps_money_needed",id));
         }
         else
         {
            confirmToBuy(id);
         }
      }
      
      public function confirmToBuy(id:int) : void
      {
         _modelShop.requestBuyItem(id);
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
      
      public function set npcBehavior(value:IGypsyNPCBehavior) : void
      {
         _npcBehavior = value;
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
