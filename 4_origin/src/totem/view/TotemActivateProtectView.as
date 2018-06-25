package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import totem.TotemManager;
   
   public class TotemActivateProtectView extends Sprite implements Disposeable
   {
       
      
      private var _activateProtectSCB:SelectedCheckButton;
      
      public function TotemActivateProtectView()
      {
         super();
         _activateProtectSCB = ComponentFactory.Instance.creatComponentByStylename("totem.activateProtectSCB");
         _activateProtectSCB.selected = TotemManager.instance.isSelectedActPro;
         _activateProtectSCB.tipData = LanguageMgr.GetTranslation("ddt.totem.activateProtectTipTxt");
         _activateProtectSCB.addEventListener("click",clickHandler,false,0,true);
         addChild(_activateProtectSCB);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         TotemManager.instance.isSelectedActPro = _activateProtectSCB.selected;
         TotemManager.instance.isDonotPromptActPro = false;
         TotemManager.instance.isBindInNoPrompt = false;
      }
      
      public function dispose() : void
      {
         if(_activateProtectSCB)
         {
            _activateProtectSCB.removeEventListener("click",clickHandler);
         }
         ObjectUtils.disposeObject(_activateProtectSCB);
         _activateProtectSCB = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
