package wantstrong.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import wantstrong.WantStrongControl;
   import wantstrong.model.WantStrongModel;
   
   public class WantStrongFrame extends Frame
   {
       
      
      private var _model:WantStrongModel;
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftBorderbg:ScaleBitmapImage;
      
      private var _rightBg:MutipleImage;
      
      private var _rightbullBg:DisplayObject;
      
      private var _huawen:Bitmap;
      
      private var _wantStrongList:WantStrongList;
      
      private var _state;
      
      private var _currentContentView:WantStrongContentView;
      
      public function WantStrongFrame(param1:WantStrongModel){super();}
      
      private function initView() : void{}
      
      private function removeEvent() : void{}
      
      private function addEvent() : void{}
      
      protected function _responseHandle(param1:FrameEvent) : void{}
      
      public function setInfo(param1:* = null, param2:Boolean = false) : void{}
      
      override public function dispose() : void{}
   }
}
