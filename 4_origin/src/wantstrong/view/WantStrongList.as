package wantstrong.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import wantstrong.model.WantStrongModel;
   
   public class WantStrongList extends Sprite implements Disposeable
   {
       
      
      private var _listMenu:WantStrongMenu;
      
      private var _model:WantStrongModel;
      
      public function WantStrongList(param1:WantStrongModel)
      {
         super();
         _model = param1;
         createUI();
      }
      
      private function createUI() : void
      {
         _listMenu = ComponentFactory.Instance.creatCustomObject("wantstrong.WantStrongMenu",[_model]);
         addChild(_listMenu);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _listMenu = null;
      }
   }
}
