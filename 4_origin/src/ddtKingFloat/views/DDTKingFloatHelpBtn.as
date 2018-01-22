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
      
      public function DDTKingFloatHelpBtn(param1:Boolean = true)
      {
         super();
         if(param1)
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
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         AssetModuleLoader.addModelLoader("ddtKingFloaticon",6);
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.startCodeLoader(loadIconCompleteHandler);
      }
      
      private function loadIconCompleteHandler() : void
      {
         var _loc1_:DisplayObject = ComponentFactory.Instance.creat("ddtKing.HelpPrompt");
         var _loc2_:HelpFrame = ComponentFactory.Instance.creat("ddtKing.HelpFrame");
         _loc2_.setView(_loc1_);
         _loc2_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         _loc2_.changeSubmitButtonY(29);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
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
