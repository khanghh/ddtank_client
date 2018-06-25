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
      
      private function setData(list:Vector.<DailiyRecordInfo>) : void
      {
         var i:int = 0;
         var item:* = null;
         var count:int = 0;
         ObjectUtils.disposeAllChildren(_vbox);
         for(i = 0; i < list.length; )
         {
            if((list[i] as DailiyRecordInfo).type == 8)
            {
               count++;
            }
            else
            {
               item = new DailyRecordItem();
               _vbox.addChild(item);
               item.setData(i - count,list[i]);
            }
            i++;
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
      
      private function __dataIsOk(event:Event) : void
      {
         setData(DailyRecordControl.Instance.recordList);
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 1 || event.responseCode == 0)
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
