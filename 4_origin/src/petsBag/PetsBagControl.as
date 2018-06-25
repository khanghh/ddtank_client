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
      
      protected function __onOpenAdoptView(event:UpdatePetInfoEvent) : void
      {
         var _petsAdoptGudie:* = null;
         var _petsAdopt:* = null;
         if(PetsBagManager.instance().haveTaskOrderByID(367))
         {
            _petsAdoptGudie = ComponentFactory.Instance.creatComponentByStylename("farm.adoptPetsView.adoptGuide");
            _petsAdoptGudie.show();
         }
         else
         {
            _petsAdopt = ComponentFactory.Instance.creatComponentByStylename("farm.adoptPetsView.adopt");
            _petsAdopt.show();
            _petsAdopt.x = 170;
         }
      }
      
      protected function __onShowPetFood(event:UpdatePetInfoEvent) : void
      {
         new CmdShowPetFoodNumberSelectFrame().excute(InventoryItemInfo(event.data));
      }
      
      protected function __onOpenView(event:UpdatePetInfoEvent) : void
      {
         PlayerInfoViewControl.isOpenFromBag = true;
         _petView = ComponentFactory.Instance.creatComponentByStylename("petsBag.PetsView");
         _petView.show();
      }
      
      protected function __onHideView(event:UpdatePetInfoEvent) : void
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
