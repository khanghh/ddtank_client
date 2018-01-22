package pyramid.view
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.states.BaseStateView;
   
   public class PyramidSystem extends BaseStateView
   {
       
      
      private var _pyramidView:PyramidView;
      
      public function PyramidSystem()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         CacheSysManager.lock("alertInPyramid");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _pyramidView = new PyramidView();
         addChild(_pyramidView);
         super.enter(param1,param2);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         CacheSysManager.unlock("alertInPyramid");
         CacheSysManager.getInstance().release("alertInPyramid");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(param1);
         dispose();
      }
      
      override public function getType() : String
      {
         return "pyramid";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_pyramidView);
         _pyramidView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
