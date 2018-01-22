package im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.view.chat.ChatEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class AddFriendFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const MAX_CHAES:int = 14;
       
      
      protected var _inputText:FilterFrameText;
      
      protected var _explainText:FilterFrameText;
      
      protected var _hintText:FilterFrameText;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _name:String;
      
      public function AddFriendFrame(){super();}
      
      protected function initContainer() : void{}
      
      private function initEvent() : void{}
      
      private function __inputTextChange(param1:Event = null) : void{}
      
      private function __onNameClick(param1:ChatEvent) : void{}
      
      protected function __fieldKeyDown(param1:KeyboardEvent) : void{}
      
      private function __frameEvent(param1:FrameEvent) : void{}
      
      protected function submit() : void{}
      
      protected function hide() : void{}
      
      private function __setFocus(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
