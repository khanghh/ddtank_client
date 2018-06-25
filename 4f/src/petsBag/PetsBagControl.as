package petsBag{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.InventoryItemInfo;   import flash.events.EventDispatcher;   import petsBag.cmd.CmdShowPetFoodNumberSelectFrame;   import petsBag.event.UpdatePetInfoEvent;   import petsBag.petsAdvanced.PetsFormItemsTip;   import petsBag.view.AdoptPetsGuideView;   import petsBag.view.AdoptPetsView;   import petsBag.view.PetsView;   import petsBag.view.item.PetGrowUpTip;   import petsBag.view.item.PetHappyTip;   import petsBag.view.item.PetTip;      public class PetsBagControl extends EventDispatcher   {            private static var _instance:PetsBagControl;                   private var _petView:PetsView;            public function PetsBagControl() { super(); }
            public static function get instance() : PetsBagControl { return null; }
            public function setup() : void { }
            protected function __onOpenAdoptView(event:UpdatePetInfoEvent) : void { }
            protected function __onShowPetFood(event:UpdatePetInfoEvent) : void { }
            protected function __onOpenView(event:UpdatePetInfoEvent) : void { }
            protected function __onHideView(event:UpdatePetInfoEvent) : void { }
            public function hide() : void { }
   }}