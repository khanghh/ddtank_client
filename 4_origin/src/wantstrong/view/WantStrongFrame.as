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
      
      public function WantStrongFrame(model:WantStrongModel)
      {
         super();
         _model = model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("wantstrong.view.scale9ImageBg");
         addToContent(_bg);
         _rightbullBg = ComponentFactory.Instance.creatCustomObject("wangstrong.ActivityListBg");
         addToContent(_rightbullBg);
         _huawen = ComponentFactory.Instance.creat("wantstrong.huaweng");
         addToContent(_huawen);
         _leftBorderbg = ComponentFactory.Instance.creatComponentByStylename("wantstrong.BG1");
         addToContent(_leftBorderbg);
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("wantstrong.BG03");
         addToContent(_rightBg);
         _wantStrongList = ComponentFactory.Instance.creatCustomObject("wantstrong.WantStrongList",[_model]);
         addToContent(_wantStrongList);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
               WantStrongControl.Instance.close();
               dispose();
               break;
            case 1:
               WantStrongControl.Instance.close();
               dispose();
               break;
            default:
               WantStrongControl.Instance.close();
               dispose();
               break;
            default:
               WantStrongControl.Instance.close();
               dispose();
               break;
            case 4:
         }
      }
      
      public function setInfo(data:* = null, stateChange:Boolean = false) : void
      {
         if(_state != data || stateChange)
         {
            _state = data;
            ObjectUtils.disposeObject(_currentContentView);
            _currentContentView = null;
            _currentContentView = ComponentFactory.Instance.creatCustomObject("wantstrong.WantStrongContentView");
            addToContent(_currentContentView as DisplayObject);
            if(_currentContentView)
            {
               _currentContentView.setData(data);
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _rightbullBg = null;
         _huawen = null;
         _leftBorderbg = null;
         _rightBg = null;
         _wantStrongList = null;
         if(_currentContentView)
         {
            ObjectUtils.disposeObject(_currentContentView);
            _currentContentView = null;
         }
         super.dispose();
      }
   }
}
