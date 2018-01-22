package pet.sprite
{
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import pet.data.PetInfo;
   
   public class PetSpriteModel extends EventDispatcher
   {
      
      public static const CURRENT_PET_CHANGED:String = "currentPetChanged";
      
      public static const HUNGER_CHANGED:String = "hungerChanged";
      
      public static const GP_CHANGED:String = "gpChanged";
       
      
      private var _currentPet:PetInfo;
      
      private var _petSwitcher:Boolean = true;
      
      public function PetSpriteModel(param1:IEventDispatcher = null)
      {
         super(param1);
         initEvents();
      }
      
      public function get petSwitcher() : Boolean
      {
         return _petSwitcher;
      }
      
      public function set petSwitcher(param1:Boolean) : void
      {
         _petSwitcher = param1;
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__updatePet);
      }
      
      protected function __updatePet(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Pets"] != null)
         {
            return;
         }
         if(_currentPet != PlayerManager.Instance.Self.currentPet)
         {
            currentPet = PlayerManager.Instance.Self.currentPet;
         }
      }
      
      public function set currentPet(param1:PetInfo) : void
      {
         if(param1 == _currentPet)
         {
            return;
         }
         _currentPet = param1;
         dispatchEvent(new Event("currentPetChanged"));
      }
      
      private function __gpChanged() : void
      {
         dispatchEvent(new Event("gpChanged"));
      }
      
      protected function __hungerChanged(param1:Event) : void
      {
         dispatchEvent(new Event("hungerChanged"));
      }
      
      public function get currentPet() : PetInfo
      {
         return _currentPet;
      }
   }
}
