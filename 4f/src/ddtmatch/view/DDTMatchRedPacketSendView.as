package ddtmatch.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class DDTMatchRedPacketSendView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      private var select:NumberSelecter;
      
      private var _sendMoneyTxt:FilterFrameText;
      
      private var _messageTxt:FilterFrameText;
      
      public function DDTMatchRedPacketSendView(){super();}
      
      override protected function init() : void{}
      
      private function addEvent() : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
