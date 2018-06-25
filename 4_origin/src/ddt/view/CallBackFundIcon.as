package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CallBackFundIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:Bitmap;
      
      public function CallBackFundIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("asset.hall.callBackFundIcon");
         this.buttonMode = true;
         this.useHandCursor = true;
         addChild(_activityIcon);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",showFrame);
      }
      
      protected function showFrame(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",showFrame);
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
