package escort.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import escort.EscortControl;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   
   public class EscortFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _cellList:Vector.<EscortFrameItemCell>;
      
      private var _btn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _helpBtn:EscortHelpBtn;
      
      private var _doubleTagIcon:Bitmap;
      
      private var _matchView:EscortMatchView;
      
      public function EscortFrame(){super();}
      
      private function initView() : void{}
      
      private function refreshDoubleTagIcon() : void{}
      
      private function initEvent() : void{}
      
      private function refreshEnterCountHandler(param1:Event) : void{}
      
      private function endHandler(param1:Event) : void{}
      
      private function enterGameHandler(param1:Event) : void{}
      
      private function startGameHandler(param1:Event) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function startConfirm(param1:FrameEvent) : void{}
      
      private function startGameReConfirm(param1:FrameEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
