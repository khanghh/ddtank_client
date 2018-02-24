package horse.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import horse.HorseAmuletManager;
   
   public class HorseAmuletMainView extends Frame
   {
       
      
      private var _mainBg:ScaleBitmapImage;
      
      private var _bgView:HorseAmuletBagView;
      
      private var _equipView:HorseAmuletEquipView;
      
      private var _activateView:HorseAmuletActivateView;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function HorseAmuletMainView(){super();}
      
      override protected function init() : void{}
      
      private function __onUpdateLeftView(param1:Event) : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      public function show() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
