package mark
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mark.data.MarkChipData;
   import mark.event.MarkEvent;
   import mark.mornUI.MarkMainFrameUI;
   import mark.views.MarkArtificeView;
   import mark.views.MarkHammerView;
   import morn.core.handlers.Handler;
   
   public class MarkMainFrame extends MarkMainFrameUI
   {
       
      
      private var _tabContainer:VBox;
      
      private var _tab:SelectedButtonGroup;
      
      private var _containers:Dictionary = null;
      
      private var _transfer:SelectedButton = null;
      
      private var _transferSprite:Sprite = null;
      
      private var _transferTip:OneLineTip = null;
      
      private var _tabMask:Sprite = null;
      
      public function MarkMainFrame(){super();}
      
      override protected function initialize() : void{}
      
      private function checkChipStatus(param1:MarkEvent = null) : void{}
      
      private function overHander(param1:MouseEvent) : void{}
      
      private function outHander(param1:MouseEvent) : void{}
      
      private function close() : void{}
      
      private function initEvent() : void{}
      
      private function transferResultHandler(param1:MarkEvent) : void{}
      
      private function submitResult(param1:MarkEvent) : void{}
      
      private function onMaskClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function select(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
