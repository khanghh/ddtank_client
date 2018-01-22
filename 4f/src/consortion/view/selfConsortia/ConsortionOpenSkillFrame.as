package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionOpenSkillFrame extends Frame
   {
       
      
      private var _cellBG:ScaleBitmapImage;
      
      private var _cell:ConsortionSkillCell;
      
      private var _numSelected:NumberSelecter;
      
      private var _riches:FilterFrameText;
      
      private var _ok:TextButton;
      
      private var _richesTxt:FilterFrameText;
      
      private var _richesbg:ScaleFrameImage;
      
      private var _info:ConsortionSkillInfo;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _isMetal:Boolean;
      
      public function ConsortionOpenSkillFrame(){super();}
      
      public function set isMetal(param1:Boolean) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __numberSelecterChange(param1:Event) : void{}
      
      private function __okHandler(param1:MouseEvent) : void{}
      
      private function __noEnoughHandler(param1:FrameEvent) : void{}
      
      private function __alertResponseHandler(param1:FrameEvent) : void{}
      
      public function set info(param1:ConsortionSkillInfo) : void{}
      
      override public function dispose() : void{}
   }
}
