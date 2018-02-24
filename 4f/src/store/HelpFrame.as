package store
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HelpFrame extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _submitButton:TextButton;
      
      public function HelpFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      public function changeSubmitButtonY(param1:int) : void{}
      
      public function changeSubmitButtonX(param1:int) : void{}
      
      public function setView(param1:DisplayObject) : void{}
      
      private function _submit(param1:MouseEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      override public function dispose() : void{}
   }
}
