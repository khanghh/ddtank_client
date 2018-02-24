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
      
      public function ConsortionActiveTargetView(){super();}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      private function initView() : void{}
      
      private function update(param1:CEvent = null) : void{}
      
      private function clearItems() : void{}
      
      private function layoutItems() : void{}
      
      public function dispose() : void{}
   }
}
