package sevenDouble.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
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
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import sevenDouble.SevenDoubleControl;
   import sevenDouble.SevenDoubleManager;
   
   public class SevenDoubleFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _cellList:Vector.<SevenDoubleFrameItemCell>;
      
      private var _btn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _matchView:SevenDoubleMatchView;
      
      private var _helpBtn:SevenDoubleHelpBtn;
      
      private var _doubleTagIcon:Bitmap;
      
      public function SevenDoubleFrame(){super();}
      
      private function initView() : void{}
      
      private function refreshDoubleTagIcon() : void{}
      
      private function initEvent() : void{}
      
      private function refreshEnterCountHandler(param1:Event) : void{}
      
      private function endHandler(param1:Event) : void{}
      
      private function enterGameHandler(param1:Event) : void{}
      
      private function startGameHandler(param1:Event) : void{}
      
      private function cancelMatchHandler(param1:FrameEvent) : void{}
      
      private function disposeMatchView() : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function startConfirm(param1:FrameEvent) : void{}
      
      private function startGameReConfirm(param1:FrameEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
