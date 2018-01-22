package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import demonChiYou.DemonChiYouManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class DemonChiYouIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:Bitmap;
      
      private var _lastClickTime:int = 0;
      
      public function DemonChiYouIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("asset.hall.demonChiYouIcon");
         this.buttonMode = true;
         _activityIcon.y = -9;
         addChild(_activityIcon);
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",enterBossSence);
      }
      
      protected function enterBossSence(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime > 1000)
         {
            if(PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               DemonChiYouManager.instance.onClickIcon();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("demonChiYou.cannotEnter.noConsortia"));
            }
            _lastClickTime = _loc2_;
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",enterBossSence);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_activityIcon);
         _activityIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
