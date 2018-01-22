package petIsland.view
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.states.BaseStateView;
   
   public class PetIslandMainView extends BaseStateView
   {
       
      
      private var _petIslandView:PetIslandView;
      
      public function PetIslandMainView()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         CacheSysManager.lock("alertInPetIsland");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _petIslandView = new PetIslandView();
         addChild(_petIslandView);
         super.enter(param1,param2);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         CacheSysManager.unlock("alertInPetIsland");
         CacheSysManager.getInstance().release("alertInPetIsland");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(param1);
         dispose();
      }
      
      override public function getType() : String
      {
         return "petIsland";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_petIslandView);
         _petIslandView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
