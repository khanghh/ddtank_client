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
      
      public function PetSpriteModel(target:IEventDispatcher = null)
      {
         super(target);
         initEvents();
      }
      
      public function get petSwitcher() : Boolean
      {
         return _petSwitcher;
      }
      
      public function set petSwitcher(value:Boolean) : void
      {
         _petSwitcher = value;
      }
      
      private function initEvents() : void
      {
         PlayerManager.Instance.Self.addEventListener("propertychange",__updatePet);
      }
      
      protected function __updatePet(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Pets"] != null)
         {
            return;
         }
         if(_currentPet != PlayerManager.Instance.Self.currentPet)
         {
            currentPet = PlayerManager.Instance.Self.currentPet;
         }
      }
      
      public function set currentPet(val:PetInfo) : void
      {
         if(val == _currentPet)
         {
            return;
         }
         _currentPet = val;
         dispatchEvent(new Event("currentPetChanged"));
      }
      
      private function __gpChanged() : void
      {
         dispatchEvent(new Event("gpChanged"));
      }
      
      protected function __hungerChanged(event:Event) : void
      {
         dispatchEvent(new Event("hungerChanged"));
      }
      
      public function get currentPet() : PetInfo
      {
         return _currentPet;
      }
   }
}
