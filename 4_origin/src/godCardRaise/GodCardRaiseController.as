package godCardRaise
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import godCardRaise.view.GodCardRaiseMainView;
   
   public class GodCardRaiseController extends CoreController
   {
      
      private static var instance:GodCardRaiseController;
       
      
      private var _manager:GodCardRaiseManager;
      
      private var _godCardRaiseMainView:GodCardRaiseMainView;
      
      public function GodCardRaiseController()
      {
         super();
      }
      
      public static function get Instance() : GodCardRaiseController
      {
         if(!instance)
         {
            instance = new GodCardRaiseController();
         }
         return instance;
      }
      
      public function setup() : void
      {
         _manager = GodCardRaiseManager.Instance;
         GodCardRaiseManager.Instance.addEventListener("godCardRaise_show_view",onShowView);
         GodCardRaiseManager.Instance.addEventListener("closeView",onCloseView);
      }
      
      private function onShowView(param1:CEvent) : void
      {
         if(_godCardRaiseMainView)
         {
            ObjectUtils.disposeObject(_godCardRaiseMainView);
            _godCardRaiseMainView = null;
         }
         _godCardRaiseMainView = ComponentFactory.Instance.creatComponentByStylename("godCardRaise.frame");
         LayerManager.Instance.addToLayer(_godCardRaiseMainView,3,true,1);
      }
      
      private function onCloseView(param1:CEvent) : void
      {
         if(_godCardRaiseMainView)
         {
            ObjectUtils.disposeObject(_godCardRaiseMainView);
            _godCardRaiseMainView = null;
         }
      }
   }
}
