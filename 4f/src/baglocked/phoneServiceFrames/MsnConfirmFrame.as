package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class MsnConfirmFrame extends Frame
   {
      
      public static const MSN_MONEY:int = 50;
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _phoneNum:FilterFrameText;
      
      private var _confirmTxt:FilterFrameText;
      
      private var _confirmInput:TextInput;
      
      private var _getConfirmBtn:TextButton;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var type:int;
      
      public function MsnConfirmFrame(){super();}
      
      public function init2(param1:int) : void{}
      
      protected function __getConfirmBtnClick(param1:MouseEvent) : void{}
      
      protected function __alertGetConfirmNum(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function getConfirmMsn() : void{}
      
      protected function __nextBtnClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      public function show() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
