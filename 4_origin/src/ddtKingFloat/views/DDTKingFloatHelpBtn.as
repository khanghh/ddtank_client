package ddtKingFloat.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import store.HelpFrame;
   
   public class DDTKingFloatHelpBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function DDTKingFloatHelpBtn(isInGame:Boolean = true)
      {
         super();
         if(isInGame)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("ddtKing.HelpButton");
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("core.helpButtonCircle");
            PositionUtils.setPos(_btn,"ddtKing.circelHelpBtnPos");
         }
         addChild(_btn);
         _btn.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         AssetModuleLoader.addModelLoader("ddtKingFloaticon",6);
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.startCodeLoader(loadIconCompleteHandler);
      }
      
      private function loadIconCompleteHandler() : void
      {
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("ddtKing.HelpPrompt");
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("ddtKing.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         helpPage.changeSubmitButtonY(29);
         LayerManager.Instance.addToLayer(helpPage,3,true,1);
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
