package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class SetPassFrameNew extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _completeBtn7:TextButton;
      
      private var _subtitle:Image;
      
      private var _text7_0:FilterFrameText;
      
      private var _text7_1:FilterFrameText;
      
      private var _text7_2:FilterFrameText;
      
      private var _text7_3:FilterFrameText;
      
      private var _text7_4:FilterFrameText;
      
      private var _text7_5:FilterFrameText;
      
      private var _textInput7_1:TextInput;
      
      private var _textInput7_2:TextInput;
      
      public function SetPassFrameNew(){super();}
      
      public function __onTextEnter(param1:KeyboardEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      private function __completeBtn7Click(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __textChange(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
