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
      
      public function DrgnBoatHelpBtn(param1:Boolean = true)
      {
         super();
         if(param1)
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
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("drgnBoaticon");
      }
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.module == "drgnBoaticon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            _loc2_ = ComponentFactory.Instance.creat("drgnBoat.HelpPrompt");
            _loc3_ = ComponentFactory.Instance.creat("drgnBoat.HelpFrame");
            _loc3_.setView(_loc2_);
            _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
            _loc3_.changeSubmitButtonY(29);
            LayerManager.Instance.addToLayer(_loc3_,3,true,1);
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
