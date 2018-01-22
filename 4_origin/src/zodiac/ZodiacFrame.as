package zodiac
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class ZodiacFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _mainView:ZodiacMainView;
      
      private var _rollingView:ZodiacRollingView;
      
      public function ZodiacFrame()
      {
         super();
         escEnable = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("zodiac.mainframe.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("zodiac.zodiacMainFrame.bg");
         addToContent(_bg);
         _mainView = new ZodiacMainView();
         PositionUtils.setPos(_mainView,"zodiac.mainview.mainview.pos");
         addToContent(_mainView);
         _rollingView = new ZodiacRollingView();
         PositionUtils.setPos(_rollingView,"zodiac.rollingview.rollingview.pos");
         addToContent(_rollingView);
         _mainView.setViewIndex(ZodiacControl.instance.getCurrentIndex());
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(ZodiacControl.instance.inRolling)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
               return;
            }
            dispatchEvent(new Event("close"));
            ZodiacManager.instance.hide();
         }
      }
      
      public function get mainView() : ZodiacMainView
      {
         return _mainView;
      }
      
      public function get rollingView() : ZodiacRollingView
      {
         return _rollingView;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.removeChildAllChildren(this);
         super.dispose();
      }
   }
}
