package petIsland.view
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.states.BaseStateView;
   
   public class PetIslandMainView extends BaseStateView
   {
       
      
      private var _petIslandView:PetIslandView;
      
      public function PetIslandMainView(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function dispose() : void{}
   }
}
