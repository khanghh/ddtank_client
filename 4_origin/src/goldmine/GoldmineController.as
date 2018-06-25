package goldmine
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import goldmine.views.GoldmineMainFrame;
   
   public class GoldmineController extends CoreController
   {
      
      private static var _instance:GoldmineController;
       
      
      private var _manager:GoldmineManager;
      
      private var _goldmineMainFrame:GoldmineMainFrame;
      
      public function GoldmineController()
      {
         super();
      }
      
      public static function get Instance() : GoldmineController
      {
         if(_instance == null)
         {
            _instance = new GoldmineController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _manager = GoldmineManager.Instance;
         _manager.addEventListener("goldmine_showview",__onShowView);
         _manager.addEventListener("goldmine_closeview",__onCloseView);
      }
      
      private function __onShowView(e:CEvent) : void
      {
         if(_goldmineMainFrame)
         {
            ObjectUtils.disposeObject(_goldmineMainFrame);
            _goldmineMainFrame = null;
         }
         _goldmineMainFrame = ComponentFactory.Instance.creatComponentByStylename("goldmine.frame");
         LayerManager.Instance.addToLayer(_goldmineMainFrame,3,false,1);
      }
      
      private function __onCloseView(e:CEvent) : void
      {
         if(_goldmineMainFrame)
         {
            ObjectUtils.disposeObject(_goldmineMainFrame);
            _goldmineMainFrame = null;
         }
      }
   }
}
