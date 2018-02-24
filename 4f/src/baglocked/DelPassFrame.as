package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class DelPassFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _ddtbaglockBg:ScaleBitmapImage;
      
      private var _delBtn:TextButton;
      
      private var _deselectBtn6:TextButton;
      
      private var _text6_1:FilterFrameText;
      
      private var _text6_2:FilterFrameText;
      
      private var _text6_3:FilterFrameText;
      
      private var _text6_4:FilterFrameText;
      
      private var _text6_5:FilterFrameText;
      
      private var _text6_6:FilterFrameText;
      
      private var _text6_7:FilterFrameText;
      
      private var _textInput6_1:TextInput;
      
      private var _textInput6_2:TextInput;
      
      public function DelPassFrame(){super();}
      
      public function __onTextEnter(param1:KeyboardEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      private function __delBtnClick(param1:MouseEvent) : void{}
      
      private function refreshBtnsState() : void{}
      
      private function __deselectBtn6Click(param1:MouseEvent) : void{}
      
      private function __delPasswordHandler(param1:BagEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __textChange(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
