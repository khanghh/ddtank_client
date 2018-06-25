package microenddownload.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import microenddownload.MicroendDownloadAwardsManager;
   
   public class MicroendDownload extends Frame implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _ttlOfBtn:Bitmap;
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _treeImage2:Scale9CornerImage;
      
      private var _back:Bitmap;
      
      private var _bagCellList:Vector.<BagCell>;
      
      public function MicroendDownload()
      {
         super();
         initEvent();
         initView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _treeImage = ComponentFactory.Instance.creatComponentByStylename("microendDownload.scale9cornerImageTree");
         addToContent(_treeImage);
         _treeImage2 = ComponentFactory.Instance.creatComponentByStylename("microendDownload.scale9cornerImageTree2");
         addToContent(_treeImage2);
         _back = ComponentFactory.Instance.creatBitmap("microend.detail");
         addToContent(_back);
         titleText = "登录器礼包";
         _bagCellList = new Vector.<BagCell>();
         var awardsInfoList:Vector.<ItemTemplateInfo> = MicroendDownloadAwardsManager.getInstance().getAwardsDetail();
         for(i = 0; i < awardsInfoList.length; )
         {
            _bagCellList[i] = new BagCell(0,awardsInfoList[i]);
            _bagCellList[i].setCount(MicroendDownloadAwardsManager.getInstance().getCount(i));
            _bagCellList[i].x = 58 + i * 60;
            _bagCellList[i].y = 256;
            addToContent(_bagCellList[i]);
            i++;
         }
         _btn = ComponentFactory.Instance.creatComponentByStylename("microendDownload.ftxtBtn");
         addToContent(_btn);
         _btn.addEventListener("click",onMouseClicked);
      }
      
      protected function onMouseClicked(me:MouseEvent) : void
      {
         LeavePageManager.leaveToMicroendDownloadPath();
         close();
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_ttlOfBtn);
         _ttlOfBtn = null;
         ObjectUtils.disposeObject(_treeImage);
         _treeImage = null;
         ObjectUtils.disposeObject(_treeImage2);
         _treeImage2 = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         for(i = 0; i < _bagCellList.length; )
         {
            _bagCellList[i].dispose();
            ObjectUtils.disposeObject(_bagCellList.pop());
            i++;
         }
         _bagCellList.length = 0;
         _bagCellList = null;
         super.dispose();
      }
   }
}
