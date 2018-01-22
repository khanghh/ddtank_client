package dayActivity.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   
   public class DdtImportantFrame extends Frame
   {
       
      
      private var _view:DdtImportantView;
      
      public function DdtImportantFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("AlertDialog.ddtImportant");
         _view = new DdtImportantView();
         addToContent(_view);
         PositionUtils.setPos(_view,"day.ddtImportantAdv.viewPos");
         addEventListener("response",__responseHandler);
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            TweenLite.to(this,0.5,{
               "x":900,
               "y":265,
               "scaleX":0.1,
               "scaleY":0.1,
               "onComplete":delayCompleteHandler
            });
         }
      }
      
      private function delayCompleteHandler() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         super.dispose();
         _view = null;
      }
   }
}
