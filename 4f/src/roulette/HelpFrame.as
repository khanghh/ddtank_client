package roulette
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HelpFrame extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _submitButton:TextButton;
      
      public function HelpFrame(){super();}
      
      private function initView() : void{}
      
      public function set submitButtonPos(param1:String) : void{}
      
      private function addEvent() : void{}
      
      public function setView(param1:DisplayObject) : void{}
      
      private function _submit(param1:MouseEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
