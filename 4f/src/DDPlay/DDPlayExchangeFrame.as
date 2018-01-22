package DDPlay
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DDPlayExchangeFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _chooseNum:DDPlayExchangeNumberSekecter;
      
      private var _exchangeNum:Bitmap;
      
      private var _currentScore:FilterFrameText;
      
      private var _currentScoreBg:Bitmap;
      
      private var _currentScore2:FilterFrameText;
      
      private var _score:int;
      
      private var _fold:int;
      
      public function DDPlayExchangeFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __numberChange(param1:Event) : void{}
      
      private function __updateScore(param1:Event) : void{}
      
      private function __exchange(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
