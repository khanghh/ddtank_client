package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class BreakGoodsView extends BaseAlerFrame
   {
      
      private static const EnterKeyCode:int = 13;
      
      private static const ESCkeyCode:int = 27;
       
      
      private var _input:FilterFrameText;
      
      private var _NumString:FilterFrameText;
      
      private var _tipString:FilterFrameText;
      
      private var _inputBG:Scale9CornerImage;
      
      private var _cell:BagCell;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _downBtn:SimpleBitmapButton;
      
      public function BreakGoodsView(){super();}
      
      private function addEvent() : void{}
      
      private function __onUpBtn(param1:Event) : void{}
      
      private function __onDownBtn(param1:Event) : void{}
      
      private function __onToStage(param1:Event) : void{}
      
      private function __onInputKeyUp(param1:KeyboardEvent) : void{}
      
      private function __getFocus(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function __input(param1:Event) : void{}
      
      private function downBtnEnable() : void{}
      
      public function show() : void{}
      
      private function __okClickCall(param1:ComponentEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function getFocus() : void{}
      
      private function okFun() : void{}
      
      override public function dispose() : void{}
      
      public function get cell() : BagCell{return null;}
      
      public function set cell(param1:BagCell) : void{}
   }
}
