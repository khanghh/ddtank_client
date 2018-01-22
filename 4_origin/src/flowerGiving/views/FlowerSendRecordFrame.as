package flowerGiving.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flowerGiving.components.FlowerSendRecordItem;
   
   public class FlowerSendRecordFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _infoArr:Array;
      
      public function FlowerSendRecordFrame(param1:Array)
      {
         _infoArr = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creat("flowerGiving.flowerSendRecordFrame.bg");
         addToContent(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendRecordFrame.vBox");
         addToContent(_vbox);
         _loc2_ = 0;
         while(_loc2_ < _infoArr.length)
         {
            _loc1_ = new FlowerSendRecordItem(_loc2_);
            if(_infoArr[_loc2_])
            {
               _loc1_.setData(_infoArr[_loc2_]);
            }
            _vbox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         super.dispose();
      }
   }
}
