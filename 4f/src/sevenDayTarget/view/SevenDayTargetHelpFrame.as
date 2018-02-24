package sevenDayTarget.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SevenDayTargetHelpFrame extends Frame
   {
       
      
      private var _view:Sprite;
      
      private var _bg:Scale9CornerImage;
      
      private var _submitButton:TextButton;
      
      private var _helpInfo:MovieClip;
      
      public function SevenDayTargetHelpFrame(){super();}
      
      private function initView() : void{}
      
      public function changeContent(param1:MovieClip) : void{}
      
      private function addEvent() : void{}
      
      private function __submit(param1:MouseEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      override public function dispose() : void{}
   }
}
