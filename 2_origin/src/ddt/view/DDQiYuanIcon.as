package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.DDQiYuanManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class DDQiYuanIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:MovieClip;
      
      private var _lastClickTime:int = 0;
      
      public function DDQiYuanIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("asset.hall.ddQiYuanIcon");
         _activityIcon.mouseChildren = false;
         _activityIcon.buttonMode = true;
         _activityIcon.useHandCursor = true;
         addChild(_activityIcon);
      }
      
      private function initEvent() : void
      {
         _activityIcon.addEventListener("click",showDDQiYuanFrame);
      }
      
      protected function showDDQiYuanFrame(event:MouseEvent) : void
      {
         var currTime:int = getTimer();
         if(currTime - _lastClickTime > 1000)
         {
            SoundManager.instance.playButtonSound();
            DDQiYuanManager.instance.show();
            _lastClickTime = currTime;
         }
      }
      
      private function removeEvent() : void
      {
         _activityIcon.removeEventListener("click",showDDQiYuanFrame);
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
