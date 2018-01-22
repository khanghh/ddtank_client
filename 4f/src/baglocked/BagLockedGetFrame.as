package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class BagLockedGetFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _certainBtn:TextButton;
      
      private var _deselectBtn:TextButton;
      
      private var _forgetPwdBtn:TextButton;
      
      private var _text4_0:FilterFrameText;
      
      private var _text4_1:FilterFrameText;
      
      private var _textInput4:TextInput;
      
      public function BagLockedGetFrame(){super();}
      
      public function __onTextEnter(param1:KeyboardEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function __onAddToStage(param1:Event) : void{}
      
      private function getFocus() : void{}
      
      private function __getFocus(param1:KeyboardEvent) : void{}
      
      override protected function init() : void{}
      
      private function __certainBtnClick(param1:MouseEvent) : void{}
      
      private function __deselectBtnClick(param1:MouseEvent) : void{}
      
      private function __clearSuccessHandler(param1:BagEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __textChange(param1:Event) : void{}
      
      protected function __forgetPwdBtnClick(param1:MouseEvent) : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
