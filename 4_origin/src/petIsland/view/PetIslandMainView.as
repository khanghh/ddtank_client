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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         CacheSysManager.lock("alertInPetIsland");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _petIslandView = new PetIslandView();
         addChild(_petIslandView);
         super.enter(prev,data);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         CacheSysManager.unlock("alertInPetIsland");
         CacheSysManager.getInstance().release("alertInPetIsland");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(next);
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
