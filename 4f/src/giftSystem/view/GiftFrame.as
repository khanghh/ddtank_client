package giftSystem.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Bitmap;
   import flash.events.Event;
   import giftSystem.GiftManager;
   
   public class GiftFrame extends Frame
   {
       
      
      private var _giftView:GiftView;
      
      private var _firstOpenGift:Boolean = true;
      
      private var _back:Bitmap;
      
      public function GiftFrame(){super();}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
      
      private function showGiftFrame() : void{}
      
      private function initView() : void{}
      
      private function __createGift(param1:UIModuleEvent) : void{}
      
      protected function __onGiftSmallLoadingClose(param1:Event) : void{}
      
      protected function __onGiftUIProgress(param1:UIModuleEvent) : void{}
   }
}
