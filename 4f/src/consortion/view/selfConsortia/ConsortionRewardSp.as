package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionRewardSp extends Sprite implements Disposeable
   {
       
      
      private var _weekRewardBtn:SimpleBitmapButton;
      
      private var _callBackBtn:SimpleBitmapButton;
      
      private var _targetBtn:SimpleBitmapButton;
      
      private var _weekRewardView:ConsortionWeekRewardView;
      
      private var _callBackView:CallBackView;
      
      private var _targetView:ConsortionActiveTargetView;
      
      private var _contentSp:Sprite;
      
      public function ConsortionRewardSp(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onBtnClick(param1:MouseEvent) : void{}
      
      private function onLeaveCallBackView(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
