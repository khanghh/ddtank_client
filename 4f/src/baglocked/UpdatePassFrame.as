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
   
   public class UpdatePassFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _ddtbaglock:ScaleBitmapImage;
      
      private var _deselectBtn5:TextButton;
      
      private var _text5_1:FilterFrameText;
      
      private var _text5_2:FilterFrameText;
      
      private var _text5_3:FilterFrameText;
      
      private var _text5_4:FilterFrameText;
      
      private var _text5_5:FilterFrameText;
      
      private var _textInput5_1:TextInput;
      
      private var _textInput5_2:TextInput;
      
      private var _textInput5_3:TextInput;
      
      private var _updateBtn:TextButton;
      
      public function UpdatePassFrame(){super();}
      
      public function __onTextEnter(param1:KeyboardEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      private function __deselectBtn5Click(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __textChange(param1:Event) : void{}
      
      private function __updateBtnClick(param1:MouseEvent) : void{}
      
      private function __updateSuccessHandler(param1:BagEvent) : void{}
      
      private function refreshBtnsState() : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
