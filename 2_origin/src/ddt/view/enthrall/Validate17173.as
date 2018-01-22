package ddt.view.enthrall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.manager.EnthrallManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class Validate17173 extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _okBtn:TextButton;
      
      public function Validate17173()
      {
         super();
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creat("asset.core.view.enthrall.Alert");
         addToContent(_bg);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _okBtn.y = _bg.y + _bg.height;
         _okBtn.x = 165;
         _okBtn.text = LanguageMgr.GetTranslation("tank.view.enthrallCheckFrame.checkBtn");
         _okBtn.addEventListener("click",__check);
         addToContent(_okBtn);
         titleText = LanguageMgr.GetTranslation("tank.view.enthrallCheckFrame.checkTitle");
      }
      
      private function __check(param1:MouseEvent) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setFlashCall");
         }
         if(EnthrallManager.getInstance().interfaceID == 1)
         {
            navigateToURL(new URLRequest("http://mygame.17173.com/ddt/fcm/"),"_blank");
         }
         else if(EnthrallManager.getInstance().interfaceID == 2)
         {
            navigateToURL(new URLRequest("http://fcm.duowan.com"),"_blank");
         }
         else if(EnthrallManager.getInstance().interfaceID == 3)
         {
            navigateToURL(new URLRequest("http://www.kaixin001.com/interface/realid.php?newpage=1"),"_blank");
         }
         else if(EnthrallManager.getInstance().interfaceID == 4)
         {
            navigateToURL(new URLRequest("http://youxi.baidu.com/i/my_info.xhtml?gid=108"),"_blank");
         }
         else if(EnthrallManager.getInstance().interfaceID == 5)
         {
            navigateToURL(new URLRequest("http://account.changyou.com/fangchenmi/submit.jsp"),"_blank");
         }
         else if(EnthrallManager.getInstance().interfaceID == 6)
         {
            navigateToURL(new URLRequest("http://web.4399.com/user/userinfo.php"),"_blank");
         }
         else if(EnthrallManager.getInstance().interfaceID == 7)
         {
            navigateToURL(new URLRequest("http://fcm.duowan.com/user/index.do"),"_blank");
         }
      }
      
      private function clear() : void
      {
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               hide();
         }
      }
      
      public function hide() : void
      {
         clear();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         hide();
         removeEvent();
         _okBtn.dispose();
         _bg = null;
         super.dispose();
      }
   }
}
