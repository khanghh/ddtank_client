package drgnBoat.views
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import store.HelpFrame;
   
   public class DrgnBoatHelpBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function DrgnBoatHelpBtn(isInGame:Boolean = true)
      {
         super();
         if(isInGame)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.HelpButton");
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.HelpButtonSmall");
         }
         addChild(_btn);
         _btn.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("drgnBoaticon");
      }
      
      private function loadIconCompleteHandler(event:UIModuleEvent) : void
      {
         var helpBd:* = null;
         var helpPage:* = null;
         if(event.module == "drgnBoaticon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            helpBd = ComponentFactory.Instance.creat("drgnBoat.HelpPrompt");
            helpPage = ComponentFactory.Instance.creat("drgnBoat.HelpFrame");
            helpPage.setView(helpBd);
            helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
            helpPage.changeSubmitButtonY(29);
            LayerManager.Instance.addToLayer(helpPage,3,true,1);
         }
      }
      
      public function dispose() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
         }
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
