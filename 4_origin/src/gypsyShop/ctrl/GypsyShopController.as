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
      
      public function GypsyShopController(single:inner)
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
      
      protected function onEventHandler(e:GypsyShopEvent) : void
      {
         var _loc2_:* = e.type;
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
                                 _modelShop = e.data as GypsyShopModel;
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
                        moneyNeeded(int(e.data));
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
      
      private function moneyNeeded(id:int) : void
      {
         var confirmFrame:ConfirmFrameMoneyNeeded = new ConfirmFrameMoneyNeeded();
         confirmFrame.setID(id);
         confirmFrame.alert();
      }
      
      private function honourNeeded() : void
      {
         new ConfirmFrameHonourNeeded().alert();
      }
      
      private function rmbNeeded() : void
      {
         var tmpNeedMoney:int = 0;
         var confirmFrame2:* = null;
         if(GypsyShopManager.getInstance().showRmbRefreshAlertAgain == false)
         {
            tmpNeedMoney = 300;
            if(GypsyShopModel.getInstance().isBind && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!GypsyShopModel.getInstance().isBind && PlayerManager.Instance.Self.Money < tmpNeedMoney)
            {
               GypsyShopManager.getInstance().showRmbRefreshAlertAgain = true;
               LeavePageManager.showFillFrame();
               return;
            }
            GypsyShopManager.getInstance().confirmToRefreshWithRMB();
            return;
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRmbConfirm",300),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"gypsy.rmb.confirmView",30,true,0);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",comfirmHandler,false,0,true);
      }
      
      private function comfirmHandler(event:FrameEvent) : void
      {
         var tmpNeedMoney:int = 0;
         var confirmFrame2:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",comfirmHandler);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            tmpNeedMoney = 300;
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
            {
               GypsyShopManager.getInstance().showRmbRefreshAlertAgain = true;
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as MagicStoneConfirmView).isNoPrompt)
            {
               GypsyShopManager.getInstance().showRmbRefreshAlertAgain = false;
            }
            GypsyShopModel.getInstance().isBind = (confirmFrame as MagicStoneConfirmView).isBand;
            GypsyShopManager.getInstance().confirmToRefreshWithRMB();
         }
      }
      
      private function reConfirmHandler(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",reConfirmHandler);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needMoney = 300;
            if(PlayerManager.Instance.Self.Money < needMoney)
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
