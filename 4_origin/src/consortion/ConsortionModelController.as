package consortion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.rank.RankFrame;
   import consortion.view.boss.ConsortiaBossFrame;
   import consortion.view.selfConsortia.ConsortionBankFrame;
   import consortion.view.selfConsortia.ConsortionQuitFrame;
   import consortion.view.selfConsortia.ConsortionShopFrame;
   import consortion.view.selfConsortia.EstablishmentFrame;
   import consortion.view.selfConsortia.ManagerFrame;
   import consortion.view.selfConsortia.TakeInMemberFrame;
   import consortion.view.selfConsortia.TaxFrame;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.utils.HelperDataModuleLoad;
   import flash.events.EventDispatcher;
   
   public class ConsortionModelController extends EventDispatcher
   {
      
      private static var _instance:ConsortionModelController;
       
      
      private var _manager:ConsortionModelManager;
      
      private var _consortionBankFrame:ConsortionBankFrame;
      
      public var isClickConsortionBuyGiftTask:Boolean;
      
      public function ConsortionModelController()
      {
         super();
      }
      
      public static function get Instance() : ConsortionModelController
      {
         if(_instance == null)
         {
            _instance = new ConsortionModelController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _manager = ConsortionModelManager.Instance;
         addEvent();
      }
      
      private function addEvent() : void
      {
         _manager.addEventListener("cmctrl_alert_tax",onEventsHandler);
         _manager.addEventListener("cmctrl_alert_manager",onEventsHandler);
         _manager.addEventListener("cmctrl_rank",onEventsHandler);
         _manager.addEventListener("cmctrl_alert_shop",onEventsHandler);
         _manager.addEventListener("cmctrl_alert_bank",onEventsHandler);
         _manager.addEventListener("cmctrl_alert_takein",onEventsHandler);
         _manager.addEventListener("cmctrl_alert_quit",onEventsHandler);
         _manager.addEventListener("cmctrl_open_boss",onEventsHandler);
         _manager.addEventListener("cmctrl_hide_bank",onEventsHandler);
         _manager.addEventListener("cmctrl_clear_reference",onEventsHandler);
      }
      
      private function onEventsHandler(param1:CEvent) : void
      {
         var _loc2_:* = param1.type;
         if("cmctrl_alert_tax" !== _loc2_)
         {
            if("cmctrl_alert_manager" !== _loc2_)
            {
               if("cmctrl_rank" !== _loc2_)
               {
                  if("cmctrl_alert_shop" !== _loc2_)
                  {
                     if("cmctrl_alert_bank" !== _loc2_)
                     {
                        if("cmctrl_alert_takein" !== _loc2_)
                        {
                           if("cmctrl_alert_quit" !== _loc2_)
                           {
                              if("cmctrl_open_boss" !== _loc2_)
                              {
                                 if("cmctrl_hide_bank" !== _loc2_)
                                 {
                                    if("cmctrl_clear_reference" === _loc2_)
                                    {
                                       clearReference();
                                    }
                                 }
                                 else
                                 {
                                    hideBankFrame();
                                 }
                              }
                              else
                              {
                                 openBossFrame();
                              }
                           }
                           else
                           {
                              alertQuitFrame();
                           }
                        }
                        else
                        {
                           alertTakeInFrame();
                        }
                     }
                     else
                     {
                        alertBankFrame();
                     }
                  }
                  else
                  {
                     alertShopFrame();
                  }
               }
               else
               {
                  rankFrame();
               }
            }
            else
            {
               alertManagerFrame();
            }
         }
         else
         {
            alertTaxFrame();
         }
      }
      
      public function alertTaxFrame() : void
      {
         var _loc1_:TaxFrame = ComponentFactory.Instance.creatComponentByStylename("taxFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function alertEstablishmentFrame() : void
      {
         var _loc1_:EstablishmentFrame = ComponentFactory.Instance.creatComponentByStylename("establishmentFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function alertManagerFrame() : void
      {
         var _loc1_:ManagerFrame = ComponentFactory.Instance.creatComponentByStylename("core.ConsortiaAssetManagerFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function rankFrame() : void
      {
         var _loc1_:RankFrame = ComponentFactory.Instance.creatComponentByStylename("consortion.rank.RankFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function alertShopFrame() : void
      {
         var _loc1_:ConsortionShopFrame = ComponentFactory.Instance.creatComponentByStylename("consortionShopFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function alertBankFrame() : void
      {
         _consortionBankFrame = ComponentFactory.Instance.creatComponentByStylename("consortionBankFrame");
         LayerManager.Instance.addToLayer(_consortionBankFrame,3,true,1);
      }
      
      public function hideBankFrame() : void
      {
         ObjectUtils.disposeObject(_consortionBankFrame);
         _consortionBankFrame = null;
      }
      
      public function clearReference() : void
      {
         _consortionBankFrame = null;
      }
      
      public function alertTakeInFrame() : void
      {
         var _loc1_:TakeInMemberFrame = ComponentFactory.Instance.creatComponentByStylename("takeInMemberFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function alertQuitFrame() : void
      {
         var _loc1_:ConsortionQuitFrame = ComponentFactory.Instance.creatComponentByStylename("consortionQuitFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function openBossFrame() : void
      {
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createConsortiaBossTemplateLoader],function():void
            {
               var _loc1_:ConsortiaBossFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.boss.frame");
               LayerManager.Instance.addToLayer(_loc1_,3,true,1);
            });
         }
      }
   }
}
