package ddt.dailyRecord
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class DailyRecordFrame extends Frame
   {
       
      
      private var _titleImg:Bitmap;
      
      private var _bg:MutipleImage;
      
      private var _vbox:VBox;
      
      private var _list:ScrollPanel;
      
      public function DailyRecordFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("ddt.dailyRecord.title");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.core.dailyRecord.titleImg");
         _bg = ComponentFactory.Instance.creatComponentByStylename("dailyRecord.bg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("dailyRecord.vbox");
         _list = ComponentFactory.Instance.creatComponentByStylename("dailyRecord.panel");
         addToContent(_titleImg);
         addToContent(_bg);
         addToContent(_list);
         _list.setView(_vbox);
         setData(DailyRecordControl.Instance.recordList);
      }
      
      private function setData(param1:Vector.<DailiyRecordInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         ObjectUtils.disposeAllChildren(_vbox);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if((param1[_loc4_] as DailiyRecordInfo).type == 8)
            {
               _loc2_++;
            }
            else
            {
               _loc3_ = new DailyRecordItem();
               _vbox.addChild(_loc3_);
               _loc3_.setData(_loc4_ - _loc2_,param1[_loc4_]);
            }
            _loc4_++;
         }
         _list.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         DailyRecordControl.Instance.addEventListener("recordListIsReady",__dataIsOk);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         DailyRecordControl.Instance.removeEventListener("recordListIsReady",__dataIsOk);
      }
      
      private function __dataIsOk(param1:Event) : void
      {
         setData(DailyRecordControl.Instance.recordList);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         if(_titleImg)
         {
            ObjectUtils.disposeObject(_titleImg);
         }
         _titleImg = null;
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
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
