package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class WantTakeInFrame extends Frame
   {
       
      
      private var _tip:FilterFrameText;
      
      private var _input:TextInput;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      public function WantTakeInFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __addToStageHandler(param1:Event) : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      private function __inputChangeHandler(param1:Event) : void{}
      
      private function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      override public function dispose() : void{}
   }
}
