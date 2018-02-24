package chickActivation
{
   import chickActivation.view.ChickActivationViewFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   
   public class ChickActivationController
   {
      
      private static var _instance:ChickActivationController;
       
      
      public function ChickActivationController(){super();}
      
      public static function get instance() : ChickActivationController{return null;}
      
      public function setup() : void{}
      
      private function __onShowFrame(param1:Event) : void{}
   }
}
