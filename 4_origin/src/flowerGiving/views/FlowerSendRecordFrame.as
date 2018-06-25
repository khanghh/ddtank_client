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
      
      public function FlowerSendRecordFrame(infoArr:Array)
      {
         _infoArr = infoArr;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _bg = ComponentFactory.Instance.creat("flowerGiving.flowerSendRecordFrame.bg");
         addToContent(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendRecordFrame.vBox");
         addToContent(_vbox);
         for(i = 0; i < _infoArr.length; )
         {
            item = new FlowerSendRecordItem(i);
            if(_infoArr[i])
            {
               item.setData(_infoArr[i]);
            }
            _vbox.addChild(item);
            i++;
         }
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
