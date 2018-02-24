package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class ConsortionTrasferFrame extends Frame
   {
       
      
      private var _input:TextInput;
      
      private var _explain:FilterFrameText;
      
      private var _hint:FilterFrameText;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      public function ConsortionTrasferFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addToStageHandler(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __okHandler(param1:MouseEvent) : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      override public function dispose() : void{}
   }
}
