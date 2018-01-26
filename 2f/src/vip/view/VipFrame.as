package vip.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import vip.VipController;
   
   public class VipFrame extends Frame
   {
      
      public static const SELF_VIEW:int = 0;
      
      public static const OTHER_VIEW:int = 1;
       
      
      private var _hBox:HBox;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _giveYourselfOpenBtn:SelectedTextButton;
      
      private var _giveOthersOpenedBtn:SelectedTextButton;
      
      private var _vipSp:Disposeable;
      
      private var _head:VipFrameHead;
      
      private var _discountIcon:ScaleLeftRightImage;
      
      private var _discountTxt:FilterFrameText;
      
      private var discountCode:int = 0;
      
      private var _discountIconII:ScaleLeftRightImage;
      
      private var _discountIconIII:ScaleLeftRightImage;
      
      private var _discountTxtII:FilterFrameText;
      
      private var _discountTxtIII:FilterFrameText;
      
      public function VipFrame(){super();}
      
      private function _init() : void{}
      
      private function initView() : void{}
      
      private function updateView(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function __selectedButtonGroupChange(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
