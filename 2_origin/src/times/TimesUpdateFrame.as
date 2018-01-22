package times
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import times.updateView.TimesUpdateView;
   
   public class TimesUpdateFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _view:TimesUpdateView;
      
      public function TimesUpdateFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("AlertDialog.updateGongGao");
         _bg = ComponentFactory.Instance.creatComponentByStylename("timesUpdate.frameBg");
         addToContent(_bg);
         _view = new TimesUpdateView(TimesManager.Instance.updateContentList);
         PositionUtils.setPos(_view,"timesUpdate.frame.viewPos");
         addToContent(_view);
         addEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            delayDispose();
         }
      }
      
      private function delayDispose() : void
      {
         TweenLite.to(this,0.5,{
            "x":900,
            "y":265,
            "scaleX":0.1,
            "scaleY":0.1,
            "onComplete":delayCompleteHandler
         });
      }
      
      private function delayCompleteHandler() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         super.dispose();
         _bg = null;
         _view = null;
      }
   }
}
