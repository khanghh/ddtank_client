package floatParade.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import floatParade.FloatParadeManager;
   import invite.InviteManager;
   
   public class FloatParadeMatchView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _carImg:Bitmap;
      
      private var _typeTextIcon:Bitmap;
      
      private var _tipTxtIcon:Bitmap;
      
      private var _leftTxt:FilterFrameText;
      
      private var _rightTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _countDown:int = 9;
      
      private var _timer:Timer;
      
      private var _isDispose:Boolean = false;
      
      public function FloatParadeMatchView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function cancelMatchHandler(param1:FrameEvent) : void{}
      
      private function cancelGameHandler(param1:Event) : void{}
      
      private function onCancel(param1:MouseEvent) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
