package wishingTree.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import road7th.comm.PackageIn;
   
   public class WishingTreeRecordFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _desc:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _txtArr:Array;
      
      public function WishingTreeRecordFrame()
      {
         super();
         initView();
         addEvents();
         SocketManager.Instance.out.wishingTreeGetRecord();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("wishingTree.recordBg");
         addToContent(_bg);
         _desc = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordDesc");
         addToContent(_desc);
         _desc.text = "只显示最近20条许愿记录";
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wishingTree.scrollPanel");
         addToContent(_scrollPanel);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordVBox");
         _scrollPanel.setView(_vBox);
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(299,5),__getRecord);
      }
      
      protected function __getRecord(event:PkgEvent) : void
      {
         var i:int = 0;
         var date:* = null;
         var rewardId:int = 0;
         var rewardName:* = null;
         var recordTxt:* = null;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         _txtArr = [];
         for(i = 0; i <= count - 1; )
         {
            date = pkg.readDate();
            rewardId = pkg.readInt();
            rewardName = ItemManager.Instance.getTemplateById(rewardId).Name;
            recordTxt = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordTxt");
            recordTxt.text = LanguageMgr.GetTranslation("wishingTree.record",date.fullYear,date.month + 1,date.date,date.hours,date.minutes,rewardName);
            _vBox.addChild(recordTxt);
            _txtArr.push(recordTxt);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(299,5),__getRecord);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         for(i = 0; i <= _txtArr.length - 1; )
         {
            ObjectUtils.disposeObject(_txtArr[i]);
            _txtArr[i] = null;
            i++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}
