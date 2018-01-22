package petsBag
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import flash.events.EventDispatcher;
   import petsBag.cmd.CmdShowPetFoodNumberSelectFrame;
   import petsBag.event.UpdatePetInfoEvent;
   import petsBag.petsAdvanced.PetsFormItemsTip;
   import petsBag.view.AdoptPetsGuideView;
   import petsBag.view.AdoptPetsView;
   import petsBag.view.PetsView;
   import petsBag.view.item.PetGrowUpTip;
   import petsBag.view.item.PetHappyTip;
   import petsBag.view.item.PetTip;
   
   public class PetsBagControl extends EventDispatcher
   {
      
      private static var _instance:PetsBagControl;
       
      
      private var _petView:PetsView;
      
      public function PetsBagControl()
      {
         super();
         AdoptPetsGuideView;
         PetTip;
         PetHappyTip;
         PetGrowUpTip;
      }
      
      public static function get instance() : PetsBagControl
      {
         if(!_instance)
         {
            _instance = new PetsBagControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PetsBagManager.instance().addEventListener("showPetFood",__onShowPetFood);
         PetsBagManager.instance().addEventListener("petsBagOpenView",__onOpenView);
         PetsBagManager.instance().addEventListener("petsBagHideView",__onHideView);
         PetsBagManager.instance().addEventListener("petsAdoptOpenView",__onOpenAdoptView);
      }
      
      protected function __onOpenAdoptView(param1:UpdatePetInfoEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(PetsBagManager.instance().haveTaskOrderByID(367))
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("farm.adoptPetsView.adoptGuide");
            _loc2_.show();
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("farm.adoptPetsView.adopt");
            _loc3_.show();
            _loc3_.x = 170;
         }
      }
      
      protected function __onShowPetFood(param1:UpdatePetInfoEvent) : void
      {
         new CmdShowPetFoodNumberSelectFrame().excute(InventoryItemInfo(param1.data));
      }
      
      protected function __onOpenView(param1:UpdatePetInfoEvent) : void
      {
         PlayerInfoViewControl.isOpenFromBag = true;
         _petView = ComponentFactory.Instance.creatComponentByStylename("petsBag.PetsView");
         _petView.show();
      }
      
      protected function __onHideView(param1:UpdatePetInfoEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         if(_petView != null)
         {
            _petView.dispose();
         }
         _petView = null;
      }
   }
}
