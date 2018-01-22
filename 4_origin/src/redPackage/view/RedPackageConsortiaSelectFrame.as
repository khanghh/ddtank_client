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
      
      public function RedPackageConsortiaSelectFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("redpkg.frameTitle.select");
         escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.redpkg.consortionSelect.bg");
         _bg.x = 16;
         _bg.y = 42;
         addToContent(_bg);
         titleText = LanguageMgr.GetTranslation("redPackage.consoritionSelect");
         _btnSendPkg = ComponentFactory.Instance.creat("redpkg.consortion.SendBtn");
         addToContent(_btnSendPkg);
         _btnGainPkg = ComponentFactory.Instance.creat("redpkg.consortion.GainBtn");
         addToContent(_btnGainPkg);
         addEvents();
      }
      
      private function addEvents() : void
      {
         this.addEventListener("click",onClick);
         addEventListener("response",_response);
      }
      
      private function removeEvents() : void
      {
         this.removeEventListener("click",onClick);
         removeEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.target;
         if(_btnSendPkg !== _loc2_)
         {
            if(_btnGainPkg === _loc2_)
            {
               SoundManager.instance.play("008");
               RedPackageManager.getInstance().showView("red_pkg_consortia_gain");
            }
         }
         else
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SoundManager.instance.play("008");
            RedPackageManager.getInstance().showView("red_pkg_consortia_send");
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_btnGainPkg != null)
         {
            ObjectUtils.disposeObject(_btnGainPkg);
            _btnGainPkg = null;
         }
         if(_btnSendPkg != null)
         {
            ObjectUtils.disposeObject(_btnSendPkg);
            _btnSendPkg = null;
         }
      }
   }
}
