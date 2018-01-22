package consortion.view.selfConsortia
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionActiveTargetData;
   import ddt.events.CEvent;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionActiveTargetView extends Sprite implements Disposeable
   {
       
      
      private var _backBtn:SimpleBitmapButton;
      
      private var _targetItems:Vector.<ConsortionActiveTargetItem>;
      
      public function ConsortionActiveTargetView()
      {
         _targetItems = new Vector.<ConsortionActiveTargetItem>();
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _backBtn.addEventListener("click",onClick);
         ConsortionModelManager.Instance.addEventListener("updateActiveTargetStatus",update);
         ConsortionModelManager.Instance.addEventListener("updatectiveTargetSchedule",update);
      }
      
      private function removeEvent() : void
      {
         _backBtn && _backBtn.removeEventListener("click",onClick);
         ConsortionModelManager.Instance.removeEventListener("updateActiveTargetStatus",update);
         ConsortionModelManager.Instance.removeEventListener("updatectiveTargetSchedule",update);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ConsortionModelManager.Instance.dispatchEvent(new Event("leave_call_back_view"));
      }
      
      private function initView() : void
      {
         _backBtn = UICreatShortcut.creatAndAdd("asset.placardAndEvent.targetView.backBtn",this);
         update();
      }
      
      private function update(param1:CEvent = null) : void
      {
         var _loc5_:int = 0;
         clearItems();
         var _loc4_:Vector.<ConsortionActiveTargetData> = null;
         var _loc3_:ConsortionActiveTargetData = null;
         var _loc2_:ConsortionActiveTargetItem = null;
         _loc5_ = 1;
         while(_loc5_ <= 3)
         {
            _loc2_ = new ConsortionActiveTargetItem();
            _loc4_ = ConsortionModelManager.Instance.model.activeTargetDic[_loc5_];
            addChild(_loc2_);
            _loc2_.data = _loc5_;
            _targetItems.push(_loc2_);
            _loc5_++;
         }
         layoutItems();
      }
      
      private function clearItems() : void
      {
         var _loc1_:ConsortionActiveTargetItem = null;
         while(_targetItems.length > 0)
         {
            _loc1_ = _targetItems.pop();
            ObjectUtils.disposeObject(_loc1_);
         }
      }
      
      private function layoutItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortionActiveTargetItem = null;
         _loc2_ = 0;
         while(_loc2_ < _targetItems.length)
         {
            _loc1_ = _targetItems[_loc2_];
            _loc1_.x = -2;
            _loc1_.y = _loc2_ == 0?10:_targetItems[_loc2_ - 1].y + _targetItems[_loc2_ - 1].height + 8;
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearItems();
         _targetItems = null;
         ObjectUtils.disposeObject(_backBtn);
         _backBtn = null;
      }
   }
}
