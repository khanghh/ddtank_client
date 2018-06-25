package petIsland
{
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PetIslandControl extends EventDispatcher
   {
      
      private static var _instance:PetIslandControl;
       
      
      public function PetIslandControl()
      {
         super();
      }
      
      public static function get instance() : PetIslandControl
      {
         if(!_instance)
         {
            _instance = new PetIslandControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PetIslandManager.instance.addEventListener("showMainView",__showPetIslandHandler);
      }
      
      private function __showPetIslandHandler(e:Event) : void
      {
         if(StateManager.currentStateType != "petIsland")
         {
            StateManager.setState("petIsland");
         }
      }
   }
}
