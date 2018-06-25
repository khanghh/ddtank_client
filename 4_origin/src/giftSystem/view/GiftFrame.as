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
      
      public function GiftFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("ddt.giftSystem.giftView.giftTitle");
         showGiftFrame();
         escEnable = true;
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
      }
      
      private function showGiftFrame() : void
      {
         if(_firstOpenGift)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onGiftSmallLoadingClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__createGift);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onGiftUIProgress);
            UIModuleLoader.Instance.addUIModuleImp("ddtgiftsystem");
         }
         else
         {
            if(!_giftView)
            {
               initView();
               _giftView = ComponentFactory.Instance.creatCustomObject("giftView");
               _giftView.y = 41;
               _giftView.x = 21;
               addToContent(_giftView);
            }
            GiftManager.Instance.canActive = true;
            SocketManager.Instance.out.sendUpdateGoodsCount();
            _giftView.info = PlayerManager.Instance.Self;
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.giftSystem.giftBack");
         addToContent(_back);
      }
      
      private function __createGift(event:UIModuleEvent) : void
      {
         if(event.module == "ddtgiftsystem")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",__onGiftSmallLoadingClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__createGift);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onGiftUIProgress);
            _firstOpenGift = false;
            showGiftFrame();
         }
      }
      
      protected function __onGiftSmallLoadingClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onGiftSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__createGift);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onGiftUIProgress);
      }
      
      protected function __onGiftUIProgress(event:UIModuleEvent) : void
      {
         if(event.module == "ddtgiftsystem")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
   }
}
