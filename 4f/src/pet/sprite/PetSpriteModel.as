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
      
      public function PetSpriteModel(param1:IEventDispatcher = null){super(null);}
      
      public function get petSwitcher() : Boolean{return false;}
      
      public function set petSwitcher(param1:Boolean) : void{}
      
      private function initEvents() : void{}
      
      protected function __updatePet(param1:PlayerPropertyEvent) : void{}
      
      public function set currentPet(param1:PetInfo) : void{}
      
      private function __gpChanged() : void{}
      
      protected function __hungerChanged(param1:Event) : void{}
      
      public function get currentPet() : PetInfo{return null;}
   }
}
