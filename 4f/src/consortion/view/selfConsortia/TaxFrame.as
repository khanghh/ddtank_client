package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class TaxFrame extends Frame
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _ownMoney:FilterFrameText;
      
      private var _moneyForRiches:FilterFrameText;
      
      private var _taxMoney:TextInput;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      private var leaveToFillAlert:BaseAlerFrame;
      
      private var confirmAlert:BaseAlerFrame;
      
      private var _textWord1:FilterFrameText;
      
      private var _textWord2:FilterFrameText;
      
      public function TaxFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addToStageHandler(param1:Event) : void{}
      
      private function __responseHanlder(param1:FrameEvent) : void{}
      
      private function __confirmHanlder(param1:MouseEvent) : void{}
      
      private function __alertResponse(param1:FrameEvent) : void{}
      
      private function sendSocketData() : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      private function __taxChangeHandler(param1:Event) : void{}
      
      private function __enterHanlder(param1:KeyboardEvent) : void{}
      
      override public function dispose() : void{}
   }
}
