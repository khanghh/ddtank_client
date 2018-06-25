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
      
      public function ConsortionRewardSp()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _contentSp = new Sprite();
         addChild(_contentSp);
         var bg:Bitmap = ComponentFactory.Instance.creat("asset.placardAndEvent.callback3");
         _contentSp.addChild(bg);
         _weekRewardBtn = ComponentFactory.Instance.creat("asset.placardAndEvent.weekRewardBtn");
         _callBackBtn = ComponentFactory.Instance.creat("asset.placardAndEvent.callBackBtn");
         _callBackBtn.setFocusFrame();
         _contentSp.addChild(_callBackBtn);
         _targetBtn = ComponentFactory.Instance.creat("asset.placardAndEvent.targetBtn");
         _contentSp.addChild(_targetBtn);
      }
      
      private function initEvent() : void
      {
         _weekRewardBtn.addEventListener("click",onBtnClick);
         _callBackBtn.addEventListener("click",onBtnClick);
         _targetBtn.addEventListener("click",onBtnClick);
         ConsortionModelManager.Instance.addEventListener("leave_call_back_view",onLeaveCallBackView);
      }
      
      private function removeEvent() : void
      {
         _weekRewardBtn.removeEventListener("click",onBtnClick);
         _callBackBtn.removeEventListener("click",onBtnClick);
         _targetBtn.removeEventListener("click",onBtnClick);
         ConsortionModelManager.Instance.removeEventListener("leave_call_back_view",onLeaveCallBackView);
      }
      
      private function onBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _contentSp.visible = false;
         var target:Object = evt.target;
         if(target == _weekRewardBtn)
         {
            _weekRewardView = new ConsortionWeekRewardView();
            addChild(_weekRewardView);
         }
         else if(target == _callBackBtn)
         {
            _callBackView = new CallBackView();
            addChild(_callBackView);
         }
         else if(target == _targetBtn)
         {
            ConsortionModelManager.Instance.initConsortionActiveTarget();
            _targetView = new ConsortionActiveTargetView();
            addChild(_targetView);
            ConsortionModelManager.Instance.requestSortionActiveTargetSchedule();
         }
      }
      
      private function onLeaveCallBackView(evt:Event) : void
      {
         _contentSp.visible = true;
         ObjectUtils.disposeObject(_callBackView);
         _callBackView = null;
         ObjectUtils.disposeObject(_weekRewardView);
         _weekRewardView = null;
         ObjectUtils.disposeObject(_targetView);
         _targetView = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _weekRewardBtn = null;
         _callBackBtn = null;
         _weekRewardView = null;
         _callBackView = null;
         _contentSp = null;
         _targetBtn = null;
         _targetView = null;
      }
   }
}
