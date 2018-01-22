package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class SetPassFrame2 extends Frame
   {
       
      
      private var _backBtn1:TextButton;
      
      private var _bagLockedController:BagLockedController;
      
      private var _bag_Combox1:ComboBox;
      
      private var _bag_Combox2:ComboBox;
      
      private var _nextBtn2:TextButton;
      
      private var _subtitle:Image;
      
      private var _textInfo2_1:FilterFrameText;
      
      private var _textInfo2_2:FilterFrameText;
      
      private var _textInfo2_3:FilterFrameText;
      
      private var _textInfo2_4:FilterFrameText;
      
      private var _textInfo2_5:FilterFrameText;
      
      private var _textInfo2_6:FilterFrameText;
      
      private var _textinput2_1:TextInput;
      
      private var _textinput2_2:TextInput;
      
      private var _titText2_0:FilterFrameText;
      
      private var _textInfo2_7:FilterFrameText;
      
      private var _isSkip:Boolean;
      
      public function SetPassFrame2(){super();}
      
      public function __onTextEnter(param1:KeyboardEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      private function __backBtn1Click(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __listItemClick(param1:Event) : void{}
      
      private function __nextBtn2Click(param1:MouseEvent) : void{}
      
      private function __textChange(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      private function __ComboxClick(param1:MouseEvent) : void{}
      
      private function remvoeEvent() : void{}
   }
}
