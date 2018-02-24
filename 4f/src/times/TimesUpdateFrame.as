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
      
      public function TimesUpdateFrame(){super();}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function delayDispose() : void{}
      
      private function delayCompleteHandler() : void{}
      
      override public function dispose() : void{}
   }
}
