package wonderfulActivity
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.EventDispatcher;
   import wonderfulActivity.event.WonderfulActivityEvent;
   import wonderfulActivity.items.JoinIsPowerView;
   import wonderfulActivity.items.StrengthDarenView;
   import wonderfulActivity.views.ActivityUnitListCell;
   
   public class WonderfulActivityControl extends EventDispatcher
   {
      
      private static var _instance:WonderfulActivityControl;
       
      
      private var _frame:WonderfulFrame;
      
      public function WonderfulActivityControl()
      {
         super();
         ActivityUnitListCell;
         JoinIsPowerView;
      }
      
      public static function get Instance() : WonderfulActivityControl
      {
         if(!_instance)
         {
            _instance = new WonderfulActivityControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         WonderfulActivityManager.Instance.addEventListener("wonderfulActivityOpenView",__onOpenView);
         WonderfulActivityManager.Instance.addEventListener("wonderfulActivityAddEment",__onAddElement);
      }
      
      protected function __onOpenView(event:WonderfulActivityEvent) : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("com.wonderfulActivity.WonderfulFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         _frame.addElement(WonderfulActivityManager.Instance.actList);
      }
      
      protected function __onAddElement(event:WonderfulActivityEvent) : void
      {
         if(WonderfulActivityManager.Instance.actList.length == 0)
         {
            dispose();
            return;
         }
         if(_frame && _frame.parent)
         {
            _frame.addElement(WonderfulActivityManager.Instance.actList);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_frame);
         _frame = null;
      }
      
      protected function onUIProgress(event:UIModuleEvent) : void
      {
         if(event.module == "wonderfulactivity")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      public function get frame() : WonderfulFrame
      {
         return _frame;
      }
   }
}
