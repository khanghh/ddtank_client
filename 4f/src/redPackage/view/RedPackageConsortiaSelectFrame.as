package redPackage.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import redPackage.RedPackageManager;
   
   public class RedPackageConsortiaSelectFrame extends Frame
   {
       
      
      private var _btnSendPkg:SimpleBitmapButton;
      
      private var _btnGainPkg:SimpleBitmapButton;
      
      private var _bg:Bitmap;
      
      public function RedPackageConsortiaSelectFrame(){super();}
      
      override protected function init() : void{}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function close() : void{}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
