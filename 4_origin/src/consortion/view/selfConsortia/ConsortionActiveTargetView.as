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
      
      private function onClick(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ConsortionModelManager.Instance.dispatchEvent(new Event("leave_call_back_view"));
      }
      
      private function initView() : void
      {
         _backBtn = UICreatShortcut.creatAndAdd("asset.placardAndEvent.targetView.backBtn",this);
         update();
      }
      
      private function update(evt:CEvent = null) : void
      {
         var i:int = 0;
         clearItems();
         var targets:Vector.<ConsortionActiveTargetData> = null;
         var target:ConsortionActiveTargetData = null;
         var targetItem:ConsortionActiveTargetItem = null;
         for(i = 1; i <= 3; )
         {
            targetItem = new ConsortionActiveTargetItem();
            targets = ConsortionModelManager.Instance.model.activeTargetDic[i];
            addChild(targetItem);
            targetItem.data = i;
            _targetItems.push(targetItem);
            i++;
         }
         layoutItems();
      }
      
      private function clearItems() : void
      {
         var item:ConsortionActiveTargetItem = null;
         while(_targetItems.length > 0)
         {
            item = _targetItems.pop();
            ObjectUtils.disposeObject(item);
         }
      }
      
      private function layoutItems() : void
      {
         var i:int = 0;
         var targetItem:ConsortionActiveTargetItem = null;
         for(i = 0; i < _targetItems.length; )
         {
            targetItem = _targetItems[i];
            targetItem.x = -2;
            targetItem.y = i == 0?10:_targetItems[i - 1].y + _targetItems[i - 1].height + 8;
            i++;
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
