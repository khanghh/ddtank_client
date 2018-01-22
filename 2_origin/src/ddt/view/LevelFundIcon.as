package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import levelFund.LevelFundManager;
   
   public class LevelFundIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:MovieImage;
      
      public function LevelFundIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("hall.levelFundActivityBtn");
         _activityIcon.buttonMode = true;
         addChild(_activityIcon);
      }
      
      private function initEvent() : void
      {
         _activityIcon.addEventListener("click",__showLevelFundActivityFrame);
      }
      
      protected function __showLevelFundActivityFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LevelFundManager.instance.show();
      }
      
      private function removeEvent() : void
      {
         _activityIcon.removeEventListener("click",__showLevelFundActivityFrame);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_activityIcon);
         _activityIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
