package ddt.view.enthrall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class ValidateFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _nameInput:FilterFrameText;
      
      private var _idInput:FilterFrameText;
      
      private var _errorText:FilterFrameText;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      public function ValidateFrame(){super();}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __focusIn(param1:FocusEvent) : void{}
      
      override protected function init() : void{}
      
      private function __check(param1:MouseEvent) : void{}
      
      private function clear() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function hide() : void{}
      
      override public function dispose() : void{}
   }
}
