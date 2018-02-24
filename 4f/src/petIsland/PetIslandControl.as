package petIsland
{
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PetIslandControl extends EventDispatcher
   {
      
      private static var _instance:PetIslandControl;
       
      
      public function PetIslandControl(){super();}
      
      public static function get instance() : PetIslandControl{return null;}
      
      public function setup() : void{}
      
      private function __showPetIslandHandler(param1:Event) : void{}
   }
}
