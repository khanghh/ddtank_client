package gypsyShop.ctrl
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import gypsyShop.GypsyShopEvent;
   import gypsyShop.model.GypsyShopModel;
   import gypsyShop.npcBehavior.IGypsyNPCBehavior;
   import gypsyShop.ui.ConfirmFrameHonourNeeded;
   import gypsyShop.ui.ConfirmFrameMoneyNeeded;
   import gypsyShop.view.GypsyShopMainFrame;
   import gypsyShop.view.GypsyUILoader;
   import magicStone.components.MagicStoneConfirmView;
   
   public class GypsyShopController
   {
      
      private static var instance:GypsyShopController;
       
      
      private var _mainFrameGypsy:GypsyShopMainFrame;
      
      private var _npcBehavior:IGypsyNPCBehavior;
      
      private var _modelShop:GypsyShopModel;
      
      private var _manager:GypsyShopManager;
      
      public function GypsyShopController(param1:inner)
      {
         super();
         _manager = GypsyShopManager.getInstance();
      }
      
      public static function getInstance() : GypsyShopController
      {
         if(!instance)
         {
            instance = new GypsyShopController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         addEvents();
      }
      
      private function addEvents() : void
      {
         _manager.addEventListener("gyps_buy_result",onEventHandler);
         _manager.addEventListener("gyps_hide_main",onEventHandler);
         _manager.addEventListener("gyps_honour_needed",onEventHandler);
         _manager.addEventListener("gyps_rmb_needed",onEventHandler);
         _manager.addEventListener("gyps_money_needed",onEventHandler);
         _manager.addEventListener("gyps_item_list_update",onEventHandler);
         _manager.addEventListener("gyps_rare_update",onEventHandler);
         _manager.addEventListener("gyps_show_main",onEventHandler);
      }
      
      protected function onEventHandler(param1:GypsyShopEvent) : void
      {
         var _loc2_:* = param1.type;
         if("gyps_buy_result" !== _loc2_)
         {
            if("gyps_hide_main" !== _loc2_)
            {
               if("gyps_honour_needed" !== _loc2_)
               {
                  if("gyps_rmb_needed" !== _loc2_)
                  {
                     if("gyps_money_needed" !== _loc2_)
                     {
                        if("gyps_item_list_update" !== _loc2_)
                        {
                           if("gyps_rare_update" !== _loc2_)
                           {
                              if("gyps_show_main" === _loc2_)
                              {
                                 _modelShop = param1.data as GypsyShopModel;
                                 showMainFrame();
                              }
                           }
                           else
                           {
                              newRareItemsUpdate();
                           }
                        }
                        else
                        {
                           newItemListUpdate();
                        }
                     }
                     else
                     {
                        moneyNeeded(int(param1.data));
                     }
                  }
                  else
                  {
                     rmbNeeded();
                  }
               }
               else
               {
                  honourNeeded();
               }
            }
            else
            {
               hideMainFrame();
            }
         }
         else
         {
            updateBuyResult();
         }
      }
      
      public function showMainFrame() : void
      {
         new GypsyUILoader().loadUIModule("gypsy",["gypsyShop","ddtbagandinfo"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _mainFrameGypsy = ComponentFactory.Instance.creatComponentByStylename("gypsy.mainframe");
         _mainFrameGypsy.setModel(_modelShop);
         _modelShop.init();
         _modelShop.requestRareList();
         _modelShop.requestRefreshList();
         LayerManager.Instance.addToLayer(_mainFrameGypsy,3,true,1);
      }
      
      public function hideMainFrame() : void
      {
         if(_mainFrameGypsy != null)
         {
            ObjectUtils.disposeObject(_mainFrameGypsy);
            _mainFrameGypsy = null;
            _modelShop.dispose();
         }
      }
      
      public function newRareItemsUpdate() : void
      {
         _mainFrameGypsy.updateRareItemsList();
      }
      
      public function newItemListUpdate() : void
      {
         _mainFrameGypsy.updateNewItemList();
      }
      
      public function updateBuyResult() : void
      {
         _mainFrameGypsy.updateBuyResult();
      }
      
      private function moneyNeeded(param1:int) : void
      {
         var _loc2_:ConfirmFrameMoneyNeeded = new ConfirmFrameMoneyNeeded();
         _loc2_.setID(param1);
         _loc2_.alert();
      }
      
      private function honourNeeded() : void
      {
         new ConfirmFrameHonourNeeded().alert();
      }
      
      private function rmbNeeded() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(GypsyShopManager.getInstance().showRmbRefreshAlertAgain == false)
         {
            _loc2_ = 300;
            if(GypsyShopModel.getInstance().isBind && PlayerManager.Instance.Self.BandMoney < _loc2_)
            {
               _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc1_.moveEnable = false;
               _loc1_.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!GypsyShopModel.getInstance().isBind && PlayerManager.Instance.Self.Money < _loc2_)
            {
               GypsyShopManager.getInstance().showRmbRefreshAlertAgain = true;
               LeavePageManager.showFillFrame();
               return;
            }
            GypsyShopManager.getInstance().confirmToRefreshWithRMB();
            return;
         }
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRmbConfirm",300),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"gypsy.rmb.confirmView",30,true,0);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",comfirmHandler,false,0,true);
      }
      
      private function comfirmHandler(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",comfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc3_ = 300;
            if(_loc4_.isBand && PlayerManager.Instance.Self.BandMoney < _loc3_)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!_loc4_.isBand && PlayerManager.Instance.Self.Money < _loc3_)
            {
               GypsyShopManager.getInstance().showRmbRefreshAlertAgain = true;
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc4_ as MagicStoneConfirmView).isNoPrompt)
            {
               GypsyShopManager.getInstance().showRmbRefreshAlertAgain = false;
            }
            GypsyShopModel.getInstance().isBind = (_loc4_ as MagicStoneConfirmView).isBand;
            GypsyShopManager.getInstance().confirmToRefreshWithRMB();
         }
      }
      
      private function reConfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",reConfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = 300;
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            GypsyShopModel.getInstance().isBind = false;
            GypsyShopManager.getInstance().confirmToRefreshWithRMB();
         }
      }
      
      public function dispose() : void
      {
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
