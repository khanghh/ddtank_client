package Indiana
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class IndianaIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:MovieClip;
      
      public function IndianaIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("asst.hall.oneYuanShopingIcon");
         this.buttonMode = true;
         addChild(_activityIcon);
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__enterIndianaView);
      }
      
      private function __enterIndianaView(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         IndianaDataManager.instance.show();
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__enterIndianaView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_activityIcon);
         _activityIcon = null;
      }
   }
}
