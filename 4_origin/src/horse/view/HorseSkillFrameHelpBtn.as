package horse.view
{
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
   
   public class HorseSkillFrameHelpBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function HorseSkillFrameHelpBtn()
      {
         super();
         _btn = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.helpBtn");
         addChild(_btn);
         _btn.addEventListener("click",clickHandler,false,0,true);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("horse.skillFrame.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("horse.skillFrame.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
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
