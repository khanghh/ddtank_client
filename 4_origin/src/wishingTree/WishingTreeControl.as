package wishingTree
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.loader.LoaderCreate;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import wishingTree.views.WishingTreeFrame;
   
   public class WishingTreeControl
   {
      
      private static var _instance:WishingTreeControl;
       
      
      private var _frame:WishingTreeFrame;
      
      public function WishingTreeControl()
      {
         super();
      }
      
      public static function get instance() : WishingTreeControl
      {
         if(!_instance)
         {
            _instance = new WishingTreeControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         WishingTreeManager.instance.addEventListener("wishingTreeOpen",open);
      }
      
      private function open(param1:Event) : void
      {
         new HelperUIModuleLoad().loadUIModule(["wishingTree"],openFrame);
      }
      
      private function openFrame() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createBeadTemplateLoader()],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("wishingTree.frame");
         LayerManager.Instance.addToLayer(_frame,3,true,1,true);
      }
   }
}
