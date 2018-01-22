package sevenDouble.view
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
   
   public class SevenDoubleHelpBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _loadedUiModuleNum:int;
      
      public function SevenDoubleHelpBtn(param1:Boolean = true)
      {
         super();
         if(param1)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.HelpButton");
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.HelpButtonShort");
         }
         addChild(_btn);
         _btn.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("sevendoubleicon");
         UIModuleLoader.Instance.addUIModuleImp("ddtstore");
      }
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.module == "sevendoubleicon" || param1.module == "ddtstore")
         {
            _loadedUiModuleNum = Number(_loadedUiModuleNum) + 1;
            if(_loadedUiModuleNum == 2)
            {
               _loadedUiModuleNum = 0;
               UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
               _loc2_ = ComponentFactory.Instance.creat("sevenDouble.HelpPrompt");
               _loc3_ = ComponentFactory.Instance.creat("sevenDouble.HelpFrame");
               _loc3_.setView(_loc2_);
               _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
               LayerManager.Instance.addToLayer(_loc3_,3,true,1);
            }
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
