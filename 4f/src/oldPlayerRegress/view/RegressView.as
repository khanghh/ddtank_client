package oldPlayerRegress.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import oldPlayerRegress.RegressControl;
   import oldPlayerRegress.RegressManager;
   
   public class RegressView extends Frame
   {
       
      
      private var _frameBottom:ScaleBitmapImage;
      
      private var _leftBackgroundBg:DisplayObject;
      
      private var _leftPattern:Bitmap;
      
      private var _goldEdge:ScaleBitmapImage;
      
      private var _rightFrameBottom:ScaleFrameImage;
      
      private var _regressMenuView:RegressMenuView;
      
      public function RegressView(){super();}
      
      private function _init() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
