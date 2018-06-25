package dice
{
   import ddt.manager.StateManager;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.events.EventDispatcher;
   
   public class DiceControl extends EventDispatcher
   {
      
      private static var _instance:DiceControl;
       
      
      public function DiceControl()
      {
         super();
      }
      
      public static function get instance() : DiceControl
      {
         if(!_instance)
         {
            _instance = new DiceControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DiceController.Instance.addEventListener("showMainView",__showPetIslandHandler);
      }
      
      private function __showPetIslandHandler(e:DiceEvent) : void
      {
         if(StateManager.currentStateType != "diceSystem")
         {
            StateManager.setState("diceSystem");
         }
      }
   }
}
