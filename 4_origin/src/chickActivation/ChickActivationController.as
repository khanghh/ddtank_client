package chickActivation
{
   import chickActivation.view.ChickActivationViewFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   
   public class ChickActivationController
   {
      
      private static var _instance:ChickActivationController;
       
      
      public function ChickActivationController()
      {
         super();
      }
      
      public static function get instance() : ChickActivationController
      {
         if(_instance == null)
         {
            _instance = new ChickActivationController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ChickActivationManager.instance.addEventListener("ChickActivationShowFrame",__onShowFrame);
      }
      
      private function __onShowFrame(param1:Event) : void
      {
         var _loc2_:ChickActivationViewFrame = ComponentFactory.Instance.creatComponentByStylename("ChickActivationViewFrame");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
   }
}
