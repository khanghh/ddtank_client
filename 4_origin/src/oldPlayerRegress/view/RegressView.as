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
      
      public function RegressView()
      {
         super();
         _init();
      }
      
      private function _init() : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ddt.regress.regressView.title");
         _frameBottom = ComponentFactory.Instance.creatComponentByStylename("regress.frameBottom");
         _leftBackgroundBg = ComponentFactory.Instance.creatCustomObject("regress.ActivityListBg");
         _leftPattern = ComponentFactory.Instance.creat("asset.regress.huaweng");
         _goldEdge = ComponentFactory.Instance.creatComponentByStylename("regress.jinbian");
         _rightFrameBottom = ComponentFactory.Instance.creatComponentByStylename("regress.frameRightBottom");
         _regressMenuView = new RegressMenuView();
         addToContent(_frameBottom);
         addToContent(_leftBackgroundBg);
         addToContent(_leftPattern);
         addToContent(_goldEdge);
         addToContent(_rightFrameBottom);
         addToContent(_regressMenuView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      public function show() : void
      {
         if(RegressManager.instance.autoPopUp)
         {
            RegressManager.instance.autoPopUp = false;
            LayerManager.Instance.addToLayer(this,2,true,2);
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,2);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               RegressControl.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_frameBottom)
         {
            _frameBottom.dispose();
            _frameBottom = null;
         }
         if(_leftBackgroundBg)
         {
            _leftBackgroundBg = null;
         }
         if(_leftPattern)
         {
            _leftPattern = null;
         }
         if(_goldEdge)
         {
            _goldEdge.dispose();
            _goldEdge = null;
         }
         if(_rightFrameBottom)
         {
            _rightFrameBottom.dispose();
            _rightFrameBottom = null;
         }
         if(_regressMenuView)
         {
            _regressMenuView.dispose();
            _regressMenuView = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
